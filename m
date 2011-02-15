From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to safely remove a blob
Date: Tue, 15 Feb 2011 09:40:46 +0100
Message-ID: <AANLkTinrV3hKEva5qnaLniP+VoO2trrTVsWcc6YoBQ=t@mail.gmail.com>
References: <4D5A358F.2050906@ilt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rolf Wester <rolf.wester@ilt.fraunhofer.de>
X-From: git-owner@vger.kernel.org Tue Feb 15 09:40:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGSr-00027e-E8
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 09:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1BOIks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 03:40:48 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41335 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1BOIkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 03:40:47 -0500
Received: by bwz15 with SMTP id 15so213444bwz.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 00:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vwI84yNkQVlFdU3fZO8uYD7F6jIyg733zg4EeMrrNnU=;
        b=l8wfMk2wCnhnlloG5jHTVdfDlFJD0e4G/JtZXQITLlWTlRaNnPcFnmHyYzK7QoMv1Y
         GmLCsrfqNCZBLemrVEzaEbWyBuLDp3aCmXfGKWCs2UUgtxzc1ANohYHuzo7YDc5vywl4
         0VuT8PaBtqUyZejbKUiMvbd5LUdi6sUbFJht8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lk6iqi5533+M/oNqLDgksfsrizUEqhG303oxbDD8aYEramJifGUIJJM+gHTfEgxkpN
         L5YFG1DNPWn2imRNbiqMiqbu8lZ+XmS1uqa1W4Hr9OCpuCOsOCONy6bUMDPhrHutqUkT
         7nO+nypty0wVg+B7DRcoVmUWgw3T/n5TnBGXA=
Received: by 10.204.14.3 with SMTP id e3mr3635050bka.202.1297759246054; Tue,
 15 Feb 2011 00:40:46 -0800 (PST)
Received: by 10.204.102.14 with HTTP; Tue, 15 Feb 2011 00:40:46 -0800 (PST)
In-Reply-To: <4D5A358F.2050906@ilt.fraunhofer.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166825>

On Tue, Feb 15, 2011 at 09:13, Rolf Wester
<rolf.wester@ilt.fraunhofer.de> wrote:
> in one of my git repos I found an 102 MB object that probably came in there
> more or less occasionally.
> Its a blob and I would like to remove it safely. I tried to figure out how
> to do it but I was not very successful.

Take a look at "git filter-branch". There is even an example which
does exactly this (search for "git filter-branch --tree-filter").

> I guess simply deleting the file could corrupt my repo
> or at least the clones of that repo.

The repo itself.

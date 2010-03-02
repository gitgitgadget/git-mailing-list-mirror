From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: split up a repository
Date: Tue, 2 Mar 2010 11:40:41 +0100
Message-ID: <fabb9a1e1003020240h81f3e99wea1185c080a03b0@mail.gmail.com>
References: <20100302011226.76fda85d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Kovacs, Levente" <leventelist@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPXJ-0006Zc-Rg
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab0CBKlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:41:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41786 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0CBKlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:41:05 -0500
Received: by pwj8 with SMTP id 8so54224pwj.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=mL5q7bOii/ZfISh2rR2W34/V3KRZhZwcz2U52LdMIDc=;
        b=uF2uOSw39SV0EZsGe7ANcTy1RybIyGDWB4QjXCxzsOO3pMz8XyPdrRgqrU/pG1vpgr
         xc4QDR+JXuoHI3e/AnASan8/CQMRXfl9gQ217IA5cd3Xo0vbnzQm9LLiKGRNFXeloSCR
         j05yX3jUFb4pyyjqcsAdKJyXNtrM0O/L1ITAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BFamXlMWeS0/NY6cexScqKNPHFgu6BYxCWfgcnm18Y/PpKrfVfBwpwVc2D7ZOhrn2s
         3lxj0sVvxRmenEkZFdBmdgmx+tmvhvNGsCD4GBIV5MXhvjVb+qNItwR31tEmIpiVrww2
         LmqpyblKfZe8dWW/bNoAlPHJvPR09DROTYPG8=
Received: by 10.142.120.26 with SMTP id s26mr3331770wfc.157.1267526461185; 
	Tue, 02 Mar 2010 02:41:01 -0800 (PST)
In-Reply-To: <20100302011226.76fda85d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141379>

Heya,

On Tue, Mar 2, 2010 at 01:12, Kovacs, Levente <leventelist@gmail.com> wrote:
> How can I split up a single repo to several others? It would be nice to
> keep the history.

Sounds like a job for.... subtree man! Avery (cc-ed) has written a
program 'git subtree' that lets you split off subtrees from a git
repository (and optionally merge them back later on). I reckon that's
what you want, yes?

-- 
Cheers,

Sverre Rabbelier

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 17:22:07 +0100
Message-ID: <fabb9a1e1001270822u7727b0fdq3270ee5bb3ce546c@mail.gmail.com>
References: <1264608977-20665-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:22:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAf4-0004Kk-2c
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0A0QW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 11:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420Ab0A0QW2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:22:28 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:41384 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab0A0QW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 11:22:27 -0500
Received: by pzk2 with SMTP id 2so1357219pzk.21
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=YN83CYNnkiHMg7aoOjgFAaDqUIHJk0nAS7zrHl7eYTU=;
        b=CZObkJvJRCuxgAYxaVmEg3wCXjfV0qKQswXdDwNFj76XImIO237dX3N8H+ZVMcC0fg
         0XAf3lenW8nyaRzqaZiOEizofgTmc4w5EuWhL5RYwSovGX2uIk6t3LZ521wUVoMhoisW
         ebyRurK5bPRe3wOwvYCf2yX9h78qXmnqdXP7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Xz0/YRgQdh/yui6yX7op0loLBZkgNblTXwyAdEOz72d/riWyb4zGWHxetRhZIzuKKq
         6gJnn5zJogKtMlFfdTk3l6H7JBZF1ubtqteeJvHg56aMFTXJe9ROaoKapCtFd29lkAQW
         cmz70cIg6XPgLomjacWkCad1MG2PCnZzDZxdw=
Received: by 10.143.24.26 with SMTP id b26mr391455wfj.64.1264609347133; Wed, 
	27 Jan 2010 08:22:27 -0800 (PST)
In-Reply-To: <1264608977-20665-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138167>

Heya,

On Wed, Jan 27, 2010 at 17:16, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> it isn't likely anyone is using VCS setting and multiple
> push URLs, as VCS setting is meant for non-URL-based helpers

I don't like that assumption, I've used the vcs setting with regular
urls myself, is there a different way to solve this without
introducing that assumption? Also, what happens if one _does_ do that,
do we crash? abort?

-- 
Cheers,

Sverre Rabbelier

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT counterpart to "svn list"
Date: Thu, 22 Apr 2010 12:44:20 +0200
Message-ID: <m2r81b0412b1004220344j3101d7e6n7b2e9a017500db61@mail.gmail.com>
References: <20100421222237.1758ca66@pennie-farthing>
	 <4BCFC180.5020009@dbservice.com>
	 <20100421223716.6526f625@pennie-farthing>
	 <4BCFFDC7.4050205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jack Desert <jackdesert556@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 12:44:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4ttT-00045b-TT
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 12:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab0DVKoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 06:44:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48131 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0DVKoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 06:44:21 -0400
Received: by gwj19 with SMTP id 19so1974775gwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=+Ai27VvgoGUaYXF9WjjU9GasvIZvYbVEBDwrzlBeSVk=;
        b=SRTBZgrR+/FiCFpnzXWr2UYRUPVmpsFsyg23AsQzX6XCO0Shd3oYymMsVENDGKVIbB
         4xwPZrlBw8+H1UvKNJ804frwuhbtI5MbtGNl7a9kLs3+zdPO53ffuiOuJ6H+PPNvHzvD
         to8PN7tG/bNHVE0xmCgI6JtyBUr/udOkCGef0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fH2wkYK/GQdS3wDMZiP5cLRCJwX97hmNtQH/8v+1TKStvvVCWZSU38IO3bf2nNgiAy
         6A2F2qA+B0/k/dktqRPCDHGkuqDjCO4guY78zh4HgXM8SPFtLVuequd3FEgdAXHMx5+c
         lEBvF2/dd5D8lulV9tQmg89iRjtIPsyGKVPhg=
Received: by 10.100.121.19 with HTTP; Thu, 22 Apr 2010 03:44:20 -0700 (PDT)
In-Reply-To: <4BCFFDC7.4050205@drmicha.warpmail.net>
Received: by 10.100.29.20 with SMTP id c20mr23100629anc.167.1271933060411; 
	Thu, 22 Apr 2010 03:44:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145519>

On Thu, Apr 22, 2010 at 09:41, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> git ls-files does what svn list (without URL) does, and more. But git
> status [-s] may be what you are really looking for, ...

"git status -u" (to show the untracked files). The "-s" is just the
short format,
which is a nice thing, but not exactly what was asked. These can be
combined, of course:

 $ git status -su
  M git.c
 ?? RemoveMe
 $

The untracked files are marked by "??".

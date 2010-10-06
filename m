From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Subject: Re: Error on git clone
Date: Wed, 6 Oct 2010 11:22:32 -0700 (PDT)
Message-ID: <395557.10034.qm@web114610.mail.gq1.yahoo.com>
References: <571212.33119.qm@web114615.mail.gq1.yahoo.com> <4CAC54CB.5020208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 20:22:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3YdV-00006v-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 20:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645Ab0JFSWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 14:22:33 -0400
Received: from web114610.mail.gq1.yahoo.com ([98.136.183.55]:22672 "HELO
	web114610.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759582Ab0JFSWd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 14:22:33 -0400
Received: (qmail 10350 invoked by uid 60001); 6 Oct 2010 18:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1286389352; bh=ptabNiR2reXJrMnb1FMPLt4x1T595TFZkCPVpsIrbQg=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=yGMnA0KqoXdtc+9fGArSaGhCPEuAPEOG8a5frK2IC4t48WpJ3oM7sfBmZjJp+1XHVfb1imKwHlP0BSvLh7Fmx2UheBLeaWii/NgF7bnER4HQLyKG7HOe60kNEltByEYha/7bIFse3JkwWSnE2ob5n6vGT5eo32bGWPjP8Ff0gbo=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=EqvA6EfRaPvNd460DYd8BLZZFjGLS8vM3U9bPM3TT7UzgMHasWLDWWx1Po4UootF/mnKyrwisnE04ckRPhMHixhNXmMk9IGq1PCHdKPl9ewC//pubRelux4Pu8TzH7ePoGZBH99m/jvLKEt8R2uUQ2qU38HB119z4DnGruiB0QE=;
X-YMail-OSG: ECNp.YkVM1k2CcDIkGV_lakQaZmUWrxW53qMG3fW2SIT1U2
 FoGZahcIfUucQ5qb1N2Lu_YZMjhIW379kbv_oRTgql8ABTJfk8lAxa3VMKGP
 R5I8O.oBUyBN1.2fsW0nBU6iooon4owFM65kl6dlm3Es6Agn94CqJ.Zk6l.i
 s73f9_ZjEjZ8gBclbsIoDgGjbVS.CEwTGMSPipw2ou2I_X0gFBIA7GmMTkgE
 rJlMU5QwkhARCMbVyhxO8Lo9N54YGobxLaH2T0c.btHCHFTQv3jOH84BxS.I
 mXK2oE7Zp0knbt0lS
Received: from [76.83.7.252] by web114610.mail.gq1.yahoo.com via HTTP; Wed, 06 Oct 2010 11:22:32 PDT
X-Mailer: YahooMailRC/497 YahooMailWebService/0.8.105.279950
In-Reply-To: <4CAC54CB.5020208@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158299>

Hi Hannes,

As you have expected, when I run that command,
    git -p ls-tree -r origin/master > lll.txt
and redirect it to a log file, the log file does show some lines that have:
    "public/images/tagging\rtagging/title_add_tags_to.png"

THANK YOU SO VERY MUCH for helping me in resolving the problem that I have 
encountered with the git clone command on my PC Windows XP system.  I'll 
definitely ask my upstream to fix the
repository on that 'CR'.  I'll also take a look at that "sparse checkout" that 
you have mentioned.

Again, a big thank you for solving this perplexing problem, especially with the 
print over log messages.  You rock!!!
Hoca




----- Original Message ----
From: Johannes Sixt <j.sixt@viscovery.net>
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Cc: git@vger.kernel.org; Sverre Rabbelier <srabbelier@gmail.com>
Sent: Wed, October 6, 2010 2:51:55 AM
Subject: Re: Error on git clone

Am 10/6/2010 12:34, schrieb Hocapito Cheteamo:
> $ git fetch
> Enter passphrase for key 'C:\.....\privateKey':
> remote: Counting objects: 478, done.
> remote: Compressing objects: 100% (303/303), done.
> Receiving objects: 100% (478/478), 96.57 MiB | 166 KiB/s, done.
> Resolving deltas: 100% (21/21), done.
> From github.com:XXX/YYY
>  * [new branch]      master     -> origin/master

Ok, download works as expected. You don't have to repeat these steps
anymore. Keep a copy of sss3\.git around so that you can go back to this
state when necessary.

> $ git checkout -b master origin/master
> Checking out files: 43%
> tagging': Invalid argumenttory at 'public/images/tagging

The error message is this one:

cannot create directory at '%s'

Do you have a file/directory with a CR in it? When you run this:

git -p ls-tree -r origin/master

and look for public/images, do you see this:

"public/images/tagging\rtagging"

(including the double-quotes)? If so, ask your upstream to fix the
repository; you can't checkout the data as is on Windows.

Alternatively, you could use a sparse checkout that excludes the
questionable file. Read "Sparse checkout" in
http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html

-- Hannes



      

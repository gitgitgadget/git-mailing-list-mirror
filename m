From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: updating github.com forks, developing in remote branches and 
	svn:eol-style equiv?
Date: Sun, 28 Mar 2010 12:07:14 -0500
Message-ID: <15b345f1003281007r3e8b3e86p787f9ef554054adf@mail.gmail.com>
References: <15b345f1003272332u2f4d38ear5c8aeef9b35f5037@mail.gmail.com>
	 <158811269761123@webmail102.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Iljin <ajsoft@yandex.ru>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:07:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvxR-0006aO-AO
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab0C1RHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 13:07:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53097 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab0C1RHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Mar 2010 13:07:15 -0400
Received: by pwi5 with SMTP id 5so6093294pwi.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nGMwLc5frxnCw28QpRGVRZ2NoUcsJWDpM2XgEdLTz2c=;
        b=rRFW39r4UFRhvnRPquL5NRrlPBYN/C8ubpjYAIcHCrrt4XFwCVrPUl19ywz3Rv/Tgu
         egnG44OR+iswHmRXmZGk6TEOIWN9Nzhu1ZQEvJdC1rmQuOim6AgMBN+bd9+xq/xlh92m
         WWqBjS0dhTAaar0coJiyvNO7VN0ZtGvEyNT/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ef+RDMnIBvjmeET62OClrFmhF9hrs2Ubt040fHzXku5nw07/YOikErTJUutXlZEFRq
         UXY/K2/3qkIV/C/1ZsTPTYJOK1LLrAdtf+GakmNRqZKcN92tD6RiJKR1QWiR6mQrHQcF
         0dm847Cv6jNtJrAf4zLsG397NfbpHudqfYwl8=
Received: by 10.143.167.17 with HTTP; Sun, 28 Mar 2010 10:07:14 -0700 (PDT)
In-Reply-To: <158811269761123@webmail102.yandex.ru>
Received: by 10.142.202.4 with SMTP id z4mr1562500wff.294.1269796034428; Sun, 
	28 Mar 2010 10:07:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143403>

On Sun, Mar 28, 2010 at 2:25 AM, Alexander Iljin <ajsoft@yandex.ru> wro=
te:

> =A0You should do it the way you described - via local repository, bec=
ause you
> =A0might need to resolve conflicts along the way.
> =A0There is the "Fork Queue" feature on GitHub, you may give it a try=
=2E

In playing around with their Fork Queue feature...  I have a week old
fork to which I've made no changes.  I do "Select All" for al the
changes in teh original fork and then select "Apply" in the drop down
"Actions" menu.  It then just sits there doing nothing.  It says
"Status: Processing 1 of 8 Commits" and that's it.  Shouldn't it
actually be doing something?

>  To have a local branch you should create it:
>  git checkout -b branchName remotes/origin/branchName
>  Remote branches are there only to track the state of the remote repo=
,
>  you should only commit to local branches and then push your work to
>  remotes.

I think I figured out some of my confusion - there's a "Create New
Branch" checkbox in the "Checkout\Switch" dialog that needs to be
checked that isn't by default.  I guess the idea is that, by default,
TortoiseGit assumes you want to make the branch you checkout the
default branch?

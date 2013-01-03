From: Tobias Preuss <tobias.preuss@googlemail.com>
Subject: =?UTF-8?Q?Fwd=3A_git=2Dgui_=2F_Warning=3A_=22No_newline_at_end_of_file?=
	=?UTF-8?Q?=E2=80=9D?=
Date: Thu, 3 Jan 2013 13:26:59 +0100
Message-ID: <CADEaiE8GKfSQ5u+0bb8qtBe-3OTYJThGb-UFLU_pM-T9ZqvkiA@mail.gmail.com>
References: <CADEaiE-J4nEwyK4WSiH=zzaH6cb85mw15O3wxrWrTXJtZfJixQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 13:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqk0Z-0006x3-R4
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 13:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab3ACMed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 07:34:33 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57367 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3ACMeb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 07:34:31 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2013 07:34:31 EST
Received: by mail-wi0-f182.google.com with SMTP id hn14so8512840wib.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=sOycdtVEnYeonHfvJW4wHxK62UYN+jTrrq7i/PfZtkQ=;
        b=Jn053gqpL+Mf6pmBebY+fWUYtpAKlcP0secI0eSzbMgevb5zj5DE4e13Ftow/fApuI
         g7tjf9wy92Cl3mCC0rYGU2iJH3ILr8g0slDr4Q7OsSzDlLHIo9QJQhKyzGHWHX1z/qer
         FLiT42RHoBC1USUkGjTTUTCFsyP8dPYTUOV6NofbcMp9Kfr8PaAHFg03VosXOPf3hkOY
         3wXREiCO2g4fiyzgrqVb7UanFHqFaqRcmlt5X7SaqqZh2UguFDONrP+kU1PkIVH8cHiD
         NYG6ZuU/r3gVNFfrPmvMp+/iYWtrWqRrz1nKa/89UfsvdFEbVNAIjbO4QAyz5rkflhDw
         8J9Q==
Received: by 10.194.76.99 with SMTP id j3mr78551227wjw.47.1357216039674; Thu,
 03 Jan 2013 04:27:19 -0800 (PST)
Received: by 10.216.29.75 with HTTP; Thu, 3 Jan 2013 04:26:59 -0800 (PST)
In-Reply-To: <CADEaiE-J4nEwyK4WSiH=zzaH6cb85mw15O3wxrWrTXJtZfJixQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212581>

Hello. I never got a response. Did my email pass the distribution
list? Best, Tobias


---------- Forwarded message ----------
=46rom: Tobias Preuss <tobias.preuss@googlemail.com>
Date: Tue, Nov 13, 2012 at 9:26 PM
Subject: git-gui / Warning: "No newline at end of file=E2=80=9D
To: git <git@vger.kernel.org>


Hello.
I noticed a problem when working with git-gui which might be a bug.
The issue only affects you when you are visually trying to stage
changes line by line. Here are the steps to reproduce the problem:

1. Initialize a new repository.
2. Create a file with three lines of content each with the word
"Hello". Do not put a new line at the end of the file.
3. Add and commit the file.
4. Edit the same file putting words inbetween the three lines.
5. Open git-gui and try to stage the changes line by line.

The editor will append the warning "No newline at end of file=E2=80=9D =
to the
end of the diff. When you are trying to stage a line an error occurs.
The problem is also illustrated in a question on Stackoverflow [1].

Please let me know if you need more information or if I should send
this problem to some other mailing list.
Thank you, Tobias

____________
[1] http://stackoverflow.com/questions/13223868/how-to-stage-line-by-li=
ne-in-git-gui-although-no-newline-at-end-of-file-warnin

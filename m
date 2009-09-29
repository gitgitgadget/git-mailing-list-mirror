From: "A. S. Budden" <abudden@gmail.com>
Subject: Git problems with adding files (first use)
Date: Tue, 29 Sep 2009 10:17:21 +0100
Message-ID: <1ddea54e0909290217o45b2e89j3b023821a4871b41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 11:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsYqD-00066E-Fp
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 11:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZI2JRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 05:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbZI2JRU
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 05:17:20 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:37379 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZI2JRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 05:17:18 -0400
Received: by bwz6 with SMTP id 6so1843105bwz.37
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=vt2sf0VK0c4T9UkgjwpAcvQNS+p1YdpqcA5FZWjuq9A=;
        b=yGzg/9VKdKxaPiDy/ZAtA5S4sCxiLOIW/42/5lXNzdyoCL1d6GfQ5R+50VTPSK+UIs
         wowrQxu+/Hx1kNVNrWm/5Pc0ujPsZQ2AIcq3wdLfleq+r8PSYlgG8a8g557Ai0bArqKA
         LJTZvqEKL3ocbh2j+xT66g0PiqTObzU3ftJWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=t6geLU6UFEy8i9vz8MlMmOIinSxsIAH8WrEmKQYvimUMaUkkPmktJpx6Q0Mt5KUAfX
         STzpmXbtFAFh5NZrKAW5k7ItBpUlnP1QvoSEP15cdZF6Xv4urY5XqJP5ugpPc8MT55lv
         Dxw7/go3uqmSq0ANmaN77zlUY1wtSrhjX883M=
Received: by 10.223.58.208 with SMTP id i16mr1049618fah.22.1254215841247; Tue, 
	29 Sep 2009 02:17:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129292>

Dear all,

I have just installed Git from the msysgit distribution
(Git-1.6.4-preview20090730.exe).  I've also installed TortoiseGit
(1.0.2.0).  I've been having a few problems adding files (either using
tortoise or the command line tools).

What I did (copied and pasted directly from the command window):

=============================================================
Z:\>mkdir testproject
Z:\>cd testproject
Z:\testproject>echo "test file" > file1.c
Z:\testproject>echo "test file" > file2.c
Z:\testproject>git init
Initialized empty Git repository in Z:/testproject/.git/
Z:\testproject>git add file1.c
error: unable to create temporary sha1 filename .git/objects/f7/tmp_obj_a02340:
No such file or directory

error: file1.c: failed to insert into database
error: unable to index file file1.c
fatal: adding files failed
=============================================================

Can anyone tell me what I'm doing wrong?  I've tried using tortoise
git and I've tried it on an existing project (rather than a bunch of
random files), but I can't seem to add files to the repository: I
always get the "No such file or directory" error.

Thanks in advance for your help.

Al

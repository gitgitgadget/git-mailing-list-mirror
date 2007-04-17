From: "Joan Ripoll Balaguer" <joan.ripsa@gmail.com>
Subject: checkout Error on cygwin
Date: Tue, 17 Apr 2007 15:08:12 +0200
Message-ID: <5c08a49c0704170608s4f643bf6ubc53d521149f2d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 15:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdnPt-0003YJ-MW
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 15:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbXDQNIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 09:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXDQNIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 09:08:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:27464 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbXDQNIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 09:08:14 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2301742muf
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 06:08:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JOWloRNNWnFRGW8PWFhJLwtSqMUPq23Cfdz1jja4EaEJKGnqXUrphPlTt2iSx81uaRKEKxL6h6GAX+Gsz2s5701Ln/FocP3jzbHaglgbMvfpWz1LuMW1WS1YnxarfIGYMAkd+KlDAzT3aKnOPuYVkU7oQmXleAG6DNU9tFsUIWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lp+fzbBXU+TAjZhsPsGo6VYJhpkbLvdgZqtMA4H5S6RRUXSAKvqgCXcPRVlrroO5UcnlnVd177ryUo42/1+nDu0ig63BJEgTAfwxdDRsh8oVk0+c/slJN5thUW9FDVPwTzYPaCIAv8x9FLdMKeNpRuh6MMALtrSJKaDe/ra/YKA=
Received: by 10.82.108.9 with SMTP id g9mr5515796buc.1176815292227;
        Tue, 17 Apr 2007 06:08:12 -0700 (PDT)
Received: by 10.82.191.9 with HTTP; Tue, 17 Apr 2007 06:08:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44763>

$ git version
git version 1.5.1.1.135.gf948

$ git status
# On branch cajal/20070201
nothing to commit (working directory clean)

$ git checkout master
      6 [main] git-read-tree 2640
C:\cygwin\usr\local\bin\git-read-tree.exe: *** fatal error - could not
load shell32, Win32 error 487

Then:

$ git status
# On branch cajal/20070201
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
 (A lot of files)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
 (A lot of files)


Now I would have an clean status:

$ git reset --hard HEAD
fatal: unable to create '.git/index.lock': File exists

$ rm .git/index.lock

$ git reset --hard HEAD

$ git status
# On branch cajal/20070201
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
(A lot of files)
nothing added to commit but untracked files present (use "git add" to track)

$ git clean -x
Removing ... (a lot of files)

Any suggestion?

-- 
Joan Ripoll
joan.ripsa@gmail.com

From: David Salib <dsalib@fibrenoire.ca>
Subject: bug in os x - deleted file on clone
Date: Thu, 3 Jul 2014 11:53:28 -0400
Message-ID: <CAG+Rngi4q_Se0dGUKLuSEmub=srrhtDNfEh5n977DL+XZxJjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 17:53:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2jKX-0000PT-E7
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 17:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759258AbaGCPxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 11:53:30 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57464 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759253AbaGCPx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 11:53:28 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so426395pdb.7
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=yvcsKEMO9Lgq3oGQtStrsy4/3GMwD5AcAcQWN0j1LBk=;
        b=NTApM4sfVlV/OPx2XOP4R6ELuQinfU2fmkF7n7al5XlB2Kt/h3wUlPtjtn3I10oHd+
         lq2/mRdmV5nEXpzpDa43AHsFl9DxZtbdd838TjeyIXFx2i5aUMH+22Owx7vzKCpyBwq5
         xQBmpYnM76y7CKNJ5Pyjzh02VSxowd/Z8x/ocIxfr3UNi4pMsKCx3FSfN+HZE5beciBZ
         oey10FMMq4pNulW/ADLylR3Vrur5QGnuv8oCQRIxK5cLeCgvwknQkH0C1lb9uLPqQS9K
         Q2Whlq+NA72hX/Iim82ajzdbyYyqCAP4sCXiiiWqZFT022W5VtMifCOzPvchLWkRm61u
         r7tQ==
X-Gm-Message-State: ALoCoQlTM4iXFUWyscG+4sUhbeygzOgUIOe1Ktj2lXv4YiWPjF2NbmubHrLa4tjMPjY2ncGcTAg5
X-Received: by 10.67.14.37 with SMTP id fd5mr5650497pad.72.1404402808460; Thu,
 03 Jul 2014 08:53:28 -0700 (PDT)
Received: by 10.70.102.227 with HTTP; Thu, 3 Jul 2014 08:53:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252867>

Hello,

When I clone a repository using git on osx this happens :

------------

grandmesse:code dubbed$ git clone ssh://git@[snip]/puppet.git
Cloning into 'puppet'...
remote: Counting objects: 5313, done.
remote: Compressing objects: 100% (4086/4086), done.
remote: Total 5313 (delta 2200), reused 2996 (delta 841)
Receiving objects: 100% (5313/5313), 2.07 MiB | 0 bytes/s, done.
Resolving deltas: 100% (2200/2200), done.
Checking connectivity... done.
grandmesse:code dubbed$ cd puppet
grandmesse:puppet dubbed$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working direct=
ory)
deleted:    modules/areversat-nidautoprov/files/dhcp/staticDHCPd/static=
DHCPd
no changes added to commit (use "git add" and/or "git commit -a")

-----------------

This does not happen under linux so the repository isn't the issue.

Thanks,

D


--=20
David Salib
Sp=C3=A9cialiste syst=C3=A8mes / Systems specialist
=46ibrenoire - www.fibrenoire.ca
A: 550 ave Beaumont, suite 320, Montreal, Qc, H3N 1V1
T. 514 907-3002 x133

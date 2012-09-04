From: =?windows-1251?B?yu7t/Oru4iDF4uPl7ejp?= <kes@reg.ru>
Subject: Feature request: short cuts for git add /diff etc
Date: Tue, 4 Sep 2012 15:25:42 +0400
Organization: =?windows-1251?B?0OXj6PHy8ODy7vAgxO7s5e3t+/UgyOy47Q==?=
Message-ID: <6110218480.20120904152542@reg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 13:26:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8rGW-0005Ws-0b
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 13:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab2IDLZt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 07:25:49 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41064 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab2IDLZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 07:25:48 -0400
Received: by eekc1 with SMTP id c1so2375353eek.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reg.ru; s=google;
        h=date:from:x-mailer:organization:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DQrtWEs/MtJpPAtHRwIncHnUMtw7cIvK45vEnJI+YIs=;
        b=m/IH3SrDzqMPfk4wfjGc7MZdCTkOGEWAHsE2ArpUxOHwoQISEmNubjFqfANgtOI3aj
         UkaalXiYg0dWnTbnBF0TcS/uju4VPExeRN9qYIntvr+UpqTuES80v49ivZtVn3skfas4
         f0avSegUfA2QB0WzipCoplXQdpdFFcBRkYSII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-mailer:organization:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=DQrtWEs/MtJpPAtHRwIncHnUMtw7cIvK45vEnJI+YIs=;
        b=nRHVMgeDuaOGr2cRUaukEohob/WUgw++yZbYEOvJg67/cvdYzm8cKV3ALWgsEcUIpP
         rjfFac86WBToAOlxBa+BvgzjhSL5qey7cT7h0cuA8X0s8dn72665G2gOPpf8R458/jU5
         7tTQVlFb+1TrSBYxS5gNKF+k4R5h782DKDyCWrwwV0Vb7aSjqmFaJlmHJT4gfHEEYDrT
         ccsl689pbKOo/V5ggKQKnuCUAgh+Mdd98ewmf8G22uQ9ogPL/fk6gM93zS/wYDl1xSCW
         fErkpIOm4xvpUsxx9uyRqdw4j6ZaGMicj0p9LefSabR2LndyKUEVGyTNm8JtQKR79OtY
         d7Gg==
Received: by 10.14.5.78 with SMTP id 54mr25923987eek.1.1346757946958;
        Tue, 04 Sep 2012 04:25:46 -0700 (PDT)
Received: from KES-PC ([77.93.52.13])
        by mx.google.com with ESMTPS id r45sm44623717eem.6.2012.09.04.04.25.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 04:25:45 -0700 (PDT)
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
X-Gm-Message-State: ALoCoQmu8ZYLMHEb0sw1bXAQ7jymxUD5hPbmpkNl9IDpXn5C8fmAuHQDsVjbj/oZMXva7HXEGYF+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204737>

Hi, Git

Change this:
# git status
# On branch yandex_mail_new_api
# Your branch is ahead of 'origin/yandex_mail_new_api' by 2 commits.
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   a1.txt
#       modified:   a2.txt
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       new.txt

to this:

# git status
# On branch yandex_mail_new_api
# Your branch is ahead of 'origin/yandex_mail_new_api' by 2 commits.
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified(1):   a1.txt
#       modified(2):   a2.txt
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#   (3)    new.txt


sot this allow:
git diff 1       same as        git diff a1.txt
git diff 2       same as        git diff a2.txt

git add 1        same as        git add a1.txt
in case there are may be files with such names I may appply option -s,f=
or example
git add [ -s | --stage ] 1 . This will force to add file from list of
'git status' and do not use '1' as file name.

git add 3        same as         git add new.txt


This very handy and will keep developer from useless typing =3D)

--=20
 =D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC,
 =CA=EE=ED=FC=EA=EE=E2 =C5=E2=E3=E5=ED=E8=E9
 =CF=F0=EE=E3=F0=E0=EC=EC=E8=F1=F2
 =D0=E5=E3=E8=F1=F2=F0=E0=F2=EE=F0 =E4=EE=EC=E5=ED=ED=FB=F5 =E8=EC=E5=ED=
 REG.RU
 =D2=E5=EB=E5=F4=EE=ED: +38 (097) 7654-676
 www.reg.ru
 ___________________
 Sincerely yours,
 Konkov Eugen
 Developer
 Accredited domain Registrar REG.RU, LLC.
 Phone: +38 (097) 7654-676
 www.reg.ru/en/

mailto:kes@reg.ru

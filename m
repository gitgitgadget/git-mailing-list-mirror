From: =?windows-1251?B?yu7t/Oru4iDF4uPl7ejp?= <kes@reg.ru>
Subject: merging branches
Date: Mon, 22 Oct 2012 20:33:23 +0400
Organization: =?windows-1251?B?0OXj6PHy8ODy7vAgxO7s5e3t+/UgyOy47Q==?=
Message-ID: <1393648016.20121022203323@reg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 18:33:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQKwd-0005y5-4n
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 18:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab2JVQd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 12:33:27 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45517 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab2JVQd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 12:33:26 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2369347wgb.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reg.ru; s=google;
        h=date:from:x-mailer:organization:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GP5hPBoSEM+XRAl2KXxz9N1QU0Sh4PTV4w+HzEBXBas=;
        b=EOgBHXV2ye0MzcmAyddI/k9qiST+DYbl9XQDRZe5lsLVSeBGCldIRlHxmeRld/dRdF
         AlMCsIyBq4VPI30IJMz/qtt0cf7Kfcl0gqOLu9Vje1PmgEzWyrvhxTvUunO+IHpMs+Hm
         ZoG8U39YgEUhnimFzQWrTU151IREnC82NqrLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-mailer:organization:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=GP5hPBoSEM+XRAl2KXxz9N1QU0Sh4PTV4w+HzEBXBas=;
        b=jn+LUer38lmKLap+dTjJ3m3f+Cbgyya6F4lIszn5eiX3n/vAD/VFwVKD+fQab3tRjS
         VTEYFkYTfnW88pAHOfBFqwjwto/OoFnswLKt+0cX0rSL6JL9pCgrurMI1lg0CEgMq8qi
         VTtiPuemzJSZNyOLASiNrX8RHjW0/aTulDLGmWQ14nzecveqKs4uxTz393ZbMXgEkKEE
         3T1qJf7xD5UCmOqD9fF8q61sG44TfhhzYLPiXhFTS+6NbROdJkQiROtsOQvN846VzF7U
         KQTvv7KEsRaPpmlhnsyKhXaQbw6plh2oBBZ/IqMHQ30BO6kRvIQ97IgkZxYDugN5zOmM
         AZsw==
Received: by 10.180.84.202 with SMTP id b10mr22517730wiz.13.1350923604424;
        Mon, 22 Oct 2012 09:33:24 -0700 (PDT)
Received: from KES-PC ([77.93.52.13])
        by mx.google.com with ESMTPS id hb6sm15007939wib.7.2012.10.22.09.33.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 09:33:23 -0700 (PDT)
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
X-Gm-Message-State: ALoCoQnHto3b4Ry0tu30RuOrnSxNuzqxT0w8Y9OJQEJrwW1+2hOcqrsathFtsx8rzWFxP92AHp4n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208197>

Hi, Git.


While merging branches I get conflicts in files that I have not touch.
Why they occour??

My suggestion is that that files that was automerged GIT counts as
they were modified by me, so next automerge to those files fill FAIL.

If so, how I can escape from that CONFLICT situation?


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

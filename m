From: Bertrand BENOIT <projettwk@users.sourceforge.net>
Subject: Bug report - local (and git ignored) file silently removed after checkout
Date: Sun, 20 Nov 2011 14:42:36 +0100
Message-ID: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 14:42:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS7fO-0001nc-KN
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 14:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab1KTNmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Nov 2011 08:42:37 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41601 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab1KTNmh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2011 08:42:37 -0500
Received: by yenq3 with SMTP id q3so3867066yen.19
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=WN40Z3800IijdgH72cnT8Ik3uk21t1Qy/q2xRoJZpZY=;
        b=MZpUW7FTugfAX1wjsquUzrqcov9yjRLsjHPhotFUkANwj8jHrveKTjxLdUKgJxqUvJ
         OMBIj0HwhtS2EItBgGFpY9pFeT/om6b9xGmY81wKDD5zFXgePu+ASURIS0LvwuzH6xmn
         13skBllU2x4WrdNJwJ5pWFAMCu6+FgsYmdbuE=
Received: by 10.182.188.34 with SMTP id fx2mr2248068obc.31.1321796556658; Sun,
 20 Nov 2011 05:42:36 -0800 (PST)
Received: by 10.182.15.133 with HTTP; Sun, 20 Nov 2011 05:42:36 -0800 (PST)
X-Google-Sender-Auth: hpd_t2jl5CyVQem5DhtofrNH2QE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185724>

Hi,

In a (special ?) situation, I've lost a local (and git ignored) file
silently, and I've failed to get it back.

Context:
  - in previous version of my project, the TODO file was versioned
  - in current development version, this file is NO more versioned AND
it is ignored by a gitignore rule, but still at the same place for
better ease of access -> such a way, this file has been locally
updated several times
 =C2=A0- during worflow process, I've finally performed a checkout on a
previous version (in which the TODO file was versioned) -> after that
the file has been silently updated with the old version
  - after modification, I've performed back a checkout on the current
version and this time my TODO file has been fully and silently removed

Questions:
  - is it a behavior regarded as normal ?
 =C2=A0- is there any way to get back the TODO file, in LOCAL version i=
t
was before the first checkout ?
 =C2=A0- in any case, is there any way to be warned (and to make the
checkout fail) of such situation (local ignored file being overwritten
with 'older' not-ignored version) ?

Thx,
Best regards,
TWK

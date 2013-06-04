From: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Subject: git archive --worktree-attributes doesn't exclude .gitattributes anymore
Date: Tue, 4 Jun 2013 23:18:59 +0100 (BST)
Message-ID: <1370384339.31882.YahooMailNeo@web172702.mail.ir2.yahoo.com>
Reply-To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 00:19:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjzZL-0006Eu-Ot
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 00:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab3FDWTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 18:19:03 -0400
Received: from nm13-vm0.bullet.mail.ird.yahoo.com ([77.238.189.195]:38511 "HELO
	nm13-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750811Ab3FDWTB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 18:19:01 -0400
Received: from [77.238.189.52] by nm13.bullet.mail.ird.yahoo.com with NNFMP; 04 Jun 2013 22:18:59 -0000
Received: from [212.82.98.66] by tm5.bullet.mail.ird.yahoo.com with NNFMP; 04 Jun 2013 22:18:59 -0000
Received: from [127.0.0.1] by omp1003.mail.ir2.yahoo.com with NNFMP; 04 Jun 2013 22:18:59 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 895791.61453.bm@omp1003.mail.ir2.yahoo.com
Received: (qmail 50474 invoked by uid 60001); 4 Jun 2013 22:18:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s1024; t=1370384339; bh=YwqYXPZljZVtAUi//ou9nOo1HOaAYKFnquImH5XaSnc=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Bex5zoEpK9nAgivyfuA3rDOZsD8puzCrF7N3FXdkRWVUk4pgo0aXQZK7UYNNc2DUJI7bbal01WIA2cOqKqJ/vHJn9zgnFgsgYMGES9ZJNiVKNa98NN8a1dVHL5xA6uyKhhVUbTGoprholLI83X9C7cifkX3lWt/EZyKLDPhjPME=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aRmVNoueHIyHr0Ju+F+/m6tHNrIYrShisFO/zMzs/cY9eeEtMzS5veJEhWKTuDfFHrxAMPPfwDyEmmYontI/n+GDQvD9bOisc8jDkkhF4ro0X8rCwax5FWuIkE90cU6/wF+MCp2SWmcMhv0t6qh2Zo7601TTdGkuMCiPzAvzJUA=;
X-YMail-OSG: 0Q_La6kVM1kfqlQ4Pg8E4ejx1wXMA.tuYZL023RR0lW7kaK
 0RL_cF98I2kWIYv3NM70QL0KV24SNHNFhVgTjcUpjeKixmfZJAHQjdPA_wyW
 xDSGOI0v1VVdh5qg8ztZ63aC6lvdGUN.uKimU5vdqAuXlo_gejYK8R283xjY
 avrddHdI3Xmc8yu2XeTYypk1k41CRsrmxktL0C.FUY1TjWu2VyVTCL7aAbvG
 yXyJxU5B8_JM6QQXN4ooHkvGpITZmLaMiOk7sRahy9Nb7C1dfT.Px61tRXeH
 hr.69BZSmF.ueBuFuzQ6BiW9wWpra56wVW3.MwSkCjdQmCSVn13O.AVhDQ99
 FkAIdIlNckZhdNed4lAiCVuu5sa_7eGGWOh3dyO3JYu6KLExdEw8sZoQIcOs
 6jlUTbSxPvmF6qGcJuzWb9YJglx1UWJTS9KmQnyykgtv2.D9pAwSUeyGAiY.
 4ygoF7q6fb8xsg7Yq.mdGFFySszPLOOraMbr5W.1gwwYEe9A4uDzolx5.F1N
 DiWgyh8F7vKbm3RdO8lVwqYI81YDLWpYFZBuMdFeponWimnZUWGDU98GtecI
 qDJtOXeNcP0UGF6g6kno.kkhMKfLpllzfojV3NRpKgLpEm4MQJfyVI5ByT0t
 2WixZlaP6w_SBQGXA40R1uSYb3IP8UQWEp0qbx.ScyeOSn9Qi4rc.nBX4yg-
 -
Received: from [151.18.140.52] by web172702.mail.ir2.yahoo.com via HTTP; Tue, 04 Jun 2013 23:18:59 BST
X-Rocket-MIMEInfo: 002.001,Z2l0IHZlcnNpb24gMS44LjEuMgoocGxlYXNlIGNjIG1lLCBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhpcyBsaXN0KQoKCkhpIERldmVsb3BlcnMsIEkgd3JpdGUgaGVyZSBiZWNhdXNlIHNpbmNlIG15IHVidW50dSB1cGRhdGUgKHF1YW50YWwgdG8gcmFyaW5nKQphbmQgZ2l0IHVwZGF0ZSBmcm9tIDEuNy4xMC40LTF1YnVudHUxIHRvIDEuOC4xLjIKCm15IGV4cG9ydCBzY3JpcHQgZG9lc24ndCB3b3JrIGFueW1vcmUuCgpJIHRyaWVkIHRvIHB1dCAuZ2l0YXR0cmlidXRlcyBvciAuZ2l0L2luZm8vYXR0cmlidXQBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.145.547
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226419>

git version 1.8.1.2
(please cc me, I'm not subscribed to this list)


Hi Developers, I write here because since my ubuntu update (quantal to =
raring)
and git update from 1.7.10.4-1ubuntu1 to 1.8.1.2

my export script doesn't work anymore.

I tried to put .gitattributes or .git/info/attributes, the file is the =
following
http://pastebin.com/irngA1L8

the git is
git clone http://boinc.berkeley.edu/git/boinc-v2.git

and the command is

git archive --prefix boinc-7.1.7+dfsg/ --format tgz -o ../boinc_7.1.7+d=
fsg.orig.tar.gz -9=A0 client_release/7.1/7.1.7

The archive gets created, but every file is inside, no exclusions at al=
l.

I suspect a regression between git 1.7 and 1.8

thanks for your time


Gianfranco

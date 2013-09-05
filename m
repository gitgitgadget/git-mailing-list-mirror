From: Eyal Zinder <ezinder@yahoo.com>
Subject: Problem setting up a shared git repository
Date: Thu, 5 Sep 2013 14:43:52 -0700 (PDT)
Message-ID: <1378417432.91149.YahooMailNeo@web161803.mail.bf1.yahoo.com>
Reply-To: Eyal Zinder <ezinder@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 05 23:53:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHhUc-0007I9-HK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 23:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3IEVxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 17:53:30 -0400
Received: from nm40.bullet.mail.ne1.yahoo.com ([98.138.229.33]:25860 "EHLO
	nm40.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752738Ab3IEVx3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 17:53:29 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2013 17:53:29 EDT
Received: from [127.0.0.1] by nm40.bullet.mail.ne1.yahoo.com with NNFMP; 05 Sep 2013 21:46:35 -0000
Received: from [98.138.90.51] by nm40.bullet.mail.ne1.yahoo.com with NNFMP; 05 Sep 2013 21:43:53 -0000
Received: from [66.196.81.171] by tm4.bullet.mail.ne1.yahoo.com with NNFMP; 05 Sep 2013 21:43:53 -0000
Received: from [98.139.212.193] by tm17.bullet.mail.bf1.yahoo.com with NNFMP; 05 Sep 2013 21:43:53 -0000
Received: from [127.0.0.1] by omp1002.mail.bf1.yahoo.com with NNFMP; 05 Sep 2013 21:43:53 -0000
X-Yahoo-Newman-Property: ymail-4
X-Yahoo-Newman-Id: 332142.41568.bm@omp1002.mail.bf1.yahoo.com
Received: (qmail 91246 invoked by uid 60001); 5 Sep 2013 21:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1378417433; bh=TK865DqXiwya+4AJQuYhvbCuoNC9LzNQ5Sf1VPoFPJ4=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Iv6OWZDDKpMW2A5meu5FkfxSNgOPfEOky7EPMC3p0NkkG+yopYAZ8Ye+oLRjLp8oVo38onkDYQsO+QyV///4Zan9QdtbIrOdy6yUEENnTeZQOw/45A7vqoQoVgmAN/X7SL9srsEhVu940PLcHdmVGp0OAtXNnkRik+CNXOEoKqY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LJGdawlV3mNZ34Pbxg9gUIFuLJDoO9cmzBU+5KvBCJoh3OKd9SLBkGyLpRpd5nJD60QcboZ/tiu1eQTI38FBwutqhWqek7yP7n+0nREryfU86Gyzg85ki4KSqghiwO2dGW2cAO7tj2DtRmiZ294oyik2StopsoUY5FRWvHIXrW4=;
X-YMail-OSG: cm1WS6UVM1kc96O6lutvXa15xGgBd9rOln0hue12XjIShQP
 aJeX5Lx7zQftAe0KDC9a_n9CdkFpeXErXctw2hSgNJFxfQZs_urx4D5v2nkg
 0tVkMQCkUdl.YqOSVjWaBKVR69OSYNOpTrjPkPsanZOTJ9rs7xZ7BcnCVCZH
 IT2rCoobwPqUaZSvfTZDatXrOveTFzOPP5dKWkuxUk25T8b4EAyZIPfpV8pZ
 98xV9VNvf87IFHrzj_EVEobloaDWs7T0bHO9TXhc_4jK6hjHupBTVzSpMG8r
 2Gl2DCBGJbrSON6JGR9gWle.NmnvjdYH8.7KQWw1neLIYyx_BgmYt0tLt4zY
 rvx8JzjCDaxmizMit9V5k7.Rg_NCfDTtRYFyyZz6LOuj65eUmCJC_U0IWh5K
 XbMINrcPQOnUcepAkImqtiDEg1eKCLbnjjzCMAknyKkr4qusfryI.sV60iw8
 k.L_sWNYV7eIL_Fe_mRuWsEL1_.xfoxvC53CGwR1hFXnmNdyxGYdJRudThU2
 db0_hvEc6EqrW625SnknzAD9fwOgVYsuEN_.DObb4OLufzGbKSJULp8cCGmI
 9Ro6zm7X_avyViMKMdVjzWiA-
Received: from [216.133.6.252] by web161803.mail.bf1.yahoo.com via HTTP; Thu, 05 Sep 2013 14:43:52 PDT
X-Rocket-MIMEInfo: 002.001,SSBob3BlIGl0J3Mgbm90IHRvbyBpbmFwcHJvcHJpYXRlIHRvIHNlbmQgYSByYW5kb20gcXVlc3Rpb24geW91ciB3YXksIGJ1dCBJJ3ZlIGV4aGF1c3RlZCBhbGwgb3RoZXIgbWVhbnMgYW5kIGFtIHF1aXRlIGxvc3QgYXQgdGhlIG1vbWVudC4uwqAKCkknbSB0cnlpbmcgdG8gc2V0dXAgYSBkaXN0cmlidXRlZCBkZXZlbG9wbWVudCByZXBvc2l0b3J5IHdpdGggYSBjZW50cmFsIHJlcG9zaXRvcnkgYWN0aW5nIGFzIHRoZSBwcm9kdWN0aW9uIGNvcHkuIMKgSSdtIGRvaW5nIHNvIG9uIGEgV2luZG93cyBmaWxlIHMBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.156.576
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233996>

I hope it's not too inappropriate to send a random question your way, b=
ut I've exhausted all other means and am quite lost at the moment..=A0

I'm trying to setup a distributed development repository with a central=
 repository acting as the production copy. =A0I'm doing so on a Windows=
 file share with no SSH / HTTP accessibility. =A0Basically each develop=
er will have their own copy of the project, and the shared drive should=
 have a copy of the master copy (prod/master branch), along with the wo=
rk-tree files. =A0

The idea is that any developer should be able to do independent develop=
ment, staged commits, etc.. then push to the central (origin) repositor=
y, and production scripts will reflect these changes upon a push. =A0

I got pretty close to this setup by creating a bare repository on the f=
ile share server (f:\GitDBs\foo.git), then cloning the bare repository =
onto the production path like so:=A0
git clone f:\GitDBs\foo.git foo =A0

I cloned the bare repository just the same onto my local dev path.. and=
 proceeded with development. This worked fine, and I was able to push /=
 pull changes into "origin" (bare repo), and then I would go to my prod=
 (f:\foo) repository (clone of bare f:\GitDBs\foo.git), then pull the c=
hanges..=A0

The problem I faced later on was in parallel development, when changes =
were made to a file in one repository, and at the same time other chang=
es made to the same file in another repository.. =A0I couldh't push cha=
nges from the dev\foo to prod\foo or to origin..=A0

I'm completely lost at the moment.. I try to set --git-dir or --work-tr=
ee and I get mixed results.. either the setting is not allowed when wor=
king in bare repositories, or I can't run certain operations from the w=
ork-tree and git-dir.. like "git status", which in a split git-dir / wo=
rk-tree environment (on windows), returns an error which specifies the =
operation is invalid in a bare repository, or specifies that the work-t=
ree is not recognized as a repository... :(=A0

Please help me..=A0
I'm new to Git, but love it already.. I would hate it if I had to work =
without it..=A0

Thank you in advance for all your help!


- Eyal

From: hong zhang <henryzhang62@yahoo.com>
Subject: how the commit ID come from in GIT?
Date: Mon, 5 Nov 2012 12:04:06 -0800 (PST)
Message-ID: <1352145846.26267.YahooMailClassic@web141404.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 21:10:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVSzg-0008B4-IW
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 21:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab2KEUJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 15:09:47 -0500
Received: from nm12-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.140]:39351 "EHLO
	nm12-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754600Ab2KEUJq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 15:09:46 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2012 15:09:46 EST
Received: from [98.139.214.32] by nm12.bullet.mail.bf1.yahoo.com with NNFMP; 05 Nov 2012 20:04:08 -0000
Received: from [98.139.212.221] by tm15.bullet.mail.bf1.yahoo.com with NNFMP; 05 Nov 2012 20:04:08 -0000
Received: from [127.0.0.1] by omp1030.mail.bf1.yahoo.com with NNFMP; 05 Nov 2012 20:04:08 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 130218.72416.bm@omp1030.mail.bf1.yahoo.com
Received: (qmail 26668 invoked by uid 60001); 5 Nov 2012 20:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1352145847; bh=2zraZo3K33OgtNrIlWMkjVNK1n8sSjs8zorSXvrICJ8=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type; b=m2usy3KsfhkufYwD8zyWOMIk1tXPBJt1J53g1uwtMeJOtPixkEjS0pqFSEwzY6gJ3UVhKJOU007U/5idDHGzrCFOwo+jL0uUd6rz8Hvj3372DkpcSN3NMZ0T63X0+rOYKFBBGyCFKnwoJvld3L2SPt0SE6eShM0Q9RXdhIfa7Ic=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
  b=M60VVtfHkn3wIEMAOOGPn9YH7YL6gWPLb06uOH0EumWLd885swFB8bl4ypeB4old6hEqZ8T5kmeaemWpuhXtxnfMpn+et1SKEMp0DNOFUIgr1gjUwr/Nm0OGqaY8jT2oYUH7jkEWOsNvhVoELf1jMwjR0w7/eLRWSLE13mVugqk=;
X-YMail-OSG: JpfRCWcVM1nmpWbx9jH9.lXkvcrl39NqtmMYoVeLm7W31Xk
 wuYX.IU4fJiZWBc7cVfgQInCOF3nhonK1iMkaxGrK.bI_3NN0RmDOwQwWrt4
 n7lj9j1yQ7nuTQP2oSfJCAByhR30QGiau1Oq1Bw5dsH6kLx.EwJJVTGi4xxb
 waURi71PZ8WaWybbyfO5agkl_jovj64CRVuKCCvYtf5iEEbcPfZlQuwyNd_M
 GUn8tKugqJ4fp5zQlWdFdq.9HRY6_6dvMJ79Y8.NK4ttwxkuMeaszAlpLxwf
 9qK2bidGWgEX4OKp5WK38x8VGxordGQl1rnIVsEp0rqdJwJftdWiqfP2_LtW
 bqZ8YMmgQgO2kxO72CZf3SLUhYBVJ5Lo5Fv.jfgh4MBRUYtYeiENHedmAoPk
 5Vgr2bMGBCT4W1EI46NWrg7nICV71OUTCMhWR_QjF2psWg8QmHLZI8S5nY3c
 X8e9t8jyp61MMXZ3MvZNPFBIpA0VeM.Mq2aAINZYPkd_rCy4-
Received: from [192.100.106.40] by web141404.mail.bf1.yahoo.com via HTTP; Mon, 05 Nov 2012 12:04:06 PST
X-Rocket-MIMEInfo: 001.001,TGlzdCwNCg0KQ291bGQgYW55b25lIGV4cGxhaW4gaG93IHRoZSBnaXQgY29tbWl0IElEIHdpbGwgaW5jbHVkZSBhbGwgdGhlIGZpbGVzIHRoYXQgZGV2bG9wZXIgbWFrZXMgY2hhbmdlcyBvbj8NCg0KSG93IGdpdCBjb21taXQgSUQgd29ya3M_DQoNClRoYW5rcyBmb3IgYW55IGhlbHAhDQoNCi0tLWhlbnJ5ATABAQEB
X-Mailer: YahooMailClassic/15.0.8 YahooMailWebService/0.8.123.460
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209080>

List,

Could anyone explain how the git commit ID will include all the files that devloper makes changes on?

How git commit ID works?

Thanks for any help!

---henry

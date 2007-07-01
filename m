From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 1 Jul 2007 19:06:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011903200.4438@racer.site>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011507310.4438@racer.site> <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
 <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
 <20070701165301.GJ7969MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-330170499-1183313203=:4438"
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 01 20:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I53p6-0003dP-Fp
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 20:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbXGASGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbXGASGu
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 14:06:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:40056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753121AbXGASGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 14:06:49 -0400
Received: (qmail invoked by alias); 01 Jul 2007 18:06:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 01 Jul 2007 20:06:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18udwQbwkMuq/6hea06EMg8fgtDfYEMgLb3DOX0ML
	ThJCkxic2lVmBP
X-X-Sender: gene099@racer.site
In-Reply-To: <20070701165301.GJ7969MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51313>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-330170499-1183313203=:4438
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Sun, 1 Jul 2007, Sven Verdoolaege wrote:

> On Sun, Jul 01, 2007 at 06:06:06PM +0200, Carlos Rica wrote:
>
> > Can you verify the other tags, like those from Junio on each version?
> 
> Apparently...

Could you please try to import the attached keys into a new keyring? IOW

	$ mkdir test-gpg
	$ chown go-rwx test-gpg
	$ export GNUPGHOME=$(pwd)/test-gpg
	$ gpg --import pubkeys.asc

And send me the resulting pubring.gpg and secring.gpg?

If you have a little more time, you could also put them in t/t7004/, and 
check t7004-tag.sh...

Ciao,
Dscho

--8323584-330170499-1183313203=:4438
Content-Type: TEXT/plain; charset=US-ASCII; name=pubkeys.asc
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0707011906430.4438@racer.site>
Content-Description: 
Content-Disposition: attachment; filename=pubkeys.asc

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9u
OiBHbnVQRyB2MS40LjUgKEdOVS9MaW51eCkNCg0KbVFHaUJFWm55eWtSQkFD
ekNQaklwVFlOTDdZMnRRcWxFR1RURGx2WmNXTkxqRjVmN1p6dXlPcU5PaWRM
VWdGRA0KMzZxY2gxTFpMU1prU2hkUjNHYWUrYnNvbHlqeHJsRnVGUDBlWFJQ
TXRxSzIwYUx3N1dadlBGcEVWMVRoTW5lKw0KUFJKallydmdoV3czTDBWVklB
SVo4R1h3clZCdVU5OXVFakhFSTBvallsb092RmMyalZQZ1Nhb0J2d0NnNDhU
ag0KZm9sMmZvU29KYTdYVXU5eUFMOHN6ZzhEL1JVc1R6TkYrSTloU1JIbDdN
WUtGTVlvS0VZOUJEZ3JnQXVqcDdZWQ0KOHFkR3NpVWIwR2d5enAya1JqWkZ0
NGxwY3ZLaEdmSG41R0VqbXRrK2ZSYkQ1cVBmTXFLRlcrVDBOUGZZbFltTA0K
Sko0ZnM0cVo4THg3eDZpRzZYNTF1K1lOd3NRdUlHak1DQzNDZU5pM0Y3b3I2
NTFra05ZQVNiYVExTlJPa0NJTg0KTnVkeUEvMGFhc3ZvWlVvTkpBYzJjUDVJ
ZnM2V2hYTVdMZk1SMnAyWGJmS3dLTlluZWVjNjB1c25TQ29tY0txaA0Kc0pW
azBHeXR2cjNGT1lWaFJrWG5LQWJ4KzBXMnVyRlA4T0ZWQlRFS082VHMyVnln
V0dnbmVRWW9IbnF6d2xVRQ0KeWpPamxyK2x5Zjd1MnMvS0F4cEtBNmpudHRF
ZFJaQW16V2todW94MXd3QVVrcjI3L2JRaVF5QlBJRTFwZEhSbA0KY2lBOFky
OXRiV2wwZEdWeVFHVjRZVzF3YkdVdVkyOXRQb2hlQkJNUkFnQWVCUUpHWjhz
cEFoc0RCZ3NKQ0FjRA0KQWdNVkFnTURGZ0lCQWg0QkFoZUFBQW9KRUJPMjlS
N04za01OZEIwQW4wbnBpVm01cDFIb1FqS1Y0UHJIUGJycA0KYjBhaEFLQy8z
SmJHd2wxdnMwV2Rubzd2WStLQktEYVVZTGtDRFFSR1o4dE9FQWdBenJsNVAx
UHI2Q0RSOG1mNQ0KREdHemNVVU0rUEVyb0E0RkxkS0o1WmFaYzdxeTFsbW1X
OXZ1dmI2eGRpbndjd2VlMmM1ZmRORStpVWpIVjJ4Mg0KUy9kYmZEekpUTi8w
dWFqWmN3K3huZitLeFowUnM0Z0RTczdjSFhIQnRBN3U4U2hZZDRIdTdKZ2dY
cGl3Z2ZTaw0KeXJHUWlaeUxBSFcyY2s4SDA3R284ZVVQOGZMSWV2YStpUHFl
WVFabzlCYVB6OTJSL0o2ZGVicGVZMWxSa3YreQ0KV1RxMUdFM0MvaHhiZEJB
dUhmMmR1TFAydXE5a3dvVmRmekNSamdWMUNRbU1JYkNyTWI3dklsekllOTZi
YjMrSw0Kci8rTkV0bUIySTN3SEJYY3dKTW5JT256OVp2OTMzS05seFNiVkYy
M0JHTEIrRjlEN09hbkt5bWJzN0VnMThmcg0KbXQvdC93QUVEUWdBdEdJeEd6
OTQ0UG4yT3RoZVk5SmxCUnVJQXVWc2ttMjQvWnowM2Rabms2Q3VFT0lCYjVJ
TQ0KZzM2R0FQS2NuMXZzTFowVGZFMXE1M2pOcGNBQVhqZ25nblJzQ2pabTFt
Z2xxUEQ0WmZCcGwrSGhudWM4MGZBUg0KeHNVUGorNWM4S1AyTStSd3M0bW9h
WlJqVnBkM0tDaTNjZWZsVC9PanduRTlEemRoc2xDR1RNQTVuOGNhakFzMg0K
b3FBYVFzc2VmVmYycHJMUUxHVjlOQjRRM2xGbktYZHZpcEhNYUFZQXNXK2lG
N0praFREVk51TkdsdWZlU3FVbQ0KaWdSQmpUWlhCY1ZkOHNqOHZET0NXS1Vm
cXhKeVMrelJZY290bjdRdnB2Y0tBa2MzWkd4bnRESEFJR0xWcDZheQ0KK3Zy
a1Y0UmVuOEJqRm9ibDI1UnV5NkFidytDZ25UcHV3WWhKQkJnUkFnQUpCUUpH
Wjh0T0Foc01BQW9KRUJPMg0KOVI3TjNrTU53ZXdBb0pvWi95SldTckNYWDA4
QS9xOEtTWDRaZm9CREFKMFl4ZWkvREhLOW01bFhjMk1Qa01vSw0KZ2xwSUt3
PT0NCj1YRDViDQotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
DQo=

--8323584-330170499-1183313203=:4438--

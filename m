From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CruiseControl.NET hangs on git-submodule bad file descriptor
Date: Thu, 17 Dec 2015 10:46:00 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512171045230.6483@virtualbox>
References: <HE1PR08MB089107ED02BEA428A6BB37A5F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Skrinnik <askrinnik@amtoss.com.ua>
X-From: git-owner@vger.kernel.org Thu Dec 17 10:46:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9V8W-0005Cq-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 10:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbbLQJqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 04:46:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:51711 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbbLQJqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 04:46:05 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LrqNe-1aL1Tr0swA-013iUE; Thu, 17 Dec 2015 10:46:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <HE1PR08MB089107ED02BEA428A6BB37A5F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:GimPbYKobSMWrqvxBHDGEsw98FpRtRZmsbe/lrDduEsBAciGbxL
 O4fvMfv/nK1XlNL/25F1Yia5SBMG3K1Rx3vxvnUiWJeVD4AQvKi4d3oakYnPMAljsW8Rx1l
 nk8YEdRFidVfpZg+1TqhsbWiwBf4RIpldpV2Yglp3pCAmzw1gcl7R+hRg6jQrNELH/LFBDB
 tg3MCQiE7RovzSTnrHgxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zkCy32oror8=:2aJVSQtcYaifH9haKq+h7S
 UGbjwWJfBFKHK108l+G5KIJ8k08TxBk2wgSnuGl/dKT9lHJ+di4rM8Y0oSS1/3OLgV4mLPk6E
 tthwr1W+WldKo+9ATSiy5xylgIAVypDx8knwl1gBDzQvzbfkQ6sEP6WjxsSmXb0du8EstVTs3
 z2//GnFjFxpISEivKShMCIyol0GkE/FqkboXWPfulJ1DAngSMxzgKE3pjOXV8Xy/Ryul5ce2b
 5sVr3hONxxxXU5cO79XUHWVZNzIw0UInmjNzTuM2baw1l+AuYF9ifuwcgZhKunVKUCfqJpfLO
 iN6S5zRf2ZmHH7G24mrRnLv/8q+y1IbTclKqlbhfFvV6Yqtodxv6HiBUjS9UIvPVplauqeMO5
 llHEd5CLZMdOzAher1ugAUdEoS5ya69m4Zp89CUK/ozXKYn8sT33rd0d6hnzaNVxmjfh5BtVV
 qgiEyJj4nUljR6dYJua59U+v3b6chnpU9BzIDgilPIhcG39MJQSaEI/oS0olsF/YK4pkZE/aK
 tS6MiC6fDbGZNxDS5i3Z4RZa3GGx24UGaySJ5uBx5VzC+e9dCrhv0oJ1QobnE9/GZ8UJg1tnP
 C0ZUWg5y7cJQiA9GaOuV5OOzG6MNNKMRr1TfVf6hgdVEiIO+OJouGG1cpplskS0BNsjsqtBRN
 QgdCjVlIORUZSQjGJFAttl1USzQsahZDAeBpKuopobINgIP1KRB9Fot/ky61+yDbB9nzkeu5/
 eOVRdkZboRXqQRFgmUqFzShBrf6z2fncFOABwpE9CbTcql0hEc9wBUUZuL18pzPS6JVI6LWG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282647>

Hi Alexander,

On Thu, 17 Dec 2015, Alexander Skrinnik wrote:

> I had installed CruiseControl.NET 1.8.5 and Git-1.9.5-preview20150319
> CC.NET invokes bat-file which invokes 
> git submodule foreach git checkout "myBranch"
> 
> It worked good.
> Today I upgraded git to 2.6.4 and CC.NET fails on this command with
> error: C:\Program Files
> (x86)\Git\mingw32/libexec/git-core\git-submodule: line 544: 0: Bad file
> descriptor

This sounds very similar (maybe identical) to this bug report:

	https://github.com/git-for-windows/git/issues/181

Ciao,
Johannes

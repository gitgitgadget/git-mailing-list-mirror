From: "Klinger, Xia" <Xia.Klinger@cognex.com>
Subject: RE: git 2.7.0 crashes when top-down memory allocation preference is
 set
Date: Thu, 4 Feb 2016 16:27:55 +0000
Message-ID: <9854ccd81e624ee9a8f721a871bda4b2@USNAEXCP2.pc.cognex.com>
References: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com>
 <alpine.DEB.2.20.1602040844330.2964@virtualbox>
 <43fbdf617f8d412db7b0d5c7d06df3ad@USNAEXCP2.pc.cognex.com>
 <alpine.DEB.2.20.1602041628180.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 17:28:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRMlc-000513-6n
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 17:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbcBDQ2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 11:28:01 -0500
Received: from mx2.cognex.com ([198.232.29.14]:11619 "EHLO mx2.cognex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934265AbcBDQ15 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 11:27:57 -0500
Received: from galileo.cognex.com ([10.10.128.32])
  by mx2.cognex.com with ESMTP; 04 Feb 2016 11:27:56 -0500
Received: from USNAEXCP2.pc.cognex.com (alt1adc1pip [10.10.128.111])
	by galileo.cognex.com (8.14.3/8.14.3) with ESMTP id u14GRuBP026148;
	Thu, 4 Feb 2016 11:27:56 -0500 (EST)
Received: from USNAEXCP2.pc.cognex.com (10.3.160.222) by
 USNAEXCP2.pc.cognex.com (10.3.160.222) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Thu, 4 Feb 2016 11:27:56 -0500
Received: from USNAEXCP2.pc.cognex.com ([fe80::2d91:f69e:a2bf:334a]) by
 USNAEXCP2.pc.cognex.com ([fe80::2d91:f69e:a2bf:334a%18]) with mapi id
 15.00.1044.021; Thu, 4 Feb 2016 11:27:55 -0500
Thread-Topic: git 2.7.0 crashes when top-down memory allocation preference is
 set
Thread-Index: AdFemzxLzKR7onqfTxCtkbzxea41AwAGsZHQACUAXYAAAOGvwAAPTLAAAAiHh5A=
In-Reply-To: <alpine.DEB.2.20.1602041628180.2964@virtualbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.3.128.111]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285468>

Thanks for confirming it. I hope a fix is available soon. I am using a very old version of Git at the moment to work around this issue, which doesn't comply to the requirement of our Stash Git Server from Atlassian.

Best regards,

Xia

-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Thursday, February 04, 2016 10:29 AM
To: Klinger, Xia
Cc: git@vger.kernel.org
Subject: RE: git 2.7.0 crashes when top-down memory allocation preference is set

Hi,

On Thu, 4 Feb 2016, Klinger, Xia wrote:

> I am not sure the Fast Track release means. Do you refer to Windows 10 
> builds (updates)? I am running Windows 7 x64 and haven't gone to 
> Windows 10.

The Fast Track release to which I referred is indeed Windows 10. In the meantime, I verified that the problem you described still exists on Windows 10, but has nothing to do with the issue 627 in Git for Windows'
bug tracker.

Ciao,
Johannes

From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 15:01:20 -0700 (PDT)
Message-ID: <375487.35999.qm@web52802.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQvf-000861-Hy
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbXHOWBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757776AbXHOWBW
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:01:22 -0400
Received: from web52802.mail.re2.yahoo.com ([206.190.48.245]:30566 "HELO
	web52802.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757702AbXHOWBW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:01:22 -0400
Received: (qmail 36153 invoked by uid 60001); 15 Aug 2007 22:01:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=E2w9PMjLOQMSKI1/V8WG98Ux7WS8/zr/LMWhHWDnkf9PbrqEqVQmG17kdDMSSIgl0ukPWGnyjGb8fw2Te9Vu5+RPf5BWGiqsGI4WsNeeYiomspG5fc8ZyGU65qCcx5CC1n213He+BQRudfuhlmo7ZkxrxKXA6lu2zcyMawGNcP8=;
X-YMail-OSG: OQECvy4VM1luIgUzBuPh2n3M2eMN8.oXvX6.3Zs_TD10MehdjzrUfuuVb1qp6EWkM4qNdAI7CUnvdrTHtcEd4EwrltuNgRtrx0xoiLZA3RIAUwOFWCVmAuE6PLuqqR5qnpahsrAVlNB5gNU-
Received: from [216.52.12.233] by web52802.mail.re2.yahoo.com via HTTP; Wed, 15 Aug 2007 15:01:20 PDT
X-Mailer: YahooMailRC/651.48 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55955>


Nothing has changed,, I just did a git checkout v1.5.2.4; make clean; make ; make test, and that same test passes. Then I did a git checkout v1.5.3-rc5 ; make clean ; make ; make test, and the same test fails. 

I'll try updating to a newer version of Xcode and see if that helps. 

Perrin


----- Original Message ----
From: Junio C Hamano <gitster@pobox.com>
To: Perrin Meyer <perrinmeyer@yahoo.com>
Cc: git@vger.kernel.org
Sent: Wednesday, August 15, 2007 2:33:04 PM
Subject: Re: 1.5.3-rc5 regression on OS X?

Perrin Meyer <perrinmeyer@yahoo.com> writes:

> I was able to build and test git 1.5.2.4 fine, with no errors in the test suite. 
>
> I also just build 1.5.3-rc5 on a redhat box, with no errors in the testsuite. 
The above sounds as if you built 1.5.2.4 on your Mac in not so
recent past, and 1.5.3-rc5 on your Mac and RH recently.

Has anything changed on your Mac between the time you built
1.5.2.4 and failed to pass the test for 1.5.3-rc5?

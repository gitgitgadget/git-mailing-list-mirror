From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 21:07:53 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF32209584@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvaDe-0000nV-U7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 22:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738Ab3APVIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 16:08:01 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:35898 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab3APVIA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 16:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1049; q=dns/txt; s=iport;
  t=1358370480; x=1359580080;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WAflAH0vw0Rw9mV+MF8LxKZnQbNbH2ljVSwbMqbPrqI=;
  b=GKAu84G9OU2T7e6YbjA4rKSGCnW2j0w1wo5WTHMX56d3WIG6oYPYRlf4
   KHfXs9jBfu1dP37QGek0faUXsWGpFlsL02+X99ZLIVKsfkMy2r37ItopW
   1phsRSx1O5ht9rNS+NzLRwA5fhkw8gpej7k9dFVoYRaieRkw/3EEoF97P
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EACsW91CtJXG8/2dsb2JhbABEvX8Wc4IeAQEBAwE6RA0BCBgKFEImAQQTCBKHeQUBDJkToBOQV2EDlyiPLYJ1giQ
X-IronPort-AV: E=Sophos;i="4.84,480,1355097600"; 
   d="scan'208";a="163422008"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by rcdn-iport-5.cisco.com with ESMTP; 16 Jan 2013 21:07:54 +0000
Received: from xhc-rcd-x03.cisco.com (xhc-rcd-x03.cisco.com [173.37.183.77])
	by rcdn-core2-1.cisco.com (8.14.5/8.14.5) with ESMTP id r0GL7siB027098
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 16 Jan 2013 21:07:54 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.248]) by
 xhc-rcd-x03.cisco.com ([173.37.183.77]) with mapi id 14.02.0318.004; Wed, 16
 Jan 2013 15:07:53 -0600
Thread-Topic: Question re. git remote repository
Thread-Index: Ac30LWwwwxPSFBTxQQKrBS900R+H4Q==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213814>

"Konstantin Khomoutov" <kostix+git@007spb.ru> wrote in message news:<20130116233744.7d0775eaec98ce154a9de180@domain007.com>...
> On Wed, 16 Jan 2013 10:21:56 -0800
> Jeff King <peff@peff.net> wrote:
> > 
> > I agree that performance is not ideal (although if you are on a fast
> > LAN, it probably would not matter much), but I do not recall any
> > specific bugs in that area. Can you elaborate?
> 
> Of course, if there are happy users of such setups, I would be glad to
> hear as my precautions might well be unfounded for the recent versions
> of Git.

I'm a happy user of git on network file systems (NFS and CIFS/SMB), although not a heavy user.

> 1. http://code.google.com/p/msysgit/issues/detail?id=130

I wouldn't be surprised if there are some subtle POSIX-Win32 compatibility issues here between msysgit and Samba (POSIX GIT, ported to use Win32 file system functions, sending those Win32 requests to a Samba server, and the Samba server translating those Win32 requests back into POSIX functions).

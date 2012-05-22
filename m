From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: Question about submodules and absolute paths
Date: Tue, 22 May 2012 12:36:29 -0700
Message-ID: <70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com><CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com><7vk4043wc5.fsf@alter.siamese.dyndns.org><CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com><70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com> <CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Alexey Pelykh" <alexey.pelykh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 21:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWusm-0006cf-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760284Ab2EVTgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 15:36:31 -0400
Received: from mtv-iport-3.cisco.com ([173.36.130.14]:35567 "EHLO
	mtv-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479Ab2EVTgb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 15:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=390; q=dns/txt;
  s=iport; t=1337715391; x=1338924991;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:in-reply-to:references:from:to:cc;
  bh=UXIGh7/ntA3LkjExenzr1frO3RPj57paA+YmqhKWWr4=;
  b=iJUpfvFh+x5vnvSRKZ89UhnlutvJPH6hSN32u6bmTh+AQOT2r+aYRY7T
   u0p1/QHXk/pZSanRHhBWG12iogpHg8D1lwOlQX1NtDmlQtRuWD5KZo7TX
   Vs9FFxStUTXw3/85wR4OsmWV+HOR8/yQUgua23QRRxAc5nrB6ILIZ16P1
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAGzpu0+rRDoG/2dsb2JhbABEtBeBB4IVAQEBAwESAR0KPwULAgEIFQ0GFwEGASAlEQEBBBMIEweHXgMGBAGaYpYNDYlSihqFSWIDiEOXUIMVgWSDCg
X-IronPort-AV: E=Sophos;i="4.75,639,1330905600"; 
   d="scan'208";a="43349495"
Received: from mtv-core-1.cisco.com ([171.68.58.6])
  by mtv-iport-3.cisco.com with ESMTP; 22 May 2012 19:36:30 +0000
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by mtv-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id q4MJaUVv005987;
	Tue, 22 May 2012 19:36:30 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 22 May 2012 12:36:30 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question about submodules and absolute paths
Thread-Index: Ac04UTCfyWtLZGn2TS+VBMOcB3mRYgAAHLaA
X-OriginalArrivalTime: 22 May 2012 19:36:30.0317 (UTC) FILETIME=[2FBF91D0:01CD3852]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198233>

> From: Alexey Pelykh [mailto:alexey.pelykh@gmail.com]
> 
> Indeed this is a workaround, what I was thinking about to use. The
thing I
> wanted actually to discuss whether it worth to research possibility of
> replacing these absolute paths with relative ones. 

Sure.  I just wanted to offer an immediate, interim solution until there
is a decision on the permanent solution.

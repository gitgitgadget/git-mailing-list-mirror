From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: Question about submodules and absolute paths
Date: Tue, 22 May 2012 12:25:28 -0700
Message-ID: <70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com><CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com><7vk4043wc5.fsf@alter.siamese.dyndns.org> <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Alexey Pelykh" <alexey.pelykh@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 21:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWui7-0005GM-I2
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 21:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760186Ab2EVTZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 15:25:30 -0400
Received: from mtv-iport-4.cisco.com ([173.36.130.15]:41596 "EHLO
	mtv-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab2EVTZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 15:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=700; q=dns/txt;
  s=iport; t=1337714730; x=1338924330;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:in-reply-to:references:from:to:cc;
  bh=E3uZbhvZ1KfDsWaAuYpAWaalQ0HwBarUtehUqx1kXug=;
  b=b4T6IeHMEE4aIKZjBj1oa4GCFtmsUQ0Mz0lLWrUWY9bQvSI67jVTL4EL
   aJcDTatAQ/nF1KcjSVXcttQWdEuXgQV5cYTxDOSyE+6PvrSJnG01+7IzM
   O59fJ/Hg7RPITn1Le+quHGrchS4hlkxED1mn9f15kcdPb2PAMf4LxHoyv
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAPznu0+rRDoJ/2dsb2JhbABEtBeBB4IVAQEBAwESAR0KPwULAgEIFQ0GFwEGAUUDAQ0BAQQBEggah2cEAQuaVp9sj2NiA4hDjWiMfYFkgwo
X-IronPort-AV: E=Sophos;i="4.75,639,1330905600"; 
   d="scan'208";a="45833970"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by mtv-iport-4.cisco.com with ESMTP; 22 May 2012 19:25:29 +0000
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com [128.107.191.63])
	by mtv-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id q4MJPTuX006733;
	Tue, 22 May 2012 19:25:29 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-221.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 22 May 2012 12:25:28 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question about submodules and absolute paths
Thread-Index: Ac04T7ivFkiT58qsReOyi/N/GhBK/gAACZqA
X-OriginalArrivalTime: 22 May 2012 19:25:28.0454 (UTC) FILETIME=[A53F4A60:01CD3850]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198230>

> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Alexey Pelykh
> 
> Not on two machines, on single machine but with two OSes Windows +
Linux +
> shared 'work' partition :) So both Windows and Linux use same repo
clone
> that is stored on a 'work' partition. But due to those absolute paths,
it
> gives '/cygdrive/d/work' on windows and '/media/work' on linux. Thus I
> have to keep 2 copies of each repository that uses submodules (and
that is
> very inconvenient :( )

As a workaround, how about using Cygwin's mount table to mount "/media"
to "d:/", or "/media/work" to "d:/work"?

See:
http://cygwin.com/cygwin-ug-net/using.html#mount-table

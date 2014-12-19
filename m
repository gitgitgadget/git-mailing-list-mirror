From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: git-http-backend auth via Kerberos
Date: Fri, 19 Dec 2014 15:50:18 +0000
Message-ID: <323AFE89-DD9C-4FA3-BED8-16F353A84386@cisco.com>
References: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
 <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
 <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 16:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1zov-0005zn-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 16:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbaLSPuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 10:50:21 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:63850 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaLSPuU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2014 10:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=752; q=dns/txt; s=iport;
  t=1419004220; x=1420213820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JX7tmWZwXvbjmHzAZzxweA/SLrnEmWMMCL/PaImJFQM=;
  b=Lfb9VujomFCMTxMRDxgyC7vfH33mdJfj7Ihwz6UNVG5Lv8XniTBI0MA+
   PLPx4pffncGkFUbHJsaPAoi0DZH+9WZNAy/eZbItJfVHZt6IxKMi0P8cz
   u1P7tHV+6bHLT2mLT6VEFGQvwxLDeR6KYSrGrCr/qnKd8s2JNz/EIcm0O
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ak8FAElIlFStJA2M/2dsb2JhbABagwZSWATMEgKBHBYBAQEBAX2EDAEBAQMBOj8FCwIBCBgYBhAyJQIEDgWIJAjQXgEBAQEBAQEBAQEBAQEBAQEBAQEBARePPzMHGIJ+gRMBBI4NiHKRSCKDbm+BRX4BAQE
X-IronPort-AV: E=Sophos;i="5.07,607,1413244800"; 
   d="scan'208";a="381361753"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-5.cisco.com with ESMTP; 19 Dec 2014 15:50:20 +0000
Received: from xhc-aln-x03.cisco.com (xhc-aln-x03.cisco.com [173.36.12.77])
	by alln-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id sBJFoJXd023421
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 19 Dec 2014 15:50:19 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.194]) by
 xhc-aln-x03.cisco.com ([173.36.12.77]) with mapi id 14.03.0195.001; Fri, 19
 Dec 2014 09:50:19 -0600
Thread-Topic: git-http-backend auth via Kerberos
Thread-Index: AQHQGxCrd+//UJfMPkWu780RpZEfpJyWWaAAgAEPyoCAAAuWgA==
In-Reply-To: <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.243.85]
Content-ID: <E6CCA66188E55A4586F0E9F060FC7A52@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261567>

> On Dec 19, 2014, at 10:07 AM, Dan Langille (dalangil) <dalangil@cisco.com> wrote:
> 
>> You might also try specifying KrbMethodK5Passwd on explicitly.  I don't
>> happen to use that option (I use Kerberos to avoid passwords altogether)
>> so that might work for you.
>> 
>> I don't know what version of git you're using, but some older versions
>> will still prompt for a password whenever authentication fails.
>> Therefore, just because you're getting a password prompt doesn't mean
>> that providing a password will necessarily work.
> 
> How old is older?
> 
> $ git --version
> git version 1.9.3 (Apple Git-50)
> 
> Might that be it?  Hmmm.
> 

For the record, I tried git 2.2.1 and it gave identical results.

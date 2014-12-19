From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: git-http-backend auth via Kerberos
Date: Fri, 19 Dec 2014 16:07:49 +0000
Message-ID: <C50363BE-A217-47B1-8556-919DC933D83C@cisco.com>
References: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
 <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
 <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 17:07:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y205s-0006RC-B2
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbaLSQHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:07:52 -0500
Received: from alln-iport-8.cisco.com ([173.37.142.95]:40529 "EHLO
	alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaLSQHw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2014 11:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=752; q=dns/txt; s=iport;
  t=1419005271; x=1420214871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JX7tmWZwXvbjmHzAZzxweA/SLrnEmWMMCL/PaImJFQM=;
  b=bKLaVaW4vEWoadStQS4i2eo1wfJCcytdXczA1AbSIEj+EpbdJchOWaFE
   zV0kxK4ydnQkgPWpPJKgJQ6SeyY7brUbKM8BUfbA+RFeY8Y9aXzUYCBB7
   bMghyrbzqYyifLyHMSy+IXEwqMGi3qd76HQx0Wh8v0DqB5OUS+F2536gV
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ak8FAAVMlFStJV2R/2dsb2JhbABagwZSWATMEgKBHBYBAQEBAX2EDAEBAQMBOj8FCwIBCBgYBhAyJQIEDgWIJAjQZwEBAQEBAQEBAQEBAQEBAQEBAQEBARePPzMHGIJ+gRMBBI4NiHKRSCKDbm+BRX4BAQE
X-IronPort-AV: E=Sophos;i="5.07,607,1413244800"; 
   d="scan'208";a="106952177"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by alln-iport-8.cisco.com with ESMTP; 19 Dec 2014 16:07:50 +0000
Received: from xhc-aln-x14.cisco.com (xhc-aln-x14.cisco.com [173.36.12.88])
	by rcdn-core-9.cisco.com (8.14.5/8.14.5) with ESMTP id sBJG7om8004609
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 19 Dec 2014 16:07:50 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.194]) by
 xhc-aln-x14.cisco.com ([173.36.12.88]) with mapi id 14.03.0195.001; Fri, 19
 Dec 2014 10:07:50 -0600
Thread-Topic: git-http-backend auth via Kerberos
Thread-Index: AQHQGxCrd+//UJfMPkWu780RpZEfpJyWWaAAgAEPyoCAABDogA==
In-Reply-To: <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.243.85]
Content-ID: <D2B8823DE4A78D47A36F03E8DF7DFB25@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261568>

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

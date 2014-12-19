From: "Nicolas Pennequin (npennequ)" <npennequ@cisco.com>
Subject: Gitk: "argument list too long"
Date: Fri, 19 Dec 2014 17:32:22 +0000
Message-ID: <D0BA1FB7.16EC4%npennequ@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 18:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y21Yy-00070s-UE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 18:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbaLSRmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Dec 2014 12:42:00 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:21143 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbaLSRl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2014 12:41:59 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Dec 2014 12:41:59 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=678; q=dns/txt; s=iport;
  t=1419010919; x=1420220519;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=zHXpaRGtcGtf/fAUEtYBnIAnh7rlUjYxqmfICzt1b7U=;
  b=jZP/J3/NWDAKp5BM5zaMWcfGZ9IWoXTTf03rREDcijuVX67ut7uRAq6n
   AYg5Bs1fEXe4D7+7g4YDODzE3T4jwEf2MODtuQygMRtoIYltj8R9BoEJ3
   Cf4/YdoUcrY1Iv0NCkWJM60RanWWIs7Ga4uA7O4zakVYuGpDUcDVMF50A
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjMFANxglFStJV2S/2dsb2JhbABagwaBLsN9iTQWAQEBAQF9hBOBCwGBACcEiD+rJaVjAQEIAgEflCIFiRyEcYhykUgig26CNH4BAQE
X-IronPort-AV: E=Sophos;i="5.07,607,1413244800"; 
   d="scan'208";a="381411675"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-3.cisco.com with ESMTP; 19 Dec 2014 17:32:23 +0000
Received: from xhc-aln-x12.cisco.com (xhc-aln-x12.cisco.com [173.36.12.86])
	by rcdn-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id sBJHWNl0012208
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 17:32:23 GMT
Received: from xmb-aln-x08.cisco.com ([169.254.3.252]) by
 xhc-aln-x12.cisco.com ([173.36.12.86]) with mapi id 14.03.0195.001; Fri, 19
 Dec 2014 11:32:23 -0600
Thread-Topic: Gitk: "argument list too long"
Thread-Index: AQHQG7G/xrdX0NqWeEeiTlltNs+npg==
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.4.6.141106
x-originating-ip: [10.60.62.1]
Content-ID: <0023AAB9F1AEBF4A9BD70CE83D8ED960@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261583>

Hi,

I=B9m having some trouble with gitk on Mac using a very large repositor=
y
(chromium/src).
I=B9m using git version 2.2.1 from Homebrew.

The error details are the following:

couldn't execute "git": argument list too long
couldn't execute "git": argument list too long
    while executing
"open [concat $cmd $ids] r"
    (procedure "getallcommits" line 47)
    invoked from within
"getallcommits"
    (procedure "readcache" line 80)
    invoked from within
"readcache file10"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)


Regards,
Nicolas

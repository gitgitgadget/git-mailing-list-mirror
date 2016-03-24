From: "Fu, Siyuan" <siyuan.fu@intel.com>
Subject: "git svn fetch" error: [main] perl 9296 child_info_fork::abort:
 unable to map
Date: Thu, 24 Mar 2016 02:07:08 +0000
Message-ID: <B1FF2E9001CE9041BD10B825821D5BC5548BEBDC@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 03:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiugD-0001LY-1G
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 03:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbcCXCHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 22:07:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:11815 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbcCXCHM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 22:07:12 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2016 19:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,383,1455004800"; 
   d="scan'208";a="917606645"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2016 19:07:11 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Wed, 23 Mar 2016 19:07:11 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.232]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.18]) with mapi id 14.03.0248.002;
 Thu, 24 Mar 2016 10:07:09 +0800
Thread-Topic: "git svn fetch" error: [main] perl 9296
 child_info_fork::abort: unable to map
Thread-Index: AdGFcd3RujtHNm7eRDuQ82IH0ELsoQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_IC
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGRmMzY1NmQtZDZiOC00YTY1LWIxODctZGM2YWMxNGM0MzhlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6IjIrY0tUSVhoOEE1RXlIRk5ZUU1XSlwvVmxiVjJjT282V201K3VxandGU2lRPSJ9
x-originating-ip: [10.239.127.40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289705>

Hi, all

I meet below error when using the "git svn" related command, and I tried to reinstall the GIT but the issue is still there. Has anybody ever meet this and know how to solve it? 

GIT version: git version 2.7.4.windows.1
OS: Windows 8 64bit

$ git svn fetch
      4 [main] perl 9296 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
      4 [main] perl 4480 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
     12 [main] perl 8572 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114


Best Regards
Siyuan

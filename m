From: "Fu, Siyuan" <siyuan.fu@intel.com>
Subject: RE: "git svn fetch" error: [main] perl 9296 child_info_fork::abort:
 unable to map
Date: Fri, 25 Mar 2016 00:53:48 +0000
Message-ID: <B1FF2E9001CE9041BD10B825821D5BC5548BF876@shsmsx102.ccr.corp.intel.com>
References: <B1FF2E9001CE9041BD10B825821D5BC5548BEBDC@shsmsx102.ccr.corp.intel.com>
 <alpine.DEB.2.20.1603241348220.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 01:54:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajG0w-0007Os-9S
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbcCYAyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:54:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:10384 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbcCYAyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 20:54:00 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP; 24 Mar 2016 17:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,388,1455004800"; 
   d="scan'208";a="771016033"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2016 17:53:51 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Thu, 24 Mar 2016 17:53:51 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.232]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.42]) with mapi id 14.03.0248.002;
 Fri, 25 Mar 2016 08:53:49 +0800
Thread-Topic: "git svn fetch" error: [main] perl 9296
 child_info_fork::abort: unable to map
Thread-Index: AdGFcd3RujtHNm7eRDuQ82IH0ELsoQAFr4yAACoB92A=
In-Reply-To: <alpine.DEB.2.20.1603241348220.4690@virtualbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_IC
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTE1M2Y5ZjAtMGVkOS00MDI1LWEwZTUtMzQzOGJkOTBhZjg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6Ing4Z0VsVzFYVGFCWlliY1BOenR3c01SSW9tbktOMkl3N1JXVk8xbm1sNFE9In0=
x-originating-ip: [10.239.127.40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289839>

Johannes,

I don't have detail steps for the reproduce, but I could share some information.

Yesterday one of my colleagues told me he also met this error after he updated GIT to latest 2.7.4, same with me. Then we uninstall the 64bit GIT and install a 32bit GIT on our 64bit Windows 8 machines, and the new installed 32bit GIT works well.

We are using the TortoiseGit with GIT, beside this I think there are no more special different settings.

Thanks
Siyuan

> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> Sent: Thursday, March 24, 2016 8:50 PM
> To: Fu, Siyuan <siyuan.fu@intel.com>
> Cc: git@vger.kernel.org
> Subject: Re: "git svn fetch" error: [main] perl 9296 child_info_fork::abort: unable to map
> 
> Hi Siyuan,
> 
> On Thu, 24 Mar 2016, Fu, Siyuan wrote:
> 
> > I meet below error when using the "git svn" related command, and I tried
> > to reinstall the GIT but the issue is still there. Has anybody ever meet
> > this and know how to solve it? 
> > 
> > GIT version: git version 2.7.4.windows.1
> > OS: Windows 8 64bit
> > 
> > $ git svn fetch
> >       4 [main] perl 9296 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
> >       4 [main] perl 4480 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
> >      12 [main] perl 8572 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
> 
> The problem has been reported to Git for Windows' bug tracker (twice,
> actually):
> 
>   https://github.com/git-for-windows/git/issues/650
> 
> The problem is that it seems to be impossible to reproduce this error
> except with *some* setups.
> 
> If you can help me to reproduce it, we are a big step closer to resolving
> the problem.
> 
> Ciao,
> Johannes
>

From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Fri, 13 Jun 2014 06:11:34 +0200
Message-ID: <539A79F6.9020905@web.de>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>		<xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>	 <xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>	 <53969FDF.3050506@viscovery.net> <1402622313.5629.45.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 06:11:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvIqF-0000ug-LF
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 06:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbaFMELo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 00:11:44 -0400
Received: from mout.web.de ([212.227.17.11]:54007 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbaFMELo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 00:11:44 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGiUP-1WzvOT0VqT-00DVLS; Fri, 13 Jun 2014 06:11:36
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1402622313.5629.45.camel@stross>
X-Provags-ID: V03:K0:Lio2j2wGCN/VxFA3iMT0q9EaaJgpYC6YIWyQ9CiCnl0xmYGtZHi
 O3hGjmxEBHo7YqfXH8vfhf+HVCJOCv8J1g9M1oLnQWwpRiw8o/HdLdDui8ZMriXYv5tq/wF
 CYklVGKeayq1hljjOke0dqU0GUbxiE3333BVlK85RtgCdqh6Q8kxSu9nMDR4/X7cyPYnLBn
 xbzZkK62hsxWjstih+mZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251514>

On 2014-06-13 03.18, David Turner wrote:
[]
> 
> It is too old for my patch because it doesn't support ifunc (and I
> suspect that no version of GCC for Windows supports ifunc).  But that
> does not seem to be what is going on in your error message.  Instead,
> when we #include <cpuid.h>, we get compat/cpuid.h rather than the
> system's cpuid.h. When I rename compat/cpuid.h to something else 
compat/git_cpuid.h ?

> I'm testing on a Windows 8 VM from modern.ie with msysgit's
> "netinstaller" -- is that a reasonable test environment?

Many people are using Windows 7,
and we shouldn't break for things for Windows XP.

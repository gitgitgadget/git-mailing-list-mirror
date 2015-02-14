From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [msysGit] Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Sat, 14 Feb 2015 09:36:43 +0100
Message-ID: <54DF091B.9070903@web.de>
References: <20150114211712.GE1155@peff.net>	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>	<20150115222719.GA19021@peff.net>	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>	<20150115235752.GB25120@peff.net>	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>	<20150116013256.GA25894@peff.net>	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>	<xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>	<54C170E9.4010401@web.de>	<xmqqlhkusc4h.fsf@gitster.dls.corp.google.com> <54C1E395.30003@web.de> <xmqqzj8ipxj6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 09:37:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMYDj-0002Dx-Kj
	for gcvg-git-2@plane.gmane.org; Sat, 14 Feb 2015 09:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbbBNIgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2015 03:36:55 -0500
Received: from mout.web.de ([212.227.17.11]:53697 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbbBNIgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2015 03:36:55 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Ls91n-1XafQF2RR9-013wZ8; Sat, 14 Feb 2015 09:36:48
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqzj8ipxj6.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:lO1aiIhHUwJKzBP0Pm8kqyRcw4ERPwXfPF32NQArFS4SO0rv6Ph
 TQ4GJNGEZsnm7xgAR5Yl4rw25AobNIQIWBkz8oxssYlBshiJx8CWrjO9E0jXU17qomHqJod
 2yQhStjWgqdBjikNYuGTS3n/tLG8OpMznd8dF01mcBcsAJY00muG4jj0XMsw4VcFKczmu+9
 bH8KkTweuJNwMOAGaV4WA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263850>

On 2015-02-12 23.36, Junio C Hamano wrote:
> So after discussing this one and queuing the resulting three-patch
> series jk/sanity that consists of the three patches:
> 
>     * jk/sanity (2015-01-27) 3 commits
>      - test-lib.sh: set prerequisite SANITY by testing what we really need
>      - tests: correct misuses of POSIXPERM
>      - t/lib-httpd: switch SANITY check for NOT_ROOT
> 
>      Waiting for ack or counter-proposal from Torsten.
>      Otherwise looking good.
> 
> Do we want to proceed with these, or do we want any more work done
> on them?
> 
I managed to run the tests with POSIXPERM and/or SANITY under
Cygwin, Msysgit, Linux, root@linux,  Mac and root@Mac.
All passed.

The work to "be done", what I can see: please amend the commit message: 
 s/more exotic//

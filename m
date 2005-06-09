From: Konstantin Antselovich <konstantin@antselovich.com>
Subject: Re: [ANNOUNCE] Cogito-0.11.3
Date: Thu, 09 Jun 2005 03:10:12 -0700
Organization: http://konstantin.antselovich.com
Message-ID: <42A81584.90605@antselovich.com>
References: <20050609091909.GF29665@pasky.ji.cz>
Reply-To: Konstantin Antselovich <konstantin@antselovich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 13:16:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgJyB-0003Cv-Eo
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 12:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVFIKMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 06:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVFIKMx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 06:12:53 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:462 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261628AbVFIKMm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 06:12:42 -0400
Received: from proliant.myhome (c-24-130-184-220.hsd1.ca.comcast.net[24.130.184.220])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005060910124101600dutsoe>; Thu, 9 Jun 2005 10:12:41 +0000
Received: from [192.168.0.2] (lifebook.myhome [192.168.0.2])
	(authenticated bits=0)
	by proliant.myhome (8.13.3/8.12.8) with ESMTP id j599b4Ia014124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jun 2005 02:37:05 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050609091909.GF29665@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: ClamAV 0.85.1/921/Wed Jun  8 01:51:44 2005 on proliant.myhome
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>   Hello,
> 
>   it turned out that Cogito was so broken w.r.t. three-way merging that
> I had to really release a bugfix version. So this version contains some
> cleanups of the merge script, some more portability fixes (it actually
> runs on Debian old stable now!), and especially few bugfixes - cg-log
> works with individual files passed to it now, and merging should
> hopefully work correctly now too.
> 
>   You know what to do. :-)

Hi Petr,

I have updated to Cogito-0.11.3, it compiles and runs
but make test returns multiple error messages (see below)

Rgds,
Konstantin



*** t6001-rev-list-merge-order.sh ***
fatal: merge order sort unsupported, OpenSSL not linked
fatal: merge order sort unsupported, OpenSSL not linked
*   ok 1: Testing that the rev-list has correct number of entries
* FAIL 2: Testing that --merge-order produces the correct result diff
expected-merge-order actual-merge-order
*   ok 3: Testing that --merge-order produces as many or fewer
discontinuities
fatal: merge order sort unsupported, OpenSSL not linked
* FAIL 4: Testing multiple heads diff expected-merge-order-1
actual-merge-order-1
fatal: merge order sort unsupported, OpenSSL not linked
* FAIL 5: Testing stop diff expected-merge-order-2 actual-merge-order-2
fatal: merge order sort unsupported, OpenSSL not linked
* FAIL 6: Testing stop in linear epoch diff expected-merge-order-3
actual-merge-order-3
fatal: merge order sort unsupported, OpenSSL not linked
* FAIL 7: Testing start in linear epoch, stop after non-linear epoch
diff expected-merge-order-4 actual-merge-order-4
* FAIL 8: Testing duplicated start arguments diff expected-merge-order-4
actual-merge-order-5
* FAIL 9: Testing exclusion near merge git-rev-list --merge-order $a4
^$c3 2>/dev/null
* failed 7 among 9 test(s)
make[1]: *** [all] Error 1
make[1]: Leaving directory `/home/konstantin/git/cogito/t'
make: *** [test] Error 2



> 


-- 
Konstantin Antselovich
mailto: konstantin@antselovich.com
http://konstantin.antselovich.com

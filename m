From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Apr 2015, #02; Tue, 14)
Date: Wed, 15 Apr 2015 10:32:17 +0200
Message-ID: <552E2211.7080704@web.de>
References: <xmqqh9si1itr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 10:32:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiIkd-0003KB-FT
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 10:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbbDOIck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 04:32:40 -0400
Received: from mout.web.de ([212.227.15.4]:59708 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbbDOIcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 04:32:35 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LdEif-1Z94zP3L1d-00iPgm; Wed, 15 Apr 2015 10:32:23
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqh9si1itr.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:qE/MGAaifPskTgJwmUeQLe7PunQUWVrnGU8S1P42x526EyD+7xS
 s9kavFshMpD9ms/VzkQ8zlP6zNQ+kYy4tdLtnCpZkS3ETKPTVxx6OI6V/B2HgGJr57duQdP
 HlluG1BNcfnAKKfvDBFcmm8gFoMtakv/djIsIclS8PtI7oqbvBi9Z6k/dnfXbOtMxZ6Pdxq
 Y9Apen4j552/nOuH2GPow==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267191>

On 2015-04-14 23.49, Junio C Hamano wrote:
> * tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
>  - perf-lib: add test_perf_cleanup target
>  - perf-lib: split starting the test from the execution
> 
>  Add test_perf_cleanup shell function to the perf suite, that allows
>  the script writers to define a test with a clean-up action.
> 
>  Will hold.
Is there a chance to squeeze in a fix for this:
./t/perf/perf-lib.sh:185: error: echo -n is not portable (please use printf):  echo -n " c$i"

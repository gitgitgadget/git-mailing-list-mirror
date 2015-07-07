From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: undocumented core.sharedRepository=2 set by git init
 --shared=world
Date: Tue, 7 Jul 2015 08:44:58 +0200
Message-ID: <559B756A.2040202@web.de>
References: <20150706192547.GA15396@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Joey Hess <id@joeyh.name>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 08:45:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCMd1-00049x-Th
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 08:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbbGGGpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 02:45:11 -0400
Received: from mout.web.de ([212.227.17.12]:53385 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbbGGGpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 02:45:09 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MGiUP-1ZGR5F2mAL-00DWFN; Tue, 07 Jul 2015 08:45:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <20150706192547.GA15396@kitenet.net>
X-Provags-ID: V03:K0:AOLpnH794Qrt2SQ3i6NmvCk72SJQDlkWZEwmJXLtFrYlS69y3MW
 g0anI0DPSWCXDskmroZfjUsmdsUyHmVJOUiLM793pj8ohU8DvQlhnhUUnFf2hRU9K3PHKCe
 DdRAc5D09C8djBlOvoosnle0tqsq56S1OkTC+PeVjx6ptk1SfImJLSrrp1+cX++DEmOR4cP
 1vQury1OkeMusrCrFNBNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WntwZuUihD8=:SRpgTjIUeyFp7tF1i8wXd6
 uodmpwGefRLwT9FZRrTinM/O3ZdKuSU4BX03cn8v0Whdg53pUVmg/MSfsLtwPNBcwU2aSM8CF
 eU7hc/om5L8trHQ+vvI1tMByXW65Yn2rsNCQzIs7/bDmrXnLZmNYPCe0fThL+5U/VwxkNA/jA
 Nq4XjZljg3H/dV9TYb1zDljAwYVDEnpCwu/7+F7ukKPjB8Kv1LDNhk7PBSQeKW/a7eYoHbcV9
 5Y0q6YOcSLTm/Vz+41HzOCiCQwelY5iWJa/sANGARTGbC82ineb6BEqau5uWk1AOMJmWgGsr1
 dUvUjlUkynnqE6UwTAGxxgTppBIFnY4oyAzI7XehUdjSoNqXSPpwoHMFipGwrpfpEhJpSH1VH
 yrewGPJIoMxMu46Qx8vn1nZ7K5w/lttPJOD+9r4J6dTR42WmMeWPw+flA9V7Rd/ZK/KweX47y
 Gs9l+otMHPfFSJnZH9onA3DYzftZ/XVGXR5KD0pWeuIIOGUGJYqy2otg2X2tvWzjOFdeScGrN
 6HCCbKgRKi5rh2tTG/t/p9VMuqzUuckd1S0wnQ9Z1/gBC2Rz+dsBLzqV279Jeli9Z6Ran1Qsu
 Ql/tGSUfGd6QDOqdhd1VASHo6J6ws1/W8lC3JcyFGnH9UhSu9d/HP4ZkO/qQX5OI2vdKy7ZHs
 xa6RlX3bIZtvOVfgQz3FQc+N1gvm/6CrQVhcav0Qi5NDJ+aTyw/9akUCtzv/BfOdD1AM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273480>

On 2015-07-06 21.25, Joey Hess wrote:
> joey@darkstar:~/tmp>git init --shared=world testrepo
> Initialized empty shared Git repository in /home/joey/tmp/testrepo/.git/
> joey@darkstar:~/tmp>grep shared testrepo/.git/config 
> 	sharedrepository = 2
> 
> This magic value of 2 seems to be undocumented, as is the magic value of 1
> that's equvilant to "group".
> 
> I think it would be better to have git init put in "world" or "group" and not
> these magic values. 
Thanks for the report.
Changing the behavior of Git may cause problems with
- older versions of Git
- Other implementations of Git, like JGit, libgit2, ...

Did you check what these implementations do ?

Anyway, I suppose they ought to be documented too.
> 
Yes.
Do you want to send a patch ?

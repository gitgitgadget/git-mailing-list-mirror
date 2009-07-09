From: Andreas Ericsson <ae@op5.se>
Subject: wsfix alias
Date: Thu, 09 Jul 2009 22:54:39 +0200
Message-ID: <4A56590F.9050206@op5.se>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <4A55958E.1050401@op5.se> <20090709160249.GA12830@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Larry D'Anna <larry@elder-gods.org>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:54:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP0dn-0001ZP-DB
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 22:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbZGIUyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbZGIUyo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 16:54:44 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41642 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753653AbZGIUyo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 16:54:44 -0400
Received: from source ([209.85.219.211]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSlZZEqUFnFoRkeRalmbbbMVAq8/+xJhH@postini.com; Thu, 09 Jul 2009 13:54:44 PDT
Received: by ewy7 with SMTP id 7so542870ewy.44
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 13:54:41 -0700 (PDT)
Received: by 10.210.42.20 with SMTP id p20mr269679ebp.60.1247172881217;
        Thu, 09 Jul 2009 13:54:41 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 7sm1109124eyb.45.2009.07.09.13.54.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 13:54:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090709160249.GA12830@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123009>

Larry D'Anna wrote:
> * Andreas Ericsson (ae@op5.se) [090709 03:04]:
>> I do have one alias, which is "wsfix". It fixes whitespace fsckups I've
>> added to the index but not yet committed to the worktree. It's not a
>> particularly complex one, but not exactly simple either.
> 
> oooh, i can has?
> 
>       --larry

These are quite stupid and can lose data for you. Please use with some care.
Oh, and I lied. I have two aliases. wsfixi is the one that applies staged
stuff. wsfix fixes all whitespace errors since the last commit and stages
all changes in the index. Again, use with care, and don't hang me if they
break your day ;-)

Mind the wrapping if your mua does things like that.

[alias]
  wsfix = !git diff HEAD >P.diff && git reset --hard && git apply --whitespace=fix P.diff && rm -f P.diff
  wsfixi = !git diff --cached >P.diff && git reset && git apply --whitespace=fix P.diff && rm -f P.diff

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

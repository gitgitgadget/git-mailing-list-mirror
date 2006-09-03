From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Sun, 03 Sep 2006 11:17:13 +0200
Organization: At home
Message-ID: <ede6in$b9u$1@sea.gmane.org>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com> <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com> <9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 03 11:17:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJo6k-0003qm-BK
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 11:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWICJRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 05:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWICJRT
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 05:17:19 -0400
Received: from main.gmane.org ([80.91.229.2]:55185 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750932AbWICJRS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 05:17:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJo6O-0003mu-Tv
	for git@vger.kernel.org; Sun, 03 Sep 2006 11:17:16 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 11:17:16 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 11:17:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26365>

Jon Smirl wrote:

>> Oh, and "partial tree pulls for localisers". Perhaps git-cvsserver can
>> help there? Localisers can just use TortoiseCVS and get a checkout of
>> the language pack subdir.
> 
> Partial repo pulls and an issue to. The mozilla repo has much more
> than a browser in it, it also has a large mail/news program. A partial
> repo pull may not be what is needed for git, instead git needs a
> partial repo checkout.

Or better support for subprojects.

I think you can fake subproject support using separate repositories
for subprojects, in the directory matching the one in the whole project,
and the project repository, where we pull/push subprojects into.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git



-- 
VGER BF report: U 0.877495

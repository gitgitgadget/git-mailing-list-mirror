From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Linux Kernel based project in git
Date: Sat, 06 Feb 2010 12:43:36 +0100
Message-ID: <hkjkl7$8eg$1@ger.gmane.org>
References: <9da7f2802f639777acfeb38eb1e3db90.squirrel@webmail.eisendle.net> <32541b131002021153t53d19e32j56be356c219c5780@mail.gmail.com> <be6731d603701c3c5befc79613fd451b.squirrel@webmail.eisendle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 12:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndj6F-00008J-1n
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 12:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab0BFLpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 06:45:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:38587 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261Ab0BFLpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 06:45:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ndj62-0008TX-D1
	for git@vger.kernel.org; Sat, 06 Feb 2010 12:45:06 +0100
Received: from dslb-092-078-139-127.pools.arcor-ip.net ([92.78.139.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 12:45:06 +0100
Received: from steveire by dslb-092-078-139-127.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 12:45:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-092-078-139-127.pools.arcor-ip.net
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139158>

Christian Eisendle wrote:
>>> IMHO it would make sense to have 3 branches (BSP, USB, WiFi) each based
>>> on
>>> unmodified 2.6.22 Kernel. USB and WiFi branch is used for generating the
>>> patch and for applying possible fixes. BSP branch for actual BSP related
>>> feature development and fixes.
>>> The changes in these branches are merged into the master branch which is
>>> used for compiling/testing the whole BSP.
>>
>> Are you planning to submit these patches upstream at any point?  If
>> not, it might be easiest to just jam them all together in one branch
>> and not look back.  Since it seems like they probably affect quite
>> different parts of the code, you could always extract a clean set of
>> patches *later* and submit those patches upstream.
> 
> For BSP I plan to upstream eventually.
> 
> The basic idea was to divide the project in three different patches since
> USB and WiFi comes from a third party and is not released under GPL (well,
> different story...)

Do you distribute this kernel?

From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 11:48:47 -0400
Message-ID: <FEEB35B3-20DA-4446-90D3-B6725354DF08@kellerfarm.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <86k4mhfcj1.fsf@red.stonehenge.com> <6BE502C9-5507-452D-A5D5-D0C69C05F126@kellerfarm.com> <677DFF75-2DBB-4772-802B-4402E4024307@sb.org> <vpqzkvcwka0.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 17:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxibv-0003gW-Ii
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 17:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0ITPst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 11:48:49 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:33319 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751844Ab0ITPst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 11:48:49 -0400
Received: from host-211-194.meilvil.clients.pavlovmedia.com ([96.63.211.194])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1Oxibi-0004E9-Dc
	for git@vger.kernel.org; Mon, 20 Sep 2010 11:48:42 -0400
In-Reply-To: <vpqzkvcwka0.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156631>

On Sep 20, 2010, at 10:40 AM, Matthieu Moy wrote:
> Kevin Ballard <kevin@sb.org> writes:
>> Andrew Keller <andrew@kellerfarm.com> writes:
>> 
>>> $ ./configure --prefix=/usr/users/students/ak4390/.local
>>> $ make
>>> $ make install
>> 
>> I admit, I'm not well-versed on the build system, but my impression
>> was that specifying --prefix in ./configure was indeed supposed to
>> propagate to a subsequent make and make install.
> 
> It does. I installed Git successfully without ever being root on
> several machines.
> 
> In my case, it was GNU/Linux machines, so something may go wrong
> because of a non-gnu system. Did you try compiling with gmake instead
> of make?

Just did.  There is no change in the result.  A website also suggested disabling curl support, and defining INSTALL as /usr/ucb/install.  No change.  The install target is very insistent on installing into /usr/perl5/site_perl/5.6.1/sun4-solaris-64int.

~ Andrew Keller

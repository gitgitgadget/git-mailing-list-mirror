From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 14:49:05 -0700
Message-ID: <7vk6mm608e.fsf@assigned-by-dhcp.cox.net>
References: <42703E79.8050808@zytor.com>
	<1114673723.12012.324.camel@baythorne.infradead.org>
	<20050428081005.GG8612@pasky.ji.cz>
	<1114676955.12012.346.camel@baythorne.infradead.org>
	<1114680199.12012.363.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
	<7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
	<1114724307.2734.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:44:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGnL-0006Nt-6B
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVD1VtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVD1VtK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:49:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31436 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262265AbVD1VtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:49:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428214907.MIWL26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 17:49:07 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114724307.2734.17.camel@localhost.localdomain> (David
 Woodhouse's message of "Thu, 28 Apr 2005 22:38:26 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DW" == David Woodhouse <dwmw2@infradead.org> writes:

DW> On Thu, 2005-04-28 at 14:21 -0700, Junio C Hamano wrote:
>> "I want to view commit between these ones---give me a linearlized list
>> of commits."  When following the ancestor chain from the current top,
>> we can immediately stop upon seeing a commit made before the timestamp
>> of the named bottom one.

DW> This absolutely must not be timestamp based. If I ask for a list of
DW> commits before 2.6.12-rc3 and 2.6.12-rc4 I _really_ want to see those
DW> commits which happened before 2.6.12-rc3 but in a remote tree which was
DW> only later pulled. That's what 'rev-tree AAAAAA ^BBBBBB' already gives
DW> you.

How true.  I stand corrected.


From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Thu, 02 Aug 2007 13:47:27 -0700
Message-ID: <7vhcnhvf34.fsf@assigned-by-dhcp.cox.net>
References: <1185880790812-git-send-email-jnareb@gmail.com>
	<200708020158.50343.jnareb@gmail.com>
	<7vtzri1pfi.fsf@assigned-by-dhcp.cox.net>
	<200708021247.08612.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGha1-0000Cn-Vi
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbXHBUr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbXHBUr3
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:47:29 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63345 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbXHBUr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:47:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802204728.TAKR1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 16:47:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X8nT1X00P1kojtg0000000; Thu, 02 Aug 2007 16:47:28 -0400
In-Reply-To: <200708021247.08612.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 2 Aug 2007 12:47:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54605>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Personally, this late in the game, I would be more interested in
>> resolving the File::Find() stuff, which has been a real issue in
>> the field, than the compressed transfer one.
>
> I posted my tentative Ack, haven't I?
>
> I guess that your solution is good, and doesn't have any drawbacks,
> besides perhaps a tiny little bit of lost performance. So I think
> that you should just commit this...
>
>
> As to the new stuff: I think I postpone large changes, like blob
> size in tree view, or links to no merges and first parent 
> log/shortlog/history view, or list form of two pipelines we have in 
> gitweb, or HTML cleanup, etc. after the v1.5.3 release.

Thanks, alright, I am relieved to know that we are on the same
page.

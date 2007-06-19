From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 14:11:32 -0700
Message-ID: <7vk5tzwsxn.fsf@assigned-by-dhcp.pobox.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
	<20070619132456.GA15023@fiberbit.xs4all.nl>
	<18039.57099.57602.28299@lisa.zopyra.com>
	<20070619143000.GA15352@fiberbit.xs4all.nl>
	<18039.60598.264803.940960@lisa.zopyra.com>
	<86k5u0q8q9.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0kzC-0004Pr-C3
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbXFSVLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 17:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbXFSVLf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 17:11:35 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62120 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbXFSVLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 17:11:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070619211134.ILIZ1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 19 Jun 2007 17:11:34 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DZBY1X00l1kojtg0000000; Tue, 19 Jun 2007 17:11:33 -0400
In-Reply-To: <86k5u0q8q9.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Tue, 19 Jun 2007 17:12:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50509>

David Kastrup <dak@gnu.org> writes:

> Not sure whether this is the problem: either cd does not understasnd
> the double slashes, or your shell used for scripts has modified cd to
> output some stuff when it is working (people sometimes imprudently
> make shell functions or aliases for this).
>
> Try writing something like
>
> type cd
>
> in a script file and see what output you get.

A one-word guess: CDPATH.

Bill, setting CDPATH in your interactive shell as a shell
variable is Ok, but exporting it as an environment does not make
much sense.

Really.

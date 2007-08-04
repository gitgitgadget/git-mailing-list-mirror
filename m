From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sat, 04 Aug 2007 11:27:04 -0700
Message-ID: <7vps23gnpj.fsf@assigned-by-dhcp.cox.net>
References: <20070804070308.GA6493@coredump.intra.peff.net>
	<Pine.LNX.4.64.0708041636290.14781@racer.site>
	<20070804160409.GA16326@sigill.intra.peff.net>
	<7vwswbgphu.fsf@assigned-by-dhcp.cox.net>
	<20070804175240.GB17113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 20:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHOLO-0006Pv-7z
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 20:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765005AbXHDS1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764996AbXHDS1H
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 14:27:07 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37245 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661AbXHDS1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 14:27:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804182706.BMZV2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 14:27:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XuT51X00C1kojtg0000000; Sat, 04 Aug 2007 14:27:05 -0400
In-Reply-To: <20070804175240.GB17113@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 4 Aug 2007 13:52:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54894>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 04, 2007 at 10:48:29AM -0700, Junio C Hamano wrote:
>
>> I was hoping that we can say that the output is analogous to the
>> native transport reporting "Conting objects: XXXX" and stuff...
>
> It always says "0 blocks" for me, which looks a bit like an error (but
> the clone seems to work fine).

Try cloning across filesystem boundaries so that you do not get
a hardlink -- you will get block count of the copy ;-)

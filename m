From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stop inflating the whole SHA1 file only to check size.
Date: Wed, 01 Jun 2005 18:32:04 -0700
Message-ID: <7vll5th7cb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
	<7vacmapo18.fsf@assigned-by-dhcp.cox.net>
	<7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
	<7vpsv6kqx0.fsf@assigned-by-dhcp.cox.net>
	<7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsv5hbm5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0506012048330.17354@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Daniel Barkalow <barkalow@iabervon.org> Git Mailing List" 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 03:29:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdeWK-0001lI-C7
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 03:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVFBBcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 21:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVFBBcK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 21:32:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40666 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261556AbVFBBcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 21:32:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602013204.VDFT12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 21:32:04 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506012048330.17354@localhost.localdomain> (Nicolas
 Pitre's message of "Wed, 01 Jun 2005 20:51:28 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> On Wed, 1 Jun 2005, Junio C Hamano wrote:
>> Using the new unpack_sha1_file_partial() function, stop
>> inflating the whole SHA1 file when rename detector wants to know
>> only the filesize.

NP> Beware.

You are right.  I cannot believe how stupid I am, falling into
this trap _just_ _after_ looking at the delta stuff X-<.

Linus please drop that one.




From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 13:50:56 -0400 (EDT)
Message-ID: <2646.10.10.10.24.1114278656.squirrel@linux1>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>       
    <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>       
    <426A4669.7080500@ppp0.net>       
    <1114266083.3419.40.camel@localhost.localdomain>       
    <426A5BFC.1020507@ppp0.net>      
    <1114266907.3419.43.camel@localhost.localdomain>      
    <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David Woodhouse" <dwmw2@infradead.org>,
	"Jan Dittmer" <jdittmer@ppp0.net>, "Greg KH" <greg@kroah.com>,
	"Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 20:50:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPhM-0004lr-Td
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVDWSyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVDWSvL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 14:51:11 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:41463 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261715AbVDWSuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 14:50:23 -0400
Received: from linux1 ([67.71.124.169]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050423185017.XRUM3701.simmts7-srv.bellnexxia.net@linux1>;
          Sat, 23 Apr 2005 14:50:17 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3NHorMJ022038;
	Sat, 23 Apr 2005 13:50:53 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 23 Apr 2005 13:50:56 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, April 23, 2005 1:31 pm, Linus Torvalds said:

> If somebody writes a script to generate the above kind of thing (and
tells me how to validate it), I'll do the rest, and start tagging things
properly. Oh, and make sure the above sounds sane (ie if somebody has a
better idea for how to more easily identify how to find the public key to
> check against, please speak up).
>

Hi Linus,

Why not leave tags open to being signed or unsigned?  Anyone that wants to
create a trusted tag could simply sign their cleartext entry in the tag
object.

Ideally the SHA1 tree reference would be included in the text entry
whether it was signed or not.   Thus any script can pull the SHA1 out of
the text entry.  And a script that understands the signing method can
verify it.  But scripts that don't understand the signing method can still
use the tag.

For presentation in the log or whatever, the script can look inside the
clear text message, grab the SHA1 and display it in the header area; even
though it's not really in the header, always just in the clear text area.

Sean







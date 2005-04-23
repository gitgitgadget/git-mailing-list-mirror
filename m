From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 14:06:29 -0400 (EDT)
Message-ID: <2911.10.10.10.24.1114279589.squirrel@linux1>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>   
    <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>   
    <426A4669.7080500@ppp0.net>   
    <1114266083.3419.40.camel@localhost.localdomain>   
    <426A5BFC.1020507@ppp0.net>   
    <1114266907.3419.43.camel@localhost.localdomain>   
    <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>   
    <20050423175422.GA7100@cip.informatik.uni-erlangen.de>   
    <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>,
	"David Woodhouse" <dwmw2@infradead.org>,
	"Jan Dittmer" <jdittmer@ppp0.net>, "Greg KH" <greg@kroah.com>,
	"Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPsZ-0005wH-KA
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVDWTGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVDWTGA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:06:00 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:58623 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261703AbVDWTFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 15:05:51 -0400
Received: from linux1 ([67.71.124.169]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050423190550.SBSA1597.simmts6-srv.bellnexxia.net@linux1>;
          Sat, 23 Apr 2005 15:05:50 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3NI6S0j022341;
	Sat, 23 Apr 2005 14:06:28 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 23 Apr 2005 14:06:29 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, April 23, 2005 2:30 pm, Linus Torvalds said:
> On Sat, 23 Apr 2005, Thomas Glanzmann wrote:
>> # This creates the signature.
>> gpg --clearsign < sign_this > signature
>
> This really doesn't work for me - I do not want to have the gpg header
above it, only the signature below. Since I want git to actually
understand the tags, but do _not_ want git to have to know about
whatever
> signing method was used, I really want the resulting file to look like
>
> 	commit ....
> 	tag ...
>
> 	here goes comment
> 	here goes signature
>
> and no headers.
>
> Whether that can be faked by always forcing SHA1 as the hash, and then
just removing the top lines, and re-inserting them when verifying, or
whether there is some mode to make gpg not do the header crud at all, I
don't know. Which is exactly why I never even got started.

Linus,

A script that knows how to validate signed tags, can easly strip off all
the signing overhead for display.   Users of scripts that don't understand
will see the cruft, but at least it will still be usable.

Sean



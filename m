From: Paul Jakma <paul@clubi.ie>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 04:47:07 +0100 (IST)
Message-ID: <Pine.LNX.4.62.0504250443380.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <426C5F43.8010705@dwheeler.com>
 <Pine.LNX.4.62.0504250413200.14200@sheen.jakma.org>
 <Pine.LNX.4.62.0504250435050.14200@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="299119927-679278751-1114400738=:14200"
Cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 05:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPuUa-0007KK-Sq
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 05:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVDYDre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 23:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVDYDre
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 23:47:34 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:53122 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262514AbVDYDrZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 23:47:25 -0400
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id j3P3l4fa016650;
	Mon, 25 Apr 2005 04:47:05 +0100
X-X-Sender: paul@sheen.jakma.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <Pine.LNX.4.62.0504250435050.14200@sheen.jakma.org>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
Content-ID: <Pine.LNX.4.62.0504250446020.14200@sheen.jakma.org>
X-Virus-Scanned: ClamAV 0.83/851/Mon Apr 25 02:19:30 2005 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--299119927-679278751-1114400738=:14200
Content-Type: TEXT/PLAIN; CHARSET=utf-8; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0504250446021.14200@sheen.jakma.org>

On Mon, 25 Apr 2005, Paul Jakma wrote:

> Uh, I have no idea whether verifying a signature of a commit object is 
> sufficient, ie equivalent to signing each file.
>
> commit refers to tree objects, which I presume lists the SHA-1 object IDs of 
> files, but IIRC Linus already described why a signature of the commit object 
> should not be used to trust the rest of commit.. (i'll have to find his 
> mail). If so, an index is required.

Ah, apparently it is sufficient:

Linus:

“Just signing the commit is indeed sufficient to just say "I trust 
this commit". But I essentially what to also say what I trust it 
_for_ as well.”

So this would work for commit objects.

It would also work for tag objects, if you pointed people at the signature
object rather than the actual tag object.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Humor in the Court:
Q.  Were you aquainted with the deceased?
A.  Yes, sir.
Q.  Before or after he died?
--299119927-679278751-1114400738=:14200--

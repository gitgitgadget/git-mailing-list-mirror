From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Sun, 7 Mar 2010 21:38:18 +0100
Message-ID: <201003072138.18583.chriscool@tuxfamily.org>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org> <7vaaukadap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 21:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoNFG-0007J9-0A
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 21:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0CGUid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 15:38:33 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:33835 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab0CGUic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 15:38:32 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 62A708180E2;
	Sun,  7 Mar 2010 21:38:21 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2DD45818127;
	Sun,  7 Mar 2010 21:38:19 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vaaukadap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141728>

On Sunday 07 March 2010 06:52:46 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > and give an example to show how it can be used.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> 
> Thanks.  With the example I think I can tell others that this at least has
> one known use case that is not totally whacky.
> 
> I haven't re-read Peter Baumann's comments that you dismissed as a
> mis-reading of your added documentation, but if somebody _can_ misread
> what you wrote, that is a sign that it has a room to be improved for
> clarity.

Ok, so instead of:

> +--keep::
> +     Resets the index to match the tree recorded by the named commit,
> +     but keep changes in the working tree. Aborts if the reset would
> +     change files that are already modified in the working tree.

what about:

--keep::
     Resets the index to match the tree recorded by the named commit,
     but changed files in the working tree are kept untouched. Aborts if the
     reset would touch any of them.

?

Thanks,
Christian.

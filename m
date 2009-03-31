From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] bisect: fix reading more than one path in "$GIT_DIR/BISECT_NAMES"
Date: Tue, 31 Mar 2009 07:36:42 +0200
Message-ID: <200903310736.42366.chriscool@tuxfamily.org>
References: <20090329114457.c6fca0fe.chriscool@tuxfamily.org> <7vocvjh25n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:39:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWgv-0006ut-Pn
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZCaFhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 01:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZCaFhr
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:37:47 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:49457 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbZCaFhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:37:47 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 4FA194C8104;
	Tue, 31 Mar 2009 07:37:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 5FE6F4C80AF;
	Tue, 31 Mar 2009 07:37:35 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vocvjh25n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115216>

Le lundi 30 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The implementation of "read_bisect_paths" worked with only one
> > path in each line of "$GIT_DIR/BISECT_NAMES", but the paths are all
> > stored on one line by "git-bisect.sh".
> >
> > So we have to process all the paths that may be on each line.
>
> This is "oops, the previous one is broken", for a series that was not=
 yet
> 'next' worthy, so I squashed the fix and rebuilt the topic, together =
with
> your other patches.

No problem.

> The series now looks like this:

[...]

> I've tweaked a few patches before applying, but they all looked basic=
ally
> sane.  Unless I hear from other people in a few days , I'd say we mer=
ge
> it to 'next' and start cooking it.

Thanks,
Christian.

From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 9/9] merge: use new "reset" function instead of running "git read-tree"
Date: Sat, 6 Feb 2010 16:34:01 +0100
Message-ID: <201002061634.02126.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org> <20100205231112.3689.34673.chriscool@tuxfamily.org> <7vbpg3nsbd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 16:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndmce-00074m-3p
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 16:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab0BFPaz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 10:30:55 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:51098 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab0BFPax convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 10:30:53 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3C2CA8180A4;
	Sat,  6 Feb 2010 16:30:44 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4925081810F;
	Sat,  6 Feb 2010 16:30:42 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vbpg3nsbd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139174>

On samedi 06 f=E9vrier 2010, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This simplifies "git merge" code and make it more efficient in some
> > cases.
>
> I vaguely recall somebody (perhaps it was you) tried to do something =
like
> this before to drive unpack_trees() inside the main process, broke th=
e
> program rather badly, and then we ended up keeping read-tree invocati=
on
> external to the process.  Am I misremembering things?

I don't think it was me and I don't recall that, but I don't follow all=
 the=20
threads on the mailing list.

I will search the archive, but any pointer would be very appreciated.

Thanks anyway,
Christian.

> If not, could you describe how is this round different from the old o=
ne?

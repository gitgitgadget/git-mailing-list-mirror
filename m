From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail, with change 
	from GPLv2 to GPLv2+.
Date: Sun, 21 Feb 2010 05:49:40 +0800
Message-ID: <be6fef0d1002201349r6b6c482fr674a83478fd33079@mail.gmail.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	 <87iqa2y0gz.fsf@steelpick.localdomain>
	 <87r5oqe7mi.fsf@yoom.home.cworth.org>
	 <871vgmki4f.fsf@steelpick.localdomain>
	 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	 <87tytdiqob.fsf@steelpick.localdomain>
	 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	 <873a0xhwxs.fsf@yoom.home.cworth.org>
	 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
	 <87eikfhec1.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	notmuch@notmuchmail.org, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 23:11:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NixD2-0003JE-7B
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 22:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462Ab0BTVtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2010 16:49:43 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:37106 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429Ab0BTVtm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Feb 2010 16:49:42 -0500
Received: by iwn7 with SMTP id 7so1337458iwn.4
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 13:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IBNpvD0Hl509e0JO+5P3XAl9jiyQ1FXebAZueH9eHx8=;
        b=NJFBwARGc3w3Sh5TtaJurVscvuqMkJQAASEMLnHSUJciBx4kFN4VFOebnE149Bj095
         lQY4APNzdMOdIHWyIz4a5RnospyYAJS7NwP8E43HycM3hMZBWVmgms5tqWW01SO6ZHaH
         j5HfzeafuDY7Qf+mRWE7tS+m6zOeCjK1sa+4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iVReVBoyFDFiX4++qW9+z/Rw6Aj09ynWfTsB6j7rtVJmN4Fopa9HRlrDqcQ6kAI7Z1
         uuBlv1R49ReHGHriwnuZy2w9Erl7SjNODk8/NADom8CNxGGAfi6SBJjoN6+8mVmxNUix
         HsAqsGYMAZiUdbjqp5+gzFciuS7vHezz1LBAc=
Received: by 10.231.159.207 with SMTP id k15mr2629099ibx.75.1266702580927; 
	Sat, 20 Feb 2010 13:49:40 -0800 (PST)
In-Reply-To: <87eikfhec1.fsf@yoom.home.cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140557>

Hi,

On Sun, Feb 21, 2010 at 3:55 AM, Carl Worth <cworth@cworth.org> wrote:
> The request for relicensing was presented to the git community in:
>
> =A0 =A0 =A0 =A0Message-ID: <871vgmki4f.fsf@steelpick.localdomain>
>
> and explicitly agreed to by Junio C Hamano, Sverre Rabbelier, Johanne=
s
> Schindelin, Pierre Habouzit, and Johannes Sixt.

(of all projects, Mercurial!) take a look at Mercurial's attempt at
relicensing last year (http://mercurial.selenic.com/wiki/Relicensing):
they contacted all 300+ contributors as part of the process.

Of course, we aren't talking about relicensing the whole codebase.
However, I don't think any of the contributors agreed to assign their
work to the 5 people mentioned above (eg. under a contributor licence
agreement), so just getting the approval of them is not enough; you
need to get the approval of *all* contributors to test-lib.sh.

Here's what I get with 'git shortlog t/test-lib.sh  | grep "^[A-Z]"'

   Alex Riesen (5):
   Brandon Casey (2):
   Bryan Donlan (3):
   Carl Worth (1):
   Christian Couder (1):
   Clemens Buchacher (3):
   David Reiss (1):
   Emil Sit (1):
   Eric Wong (3):
   Fredrik Kuivinen (1):
   Gerrit Pape (1):
   Jakub Narebski (1):
   Jeff King (7):
   Johan Herland (1):
   Johannes Schindelin (14):
   Johannes Sixt (12):
   Jonathan Nieder (1):
   Josh Triplett (1):
   Junio C Hamano (57):
   Lea Wiemann (5):
   Markus Heidelberg (1):
   Martin Waitz (1):
   Matthew Ogilvie (1):
   Matthias Lederhofer (1):
   Michael J Gruber (4):
   Michele Ballabio (2):
   Miklos Vajna (1):
   Nicolas Pitre (1):
   Pavel Roskin (3):
   Petr Baudis (3):
   Pierre Habouzit (2):
   Robin Rosenberg (1):
   Shawn O. Pearce (4):
   Stephan Beyer (1):
   Stephen Boyd (1):
   Sverre Rabbelier (2):

PS: This message should not be construed as legal advice.

--=20
Cheers,
Ray Chuan

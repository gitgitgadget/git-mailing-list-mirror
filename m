From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Lets avoid the SHA-1 term (was [doc] User Manual Suggestion)
Date: Mon, 27 Apr 2009 08:02:02 -0500
Message-ID: <b4087cc50904270602q17fba432ka219180d358fae47@mail.gmail.com>
References: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com>
	 <20090427002838.GF12338@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Abrahams <dave@boostpro.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 15:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyQTP-0005Yw-7d
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 15:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbZD0NCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 09:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbZD0NCE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 09:02:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:50017 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbZD0NCD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 09:02:03 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1971105qwd.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ynUjvtGa1vKljCKEhjY/FOI4N7H1u9BYlZwSV/MoTc=;
        b=UwtLOae43V68mJihyOOL5095RdnMAyB9ZHP3iMuwlnN09IOhVsrktF9KdB4v/nqcB9
         lcYggeY3t1SzeOOjTEiHvy4JrIZfQoTbkKlO0gC9sbkFf5GbUxIunGOp0t1L645FSpbw
         wkVfba2Z/+11bKd18KazcW+FgbGF+u8xr9xWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TrHMGz2gvSCpnEKfPATMkJsx3rtPS0WK9wXmM/dG2VRjh+KCBEfXqHngxsAYoalKYy
         cLsf3HlfoozK/Ap5SP1NGr4gKtqDtXvHZYMWyIo0RhOV276Z19x5UiSVp57AnGxqWnpy
         5qh1t8Uhhm7kuovB+IyZXAj1fSVLh2YXzdlO8=
Received: by 10.224.36.202 with SMTP id u10mr5839528qad.121.1240837322682; 
	Mon, 27 Apr 2009 06:02:02 -0700 (PDT)
In-Reply-To: <20090427002838.GF12338@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2009/4/26 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>
>> Do you agree that either 'id' or 'hash' would work fine?
>
> "object id" would work for me, but I'm fine with the existing "object
> name" as well. I don't like "object hash" (or "object hash id"), beca=
use
> it IMHO doesn't express that well that it's used to identify an objec=
t.

However, the SHA-1 hash is not actually essential to git. In the git
world, there is only content and every object is identified by its
content. Now, to identify an object, it would be pretty cumbersome to
have to write out the contents, so we abbreviate the contents with a
hash.

So, the hash or object name or object id or whatever you want to call
it isn't even an essential part to git. It is a convenience.

In that sense, I think that '[cryptographic] hash' is the right term,
because the others ("object name" and "object id") seem special. A
hash is not special. In fact, the documentation should read "For
convenience, the git tools refer to objects using the hash value of
their contents". You see? It's not essential.

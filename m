From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sun, 20 Feb 2011 08:16:41 -0500
Message-ID: <AANLkTinO0h+WF-UKM=g=n_Vk43EnGCLtvj=4pCcSzVYh@mail.gmail.com>
References: <20110219101936.GB20577@sigill.intra.peff.net> <20110219102533.GD22508@sigill.intra.peff.net>
 <AANLkTi=s6FxnYVv3UinV4Q+4C_9dX9rCLQQoCFD7kG9S@mail.gmail.com> <20110220100424.GB988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 20 14:17:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr99y-0003WO-FE
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 14:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab1BTNRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 08:17:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab1BTNRD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 08:17:03 -0500
Received: by gyh20 with SMTP id 20so587145gyh.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 05:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=MU3EZiwY5snXXHKeliw/WKGqgPb1jsSZQwMAxoU6ewA=;
        b=xf/9apyuMWMqDvD81BAq1c/AB4H4niJqRqYtg5GEBb+5nBsEOh/v6HgWCaVWEZl1GZ
         eeELnY7ix3U8iQ8Ple/6de+XToujxtjbcBwdIGZyo3mlMkOqO+ugkNaq/h7CRXImJVMj
         7ZjCILuscWuC5N6lQJ7qku0jW3/XG5LMGIFqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hz3GTl5qSY8UE9upHIX9TPb69EaslcBj+nCy3QCLRxnIGyPd9HI71UZybUH+N+eFuF
         POb+D457RX8j0+AcWauP/ddPp3EHZyFMRjlVkjvAtnQ96nO5UkdkBOWQoLnyUam2r2HC
         YoDLa6sPaT+D2jbXczlYEzQK3DQdMqNcFm4Bo=
Received: by 10.91.197.12 with SMTP id z12mr403577agp.113.1298207821124; Sun,
 20 Feb 2011 05:17:01 -0800 (PST)
Received: by 10.90.71.19 with HTTP; Sun, 20 Feb 2011 05:16:41 -0800 (PST)
In-Reply-To: <20110220100424.GB988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167423>

On Sun, Feb 20, 2011 at 5:04 AM, Jeff King <peff@peff.net> wrote:
> Yeah we can if it's useful, but I'd rather see a prototype merge help=
er
> first. In particular, your merge helper seems like it would help in t=
wo
> situations:

Kind of circular -- the helper depends on

 - What unresolved cases do we have?

 - What data can you store from the diff machinery?

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff

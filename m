From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 15:33:38 -0400
Message-ID: <CACPiFCLPgsC+9cX7r33oCQ2AnuRXMTqOAE5RZLS7hXdHc6B-9Q@mail.gmail.com>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net> <20110801182845.GA4303@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 21:34:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnyFZ-0003Hn-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 21:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab1HATeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 15:34:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42479 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab1HATd6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 15:33:58 -0400
Received: by iyb12 with SMTP id 12so7201386iyb.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ve6QIOwGlPJdUfGQ39drgxT75/DYGzftGjB9120zRR8=;
        b=xKBFRqueSw9hJKJkVFvnaMhqXurMdp30oMu6+vgtq4JQ0qvpE2OPruTQTh5j23WD9H
         kIxiQR6Tz+L2jkBKh2oJJgtvFG4lraeeoBbQYY4PtIrbdxHTS74nSpg9OCC5S/86lNu1
         s0bJ1lbYggQuVQJoLTLLPvsLRhXxWKIGD8qjA=
Received: by 10.42.246.138 with SMTP id ly10mr685970icb.440.1312227238096;
 Mon, 01 Aug 2011 12:33:58 -0700 (PDT)
Received: by 10.42.229.129 with HTTP; Mon, 1 Aug 2011 12:33:38 -0700 (PDT)
In-Reply-To: <20110801182845.GA4303@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178402>

On Mon, Aug 1, 2011 at 2:28 PM, martin f krafft <madduck@madduck.net> w=
rote:
> For lack of a better idea (cf. [0]), I am currently toying with the
> following approach:

Hi Martin!

What data are you trying to include? Some time ago, I had similar
ideas to yours for a while... and it ended up being that all I needed
was to put the additional data /in a file/ and commit that file.

Speculation: you mention distro packaging, so I assume you're
improving the Debian packaging integration, with git tracking
debian/rules, perhaps with a wrapper. If you are using a wrapper
program, it is trivial to update this "metadata" file, or to ensure
it's valid/sane, in the preparations to commit, perhaps ensuring that
a pre-commit-hook script is in place and executable.

hth,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff

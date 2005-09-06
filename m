From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 6 Sep 2005 19:53:15 +1200
Message-ID: <46a038f90509060053cdd57e1@mail.gmail.com>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	 <46a038f90509051713389c62c8@mail.gmail.com>
	 <Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 09:55:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECYGf-00037U-B3
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 09:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVIFHxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 03:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbVIFHxT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 03:53:19 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:29823 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964771AbVIFHxS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 03:53:18 -0400
Received: by rproxy.gmail.com with SMTP id i8so795486rne
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 00:53:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ht2d6yUDbRZ1AbCB2jTOjQhqI2OoNOjd10W6tXxtJAZBZwom+vDHjbPFinnmpp9K2us+jfHf/mDKkM8Wt26wy7nGmGH7ZYcRR6M/PB3G6hQpCf+01UiY1/1Re2LC/r7Lg72sw0EjL/fPdU+iZ80dORBpeTv/fIQvMoHRe2sNWJI=
Received: by 10.38.181.74 with SMTP id d74mr1024072rnf;
        Tue, 06 Sep 2005 00:53:15 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Tue, 6 Sep 2005 00:53:15 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8125>

On 9/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
> That wasn't the _point_.

Agreed - sorry I should have qualified my comment.

I agree with having useful extensions for ease of development. And I
agree with the suggestion of installing them with stripped extensions
-- to extend the abstraction.

OTOH...
> The point is, naming things as being "scripts" is useful. Grep is just an
> example. Naming things as being ".pl" or ".sh" is _not_ useful.

Hrmmm. Not so convinced about that. There are good reasons to
distinguish files with different internal syntax. Perhaps it's your
C-bias but for script maintainers it isn't helpful to deal with
-script prefixes.

If a bash script is rewritten in C, it is a useful and meaningful
change (from a developer perspective) that the file changes name. Both
can live in the tree while the new one matures, running diffs or
pickaxes will show one file created and another removed, instead of a
very meaningless diff. The same applies if it is rewritten in Perl, or
Python.

IOW: Perl programmers are developers too ;-)

cheers,


martin

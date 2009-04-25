From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 13:35:38 +0300
Message-ID: <94a0d4530904250335w7a88c4d6lafd12a8ce6f98127@mail.gmail.com>
References: <20090423175717.GA30198@fieldses.org>
	 <20090423201636.GD3056@coredump.intra.peff.net>
	 <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
	 <20090424141139.GC10761@coredump.intra.peff.net>
	 <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
	 <20090424150442.GA11245@coredump.intra.peff.net>
	 <b4087cc50904240818w45bd1cfaq8bbc83e10a6e3781@mail.gmail.com>
	 <20090424173852.GF17365@fieldses.org>
	 <34BD51FF-0908-48A8-BBBC-E27B0EFB32E5@boostpro.com>
	 <20090424185208.GM17365@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>,
	Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 12:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxfG0-0006Qs-IY
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 12:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZDYKfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2009 06:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZDYKfl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 06:35:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:45386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZDYKfk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 06:35:40 -0400
Received: by fg-out-1718.google.com with SMTP id d23so306556fga.17
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+MS0+96WrGxyO68SfZ5LamQSa8iSzOT9dITsyGjwu6E=;
        b=YKDtIsvSx0m6NgkI6rYfkZpmIleXMKwgtB5uWqkT9Oyzq+ZtLZAQOsZZRrfvznoV1B
         A2BYdnpw3EKbpgyaeeredz/rMHCgfWxQSjO744PnbKoMrcTF420WCBCEi2d34qkWuuXK
         JJ4esGQQSnnUScds5dqxP64ohxl6v3u++tQLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V6Dnepv+RHQMiWcS0BeOJNGGNcG7GUMNLi7hmD2R79keTd9Z0zsk8v5jdCj9UbEJ25
         c/r/VQK386HqVYjAwWEeyMAplHPYYXd+qlUsHbxd2I8OBjyadkpqGM2NI2rUg9mk4Nfl
         m35cyIqqDNxXuqCU5LAT14tuQqPl0iCMMj9yI=
Received: by 10.86.33.10 with SMTP id g10mr1545890fgg.21.1240655738594; Sat, 
	25 Apr 2009 03:35:38 -0700 (PDT)
In-Reply-To: <20090424185208.GM17365@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117544>

On Fri, Apr 24, 2009 at 9:52 PM, J. Bruce Fields <bfields@fieldses.org>=
 wrote:
> That would be great, thanks. =C2=A0Several people have gone off and p=
osted
> their own tutorials someplace, and that's fine, but it would be
> especially helpful if you could contribute to the actual Documentatio=
n/
> directory. =C2=A0That may mean arguing with people and making comprom=
ises.
> But it also means the results will be distributed with git, will be
> integrated with other git documentation, and will get first-class
> technical review.
>
> I'd also encourage incrementally improving existing documentation whe=
re
> possible instead of starting over from scratch. =C2=A0But having brok=
en that
> rule myself a couple times I'm hardly in a position to insist. =C2=A0=
If you
> must start over, at least think about how to replace or fit it in wit=
h
> existing documentation.

People will continue to write git documentation from scratch because
there is a huge gap from the top-bottom approach to a point where you
actually "get git", and people are trying to find short-cuts so that
other people can really get it too.

I spent years using git simply repeating the templates I had seen in
multiple places until I stumbled upon "git from the bottom up" and
then I finally understood the beauty and simplicity of git's design.
=46rom that point I understood why many command didn't do what I
expected.

Note that "bottom" doesn't mean plumbing, the "plumbing" is usually
referred to the git.git tools, but you can work with git low-level
objects through your own implementation as people like Scott Chacon
have indeed done (git-ruby). "bottom" then means git basic building
blocks: blobs, trees, commits, refs.

Ideally the UI should expose the basic concepts of git, but instead
its is hiding them, so no wonder people *need* special documentation
to 'understand git conceptually', or learn 'git from the bottom up',
etc.

--=20
=46elipe Contreras

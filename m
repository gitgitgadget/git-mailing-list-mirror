From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 17:58:08 +0300
Message-ID: <CAMP44s1hmG_xMjeB_Wv8pU=aPt=QK27R1OsePeeH5TK9w2GCqg@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
	<20120408124652.GN2289@goldbirke>
	<CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
	<20120408132704.GB4103@burratino>
	<CAMP44s3c2SNSh=TGhYv=JKGu4QJfPB_xoBip5wwLoDh3dLHYNw@mail.gmail.com>
	<20120408143621.GA2631@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 16:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGtZI-00045J-DF
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 16:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab2DHO6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 10:58:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63431 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab2DHO6L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2012 10:58:11 -0400
Received: by eaaq12 with SMTP id q12so944592eaa.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VlRJJzEfUL7KcUy0MHYWfHlfiQNfX+WIHhQzYzxQYkw=;
        b=WpaBds0Y2EAjGcyBQ/Cyi6qkZldJBE8yStXoqdt9KcW8Ao6F75OtY/XxnybLzk317Y
         0N+ID4r+GgMD76P6mAKKWFUdMdVwDFhJP63va7Wk6n4UmnUejDf57vQbGgPM/2YdUbQY
         5FcSoO+x+1Ea7RMGRy8CsULmfUfNjVUevMXozl+z2POcFWhs/2sGyTmWjcLuEHFm1r4X
         UYd5TcKGi9PlZmGhCm1YGK+oF+LO7h1slKIsT31AQm6+HYrVurTlO5r4QbMigX4oEX06
         bV7fn3ewuN0X+GgHUV4mCASIPnEUo7UJlVlUZdYoQk6BoeZ/THwwIwjL+kpXJuarZ9il
         dQ6A==
Received: by 10.213.35.196 with SMTP id q4mr264856ebd.29.1333897088712; Sun,
 08 Apr 2012 07:58:08 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 8 Apr 2012 07:58:08 -0700 (PDT)
In-Reply-To: <20120408143621.GA2631@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195003>

On Sun, Apr 8, 2012 at 5:36 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> (dropping Shawn from cc since I'm not under the impression he works
> =C2=A0on the completion script these days)
> Felipe Contreras wrote:
>
>> Whoa! Breaking their tab completion? Where? Can you show me some evi=
dence?
>
> If you weren't listening before, I'm not sure what I can add now[*].

This is what you said; "in exchange for us breaking their tab
completion". There's a big difference between "breaking", and
"*potentially* breaking". I have never seen any evidence of tab
completion actually being broken.

> Luckily, I already said what I needed to say. =C2=A0Yes, cleanups can=
 be
> good when they don't break things, and no, cleanups that break things
> are not good. =C2=A0Sometimes it is not obvious which category each c=
ase
> falls into. =C2=A0As you well know, "tests pass" is not enough (e.g.,
> sometimes there are no tests!). =C2=A0If you want someone to argue wi=
th,
> you can find someone else.

=46ortunately there's no evidence of anything being broken; all the
issues mentioned are *theoretical*, and there's not even an example of
a custom completion that would be broken by this.

--=20
=46elipe Contreras

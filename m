From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 6 May 2012 23:16:37 +0200
Message-ID: <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 06 23:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8ow-0000oy-Fi
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 23:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab2EFVQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 17:16:39 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46655 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab2EFVQi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 17:16:38 -0400
Received: by eekc41 with SMTP id c41so1248188eek.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=38VmK5/qjvwk3+RCzx4D0V5qn56isAo6mv2ErmHfCbU=;
        b=Wnrbg9M7K/aH2xby+IU33gmtVbBZVYw7Mhwb1fLLLw+xs+GEJUEh8eAOT4MXg/lDcF
         mtlu+L2lvxhQaUIrCgzgKWwmEXrdtjkKf7i4gq09dOcdv00OwRuN4jiZzB2Ee8fZT7t3
         GC92vKqghsW3uDsAVv4xVaRGsqLFB6YUyqR/CfnQZmxAwjn+n4hYAtRTyYMB0h/3xJJL
         O1cYMhdMGn8E00MPYRPML9gbpcsmfpFzUidXWNvFqD8taMyXI+CstMd2jBfpNtKZWYwS
         7DNWiXoQEtSR+p0KWehR+e3lP4rmtImJZu11R+58F2Xz537KOEMj/KaQvZzOGU1xyJOe
         U5bA==
Received: by 10.213.107.193 with SMTP id c1mr2306956ebp.120.1336338997516;
 Sun, 06 May 2012 14:16:37 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 6 May 2012 14:16:37 -0700 (PDT)
In-Reply-To: <vpqehqxmwpj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197215>

On Sun, May 6, 2012 at 12:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> * Currenly, "index" and "staging area" are not exactly synonyms. When
> =C2=A0used with "git add" and "git commit" (without -a), the index is=
 the
> =C2=A0staging area for the next commit. But when used by "git merge",=
 the
> =C2=A0index is more a "merging area".

And what is the difference? The result of the 'merging area' is still a=
 commit.

> About the name, an alternative to "stage" was suggested earlier:
> "precommit". If we were to rewrite Git from scratch, I'd argue in fav=
or
> of this one, which is really easy to understand, especially for
> non-native (you really need to know what a "commit" is to use Git, an=
d
> then infering the meaning of precommit is easy). But we probably have
> already a too long history of changing the name, so introducing yet
> another one is perhaps counter-productive. I don't know.

I don't know, precommit is not an English word, and it was discussed
before, but not many people vouched for it.

Plus, it's not already widely used in the interwebs documentation as
staging area is.

Cheers.

--=20
=46elipe Contreras

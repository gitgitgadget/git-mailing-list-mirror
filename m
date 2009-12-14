From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] Add gitk-git Hungarian translation
Date: Mon, 14 Dec 2009 14:28:16 +1100
Message-ID: <20091214032816.GB24152@drongo>
References: <1258284204-17247-1-git-send-email-djszapi@archlinux.us>
 <19205.2740.244981.703612@cargo.ozlabs.ibm.com>
 <a362e8010911220005u1783cd44yf84ae5bc5b42d980@mail.gmail.com>
 <a362e8010911281833p58058a06sbe305d61709ac051@mail.gmail.com>
 <a362e8010912131030v4c1ef231r7246d7291f6a5677@mail.gmail.com>
 <20091213230305.GA8135@brick.ozlabs.ibm.com>
 <7vskbejmrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Laszlo Papp <djszapi@archlinux.us>,
	Laszlo Papp <djszapi2@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 04:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK1c5-0004wq-3z
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 04:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbZLND2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Dec 2009 22:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZLND2k
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 22:28:40 -0500
Received: from ozlabs.org ([203.10.76.45]:39005 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbZLND2j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 22:28:39 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9962BB7B3E; Mon, 14 Dec 2009 14:28:38 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7vskbejmrw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135166>

On Sun, Dec 13, 2009 at 06:46:11PM -0800, Junio C Hamano wrote:
> Paul Mackerras <paulus@samba.org> writes:
>=20
> > In any case, your patch has problems: I applied it and then ran
> > make to update the message catalogs, and I got these errors:
> >
> > Generating catalog po/hu.msg
> > msgfmt --statistics --tcl po/hu.po -l hu -d po/
> > po/hu.po:41: end-of-line within string
> > po/hu.po:41:4: syntax error
> > po/hu.po:42: end-of-line within string
> > po/hu.po:666: end-of-line within string
> > po/hu.po:666:10: syntax error
> > po/hu.po:667: end-of-line within string
> > msgfmt: found 6 fatal errors
> > make: *** [po/hu.msg] Error 1
> >
> > so I reverted it.
>=20
> Syntactically there seem to be only two line-wrapping caused by MUA o=
n the
> originating side that caused this.  Munging the problematic lines see=
ms to
> fix the above.

It didn't look to me as though it was just MUA line-wrapping, since
there was a '+' at the start of the line following the one that didn't
have a closing quote.  Also, git am didn't complain about it, which it
would have done if it had been MUA line-wrapping.

> Now, I don't read _any_ Hungarian, so it could very well be that my f=
ix-up
> is wrong and there shouldn't be any SP between two words in 'f=E1jlon=
 bel=FCl'
> and 'm=E9g nincsenek'; if we hear from some Hungarian capable readers=
 that the
> fix-up below makes sense, perhaps squashing it in would be the easies=
t way
> to move forward?

I also don't read any Hungarian, which is why I didn't want to try to
fix up problems that were more than just MUA line-wrapping.  As you
say, if a Hungarian speaker can verify that your fix is correct, we
could fix up the original patch.  A clean re-post with a suitable
subject would be nicer, though.

Paul.

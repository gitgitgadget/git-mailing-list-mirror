From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: gitk translation updates needed?
Date: Wed, 3 Feb 2010 21:56:15 +0100
Message-ID: <201002032156.16101.barra_cuda@katamail.com>
References: <20100201151647.GB8916@spearce.org> <201002031113.11212.barra_cuda@katamail.com> <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmFF-0003UN-RI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882Ab0BCUyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 15:54:37 -0500
Received: from smtp187-pc.aruba.it ([62.149.157.187]:33818 "HELO
	smtp2-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932867Ab0BCUyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:54:36 -0500
Received: (qmail 9145 invoked by uid 89); 3 Feb 2010 20:54:28 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2-pc.ad.aruba.it
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RDNS_NONE
	autolearn=ham version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.109.139)
  by smtp2-pc.ad.aruba.it with SMTP; 3 Feb 2010 20:54:28 -0000
User-Agent: KMail/1.11.4 (Linux/2.6.32.7-mike-1mike; KDE/4.2.4; i686; ; )
In-Reply-To: <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138896>

On Wednesday 03 February 2010, Junio C Hamano wrote:
> Michele Ballabio <barra_cuda@katamail.com> writes:
>=20
> > On Wednesday 03 February 2010, Junio C Hamano wrote:
> >> Generating catalog po/it.msg
> >>  msgfmt --statistics --tcl po/it.po -l it -d po/
> >>  282 translated messages, 1 fuzzy translation, 6 untranslated mess=
ages.
> >
> > I don't get any fuzzy translation here, but I used to, so I guess i=
t
> > regards the copyright message. If that's the case, maybe msgfmt
> > mishandles the (C)opyright sign (or maybe gitk uses a weird encodin=
g,
> > I don't know).
>=20
> Sorry, I omitted a step in my report:
>=20
>  $ make po/gitk.pot
>  $ msgmerge -U po/it.po po/gitk.pot ;# and for other languages...
>  $ make po/it.msg

Yes, with these steps it.po now contains:

#: gitk:2782
#, fuzzy
msgid ""
"\n"
"Gitk - a commit viewer for git\n"
"\n"
"Copyright =A99 2005-2009 Paul Mackerras\n"
"\n"
"Use and redistribute under the terms of the GNU General Public License=
"

The "fuzzy" attribute is bogus but is understandable, because
the msgid changed: "=A9" became "=A99". What I don't get is:
why "=A9" became "=A99"? Was it a needed change or just an oversight?

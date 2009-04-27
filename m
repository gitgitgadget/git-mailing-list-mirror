From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Lets avoid the SHA-1 term (was [doc] User Manual Suggestion)
Date: Mon, 27 Apr 2009 02:28:38 +0200
Message-ID: <20090427002838.GF12338@atjola.homenet>
References: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>,
	Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyElR-0005IM-GS
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 02:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZD0A2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 20:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZD0A2y
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 20:28:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:34714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029AbZD0A2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 20:28:53 -0400
Received: (qmail invoked by alias); 27 Apr 2009 00:28:51 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp022) with SMTP; 27 Apr 2009 02:28:51 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18y9+UPPrcyh6+8fx7Fe8wL/c/bMHJc4u6tqcNtmj
	aGqX4y5hD3IBhY
Content-Disposition: inline
In-Reply-To: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117605>

On 2009.04.27 02:38:40 +0300, Felipe Contreras wrote:
> 2009/4/27 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.04.24 20:48:57 -0400, David Abrahams wrote:
> >>
> >> On Apr 24, 2009, at 8:01 PM, Michael Witten wrote:
> >>
> >>>> What's wrong with just calling the object name "object name"?
> >>>
> >>> What's wrong with calling the object address "object address"?
> >>
> >> Neither captures the connection to the object's contents. =A0I thi=
nk
> >> "value ID" would be closer, but it's probably too horrible.
> >
> > I think I asked this in another mail, but I'm quite tired, so just =
to
> > make sure: What do you mean by "value"? I might be weird (I'm not a
> > native speaker, so I probably make funny and wrong connotations fro=
m
> > time to time), but while I can accept "content" to include the type=
 and
> > size of the object, the term "value" makes me want to exclude those
> > pieces of meta data. So "value" somehow feels wrong to me, as the h=
ash
> > covers those two fields.
>=20
> Just to summarize.
>=20
> Do you agree that SHA-1 is not the proper term to choose?

Yes, IMHO that's too strongly tied to the implementation. But a quick
grep run tells me that the "object name" area is probably not where you
need to get rid of that. The "object name" term is already used a lot.
If you want to ban SHA-1 then the rev-parse man page, describing the
"extended SHA1 syntax" would probably be a better place to start (unles=
s
you want to "fix" everything at once).

> Do you agree that either 'id' or 'hash' would work fine?

"object id" would work for me, but I'm fine with the existing "object
name" as well. I don't like "object hash" (or "object hash id"), becaus=
e
it IMHO doesn't express that well that it's used to identify an object.

> Personally I think there's an advantage of choosing 'hash'; if we pic=
k
> 'id' then the user might think that he can change the contents of the
> object while keeping the same id, if we pick 'hash' then it's obvious
> the 'id' is tied to the content and why.

Heh, if you use "hash", there's no "id" tied to the content, there's
just the hash. SCNR ;-) See my other mails why I think that "hash" isn'=
t
that advantageous.

Bj=F6rn

From: Luis Henriques <henrix@camandro.org>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Thu, 4 Dec 2014 19:44:55 +0000
Message-ID: <20141204194455.GB3386@charon.olymp>
References: <20140324213814.GA1267@achilles.my.domain>
 <20141202193243.GA2999@charon.olymp>
 <20141203023419.GA10519@dcvr.yhbt.net>
 <xmqqk328k6ya.fsf@gitster.dls.corp.google.com>
 <20141204192245.GA3386@charon.olymp>
 <xmqqd27ztdkr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwcKs-0008Ka-4R
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049AbaLDTpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 14:45:03 -0500
Received: from haggis.mythic-beasts.com ([93.93.131.56]:52689 "EHLO
	haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933006AbaLDTpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:45:01 -0500
Received: from [2.81.129.121] (port=54825 helo=localhost)
	by haggis.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XwcKf-0000fk-Ov; Thu, 04 Dec 2014 19:44:58 +0000
Content-Disposition: inline
In-Reply-To: <xmqqd27ztdkr.fsf@gitster.dls.corp.google.com>
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260790>

On Thu, Dec 04, 2014 at 11:33:24AM -0800, Junio C Hamano wrote:
> Luis Henriques <henrix@camandro.org> writes:
>=20
> > On Wed, Dec 03, 2014 at 08:56:45AM -0800, Junio C Hamano wrote:
> >
> >> I actually do not think this is a good idea from debuggability.
> >
> > Do you think this could be merged with yet another switch?  I can't
> > think of a name for the switch, something like... "--hide-msgid"?
>=20
> In case it wasn't clear, by "this" I meant the removal of
> "X-Mailer:", iow, "Adding --no-xmailer option is a bad idea from
> debuggability's point of view".
>

Oh, ok.  I thought you were talking about the message-id.

> Not adding message-id is not an option; MSAs are supposed to always
> add one if they want to be RFC compliant, aren't they?

Yes, of course -- having a message ID is a requirement.  But I was
hoping you could accept a solution similar to the one suggested by
Kyle (adding him to Cc): he was suggesting hashing the message ID,
which would be a good compromise, I believe.

Cheers,
--=20
Lu=EDs

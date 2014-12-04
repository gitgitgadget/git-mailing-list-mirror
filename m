From: Luis Henriques <henrix@camandro.org>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Thu, 4 Dec 2014 19:22:45 +0000
Message-ID: <20141204192245.GA3386@charon.olymp>
References: <20140324213814.GA1267@achilles.my.domain>
 <20141202193243.GA2999@charon.olymp>
 <20141203023419.GA10519@dcvr.yhbt.net>
 <xmqqk328k6ya.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbzP-0003zz-DW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbaLDTWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 14:22:55 -0500
Received: from haggis.mythic-beasts.com ([93.93.131.56]:35224 "EHLO
	haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895AbaLDTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:22:55 -0500
Received: from [2.81.129.121] (port=52146 helo=localhost)
	by haggis.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XwbzC-00070W-HV; Thu, 04 Dec 2014 19:22:47 +0000
Content-Disposition: inline
In-Reply-To: <xmqqk328k6ya.fsf@gitster.dls.corp.google.com>
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260784>

On Wed, Dec 03, 2014 at 08:56:45AM -0800, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>=20
> > Luis Henriques <henrix@camandro.org> wrote:
> >> On Mon, Mar 24, 2014 at 09:38:27PM +0000, Luis Henriques wrote:
> >> > Add --[no-]xmailer that allows a user to disable adding the 'X-M=
ailer:'
> >> > header to the email being sent.
> >> >
> >>=20
> >> Ping
> >>=20
> >> It's been a while since I sent this patch.  Is there any interest =
in
> >> having this switch in git-send-email?
> >
> > I wasn't paying attention when the original was sent, but this
> > looks good to me.
> >
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> >
> >> I honestly don't like disclosing too much information about my sys=
tem,
> >> in this case which MUA I'm using and its version.
> >
> > Right on.  I would even favor this being the default.
> >
> > Auto-generated Message-Id headers also shows the use of git-send-em=
ail;
> > perhaps there can be a way to configure that, too.  However,
> > git-send-email respects manually-added Message-Id headers in the
> > original patch, so it's less of a problem, I suppose.
>=20
> I actually do not think this is a good idea from debuggability.

Do you think this could be merged with yet another switch?  I can't
think of a name for the switch, something like... "--hide-msgid"?

Another option would be to re-work the --no-xmailer switch to change
it into a "--hide-id" (or something), where both the "X-Mailer:"
header would be dropped and the Message-id would be obfuscated.

Cheers,
--=20
Lu=EDs

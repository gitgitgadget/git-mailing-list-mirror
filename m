From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/22] git-remote-mediawiki: Use the Readonly module
 instead of the constant pragma
Date: Sat, 8 Jun 2013 13:31:49 -0400
Message-ID: <20130608173149.GC28029@sigill.intra.peff.net>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
 <1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr>
 <20130608032324.GA20226@sigill.intra.peff.net>
 <51B32B0F.1030400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Q8OpbGVzdGlu?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?B?Q8OpbGVzdGlu?= Perdu <tohwiq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:32:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMzg-00038o-B9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab3FHRbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 13:31:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:55506 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab3FHRbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:31:52 -0400
Received: (qmail 12330 invoked by uid 102); 8 Jun 2013 17:32:40 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 12:32:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jun 2013 13:31:49 -0400
Content-Disposition: inline
In-Reply-To: <51B32B0F.1030400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226846>

On Sat, Jun 08, 2013 at 03:01:03PM +0200, C=C3=A9lestin Perdu wrote:

> Oh yes, part of this commit went into the previous one, which was not
> formated as an email when I did my git-format-patch. I should check m=
y
> patches more carefully before sending them. Sorry for this.

No problem. It is easy to make simple mistakes like that with our
workflow, but it is also easy to fix them and repost. :)

> > What advantage does this have over "use constant"? I do not mind
> > following guidelines from perlcritic if they are a matter of style,=
 but
> > in this case there is a cost: we now depend on the "Readonly" modul=
e,
> > which is not part of the standard distribution. I.e., users now hav=
e to
> > deal with installing an extra dependency. Is it worth it?
>=20
> Like Benoit said, the problem is that they sometimes don't interpolat=
e.
> I don't know if we should keep this commit or not.

Thanks both for the explanation.  I don't see us using that to our
advantage anywhere in the patch. So I think this is purely a style
issue, which to me indicates that the extra dependency is not worth it,
and the patch should be dropped.

-Peff

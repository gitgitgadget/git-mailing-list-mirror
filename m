From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 8 Apr 2011 18:43:35 -0400
Message-ID: <20110408224335.GC7343@sigill.intra.peff.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
 <7vmxk033ic.fsf@alter.siamese.dyndns.org>
 <20110408205437.GB16540@sigill.intra.peff.net>
 <7v4o6830cc.fsf@alter.siamese.dyndns.org>
 <20110408213201.GA20348@sigill.intra.peff.net>
 <7vipuo1iuy.fsf@alter.siamese.dyndns.org>
 <20110408224035.GB7343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KP1-00042W-Oq
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab1DHWnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 18:43:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58169
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab1DHWnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:43:39 -0400
Received: (qmail 6493 invoked by uid 107); 8 Apr 2011 22:44:26 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 18:44:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 18:43:35 -0400
Content-Disposition: inline
In-Reply-To: <20110408224035.GB7343@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171172>

On Fri, Apr 08, 2011 at 06:40:36PM -0400, Jeff King wrote:

> +cat >expect <<'EOF'
> +From: =3D?UTF-8?q?"F=3DC3=3DB6o=3D20B.=3D20Bar"?=3D <author@example.=
com>
> +EOF
> +test_expect_success 'rfc2047-encoded headers also double-quote 822 s=
pecials' '
> +	check_author "F=C3=B6o B. Bar"

I'm slightly unsure of this one. Notice that we keep the literal
double-quotes inside the rfc2047 encoded-word. Whereas in Alejandro's
mail sent by Thunderbird, they ended up encoded.

My reading of rfc2047 is that it's OK either way, but I'm not 100% sure=
=2E

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Sat, 12 Jun 2010 00:11:46 -0400
Message-ID: <20100612041146.GB9419@coredump.intra.peff.net>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <7viq5pgma4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>, git@vger.kernel.org,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 06:12:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONI5B-00014u-62
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 06:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878Ab0FLELt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 00:11:49 -0400
Received: from peff.net ([208.65.91.99]:39770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab0FLELt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 00:11:49 -0400
Received: (qmail 16502 invoked by uid 107); 12 Jun 2010 04:12:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Jun 2010 00:12:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jun 2010 00:11:46 -0400
Content-Disposition: inline
In-Reply-To: <7viq5pgma4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148984>

On Fri, Jun 11, 2010 at 04:52:19PM -0700, Junio C Hamano wrote:

> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
> 
> > +	switch (userdiff_config(var, value)) {
> > +		case 0: break;
> > +		case -1: return -1;
> > +		default: return 0;
> > +	}
> 
> Style:
> 
> 	switch (userdiff_config(var, value)) {
> 	case 0:
> 		break;
> 	case -1:
>         	return -1;
> 	default:
>         	return 0;
> 	}

This is cut-and-paste from some of my code in git_diff_basic_config. I
dunno if it is worth style-fixing that one, too.

-Peff

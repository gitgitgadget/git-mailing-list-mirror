From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Improve user-manual html and pdf formatting
Date: Sat, 4 Jan 2014 21:38:48 +0000 (UTC)
Message-ID: <loom.20140104T223713-502@post.gmane.org>
References: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net> <20140104211834.GC12251@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 04 22:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzYw8-0003qq-HP
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 22:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbaADVjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jan 2014 16:39:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:37088 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656AbaADVjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 16:39:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VzYw2-0003ev-6B
	for git@vger.kernel.org; Sat, 04 Jan 2014 22:39:10 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 22:39:10 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 22:39:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239945>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

>=20
> Hi,
>=20
> Thomas Ackermann wrote:
>=20
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> >  <at>  <at>  -1,5 +1,5  <at>  <at>=20
> > -Git User Manual
> > +&#65279;Git User Manual
>=20
> Why?
>=20
> Puzzled,
> Jonathan
>=20

That's a Unicode Byte Order Mark. In UTF-8 it serves no purpose except
to indicate that a file is in fact UTF-8. A job which most editors
don't need help with.

See http://en.wikipedia.org/wiki/Byte_order_mark

=C3=98sse

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH next v2] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 11:56:33 -0500
Message-ID: <20090114165633.GC15758@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E129B.3020502@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tavestbo@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN945-0003gJ-Dk
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761822AbZANQ4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 11:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760793AbZANQ4g
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:56:36 -0500
Received: from peff.net ([208.65.91.99]:60725 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759575AbZANQ4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:56:35 -0500
Received: (qmail 1875 invoked by uid 107); 14 Jan 2009 16:56:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Jan 2009 11:56:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2009 11:56:33 -0500
Content-Disposition: inline
In-Reply-To: <496E129B.3020502@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105659>

On Wed, Jan 14, 2009 at 05:28:11PM +0100, Tor Arne Vestb=C3=B8 wrote:

> +MSG=3D${MSG//%/}
> +printf "$MSG" > "$1"
> +printf "$MSG" >& 2

Substitution parameter expansion is a bash-ism, IIRC. How about just

  printf %s "$MSG" ?

-Peff

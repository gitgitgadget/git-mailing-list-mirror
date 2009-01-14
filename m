From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 11:53:21 -0500
Message-ID: <20090114165321.GB15758@coredump.intra.peff.net>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at> <1231944876-29930-4-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0901141641500.3586@pacific.mpi-cbg.de> <2009-01-14-17-18-40+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	johannes@familieschneider.info
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN90z-0002C5-Ov
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762429AbZANQxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760839AbZANQxY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:53:24 -0500
Received: from peff.net ([208.65.91.99]:60708 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758075AbZANQxX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:53:23 -0500
Received: (qmail 1820 invoked by uid 107); 14 Jan 2009 16:53:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Jan 2009 11:53:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2009 11:53:21 -0500
Content-Disposition: inline
In-Reply-To: <2009-01-14-17-18-40+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105657>

On Wed, Jan 14, 2009 at 05:18:39PM +0100, Samuel Tardieu wrote:

> My taste would favor:
> 
>   static int has_special(const char *p)
>   {
>     for (; *p; p++)
>       if (isspecial(*p))
>         return 1;
>     return 0;
>   }

That was my first thought upon reading the other two, as well. And I
agree with all of the reasoning you gave.

-Peff

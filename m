From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] help: use parseopt
Date: Mon, 25 Feb 2008 01:57:10 -0500
Message-ID: <20080225065710.GA3765@coredump.intra.peff.net>
References: <cover.1203890846.git.peff@peff.net> <20080224221655.GB31309@coredump.intra.peff.net> <200802250750.53047.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 08:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTXO3-0006QQ-3W
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbYBYHDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 02:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbYBYHDy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:03:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3704 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbYBYHDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:03:53 -0500
Received: (qmail 7742 invoked by uid 111); 25 Feb 2008 06:57:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 25 Feb 2008 01:57:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 01:57:10 -0500
Content-Disposition: inline
In-Reply-To: <200802250750.53047.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74996>

On Mon, Feb 25, 2008 at 07:50:52AM +0100, Christian Couder wrote:

> > Sorry, the diff turned out quite messy because of the cleanups. It's
> > probably easier to just read the result.
> 
> Or could you send the cleanups in some separated patches ?

Looking at it again, it's actually not too bad except for the cmd_help()
function itself, which isn't due to the cleanups at all, but because the
flow changes quite a bit. So I don't think splitting it actually will
make the diff any friendlier.

-Peff

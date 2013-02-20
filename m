From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2013, #08; Tue, 19)
Date: Wed, 20 Feb 2013 03:50:40 -0500
Message-ID: <20130220085040.GA31996@sigill.intra.peff.net>
References: <7v621nzaxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 09:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U85OO-0003Qo-F9
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 09:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050Ab3BTIun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 03:50:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53581 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042Ab3BTIun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 03:50:43 -0500
Received: (qmail 8154 invoked by uid 107); 20 Feb 2013 08:52:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 03:52:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 03:50:40 -0500
Content-Disposition: inline
In-Reply-To: <7v621nzaxb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216695>

On Tue, Feb 19, 2013 at 11:44:48PM -0800, Junio C Hamano wrote:

> * jk/smart-http-robustify (2013-02-17) 3 commits
>  - remote-curl: sanity check ref advertisement from server
>  - remote-curl: verify smart-http metadata lines
>  - pkt-line: teach packet_get_line a no-op mode
> 
>  Parse the HTTP exchange that implements the native Git protocol as
>  a series of stateless RPC more carefully to diagnose protocol
>  breakage better.
> 
>  Will merge to and hold in 'next'.

I just posted elsewhere, but to make sure I get your attention: please
hold off on this. The sanity check in the top patch is not right
(because of the ERR/flush thing that Jonathan brought up). I'll have an
updated series tomorrow.

-Peff

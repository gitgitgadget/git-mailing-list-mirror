From: Jeff King <peff@peff.net>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Mon, 18 Mar 2013 12:49:50 -0400
Message-ID: <20130318164950.GA14844@sigill.intra.peff.net>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
 <20130318073229.GA5551@sigill.intra.peff.net>
 <7vtxo8ody3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 17:50:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHdGP-0007sw-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 17:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab3CRQty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 12:49:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56249 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab3CRQty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 12:49:54 -0400
Received: (qmail 19252 invoked by uid 107); 18 Mar 2013 16:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 12:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 12:49:50 -0400
Content-Disposition: inline
In-Reply-To: <7vtxo8ody3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218428>

On Mon, Mar 18, 2013 at 09:44:20AM -0700, Junio C Hamano wrote:

> FWIW, I am getting something like this on my
> 
> $ grep 'model name' /proc/cpuinfo | uniq -c
>   4 model name      : Intel(R) Core(TM)2 Quad  CPU   Q9450  @ 2.66GHz
> 
> The same "rev-list --objects --all >/dev/null", best of five:
> 
> [current master, compiled with -O2]
> real    0m39.956s
> user    0m39.562s
> sys     0m0.396s
> 
> [revert 1a812f3 (i.e., go back to memcmp), -O2]
> real    0m42.161s
> user    0m41.879s
> sys     0m0.284s
> 
> It could be that the difference may be how well memcmp() is
> optimized, no?  My box runs Debian with libc6 2.11.3-4 and gcc
> 4.4.5.

Yeah, that would make sense. I have libc6 2.13-38 and gcc 4.7.2 (debian
unstable).

-Peff

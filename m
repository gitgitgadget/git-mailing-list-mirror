From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 24 Nov 2007 06:38:15 -0500
Message-ID: <20071124113814.GA17861@sigill.intra.peff.net>
References: <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 24 12:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvtLI-0006CP-Mu
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 12:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXKXLiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 06:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbXKXLiT
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 06:38:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2909 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbXKXLiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 06:38:18 -0500
Received: (qmail 7930 invoked by uid 111); 24 Nov 2007 11:38:16 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 24 Nov 2007 06:38:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Nov 2007 06:38:15 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711231319220.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65944>

On Fri, Nov 23, 2007 at 01:23:44PM +0000, Johannes Schindelin wrote:

> Maybe we could change the (non-fast forward) message into (non-fast 
> forward; need to pull?).

Not unreasonable, although I think our line length is getting a bit
long.  Rejected refs would look something like (actually they say
"[rejected]" but the text is column-aligned with the X's):

 ! XXXXXXX...XXXXXXX ref_name -> ref_name (non-fast forward; need to pull?)

There's 58 characters of text not including the two ref_names, leaving
about 11 characters for each ref name. The name of this topic,
jk/send-pack, would overflow an 80-character terminal:

 ! [rejected]        jk/send-pack -> jk/send-pack (non-fast forward; need to pull?)

-Peff

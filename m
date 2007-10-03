From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: size_t vs "unsigned long"
Date: Wed, 03 Oct 2007 23:36:03 +0200
Message-ID: <877im3khj0.fsf@mid.deneb.enyo.de>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org>
	<20071003204801.GC28188@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBtK-0003rz-W3
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXJCVgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbXJCVgO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:36:14 -0400
Received: from mail.enyo.de ([212.9.189.167]:3811 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbXJCVgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:36:13 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IdBt0-0001q4-QI; Wed, 03 Oct 2007 23:36:06 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IdBsx-0007Ns-Pu; Wed, 03 Oct 2007 23:36:03 +0200
In-Reply-To: <20071003204801.GC28188@artemis.corp> (Pierre Habouzit's message
	of "Wed, 03 Oct 2007 22:48:01 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59890>

* Pierre Habouzit:

>   Well, afaict, on every linux archs I know of, unsigned longs and
> size_t are the same.

IIRC, 64-bit Windows uses 64-bit points (duh) and hence a 64-bit
size_t, but still has got 32-bit longs.  Documentation is a bit sparse
on this matter (because you are supposed to use LONG, DWORD and
friends anyway).

From: Geert Bosch <bosch@adacore.com>
Subject: Re: dangling commits and blobs: is this normal?
Date: Thu, 23 Apr 2009 14:10:56 -0400
Message-ID: <0F4B0DFB-A0A3-45FA-9BB7-801FFD2E8862@adacore.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221548310.6741@xanadu.home> <20090422200502.GA14304@coredump.intra.peff.net> <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com> <20090423175612.GV23604@spearce.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:13:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3PY-0000TE-DN
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886AbZDWSLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756372AbZDWSK7
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:10:59 -0400
Received: from rock.gnat.com ([205.232.38.15]:57059 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbZDWSK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:10:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id DF8B82BAAF4;
	Thu, 23 Apr 2009 14:10:57 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3Fq7HnD3VOci; Thu, 23 Apr 2009 14:10:57 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 77A1F2BAAC9;
	Thu, 23 Apr 2009 14:10:57 -0400 (EDT)
In-Reply-To: <20090423175612.GV23604@spearce.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117354>


On Apr 23, 2009, at 13:56, Shawn O. Pearce wrote:

> If your favorite import tool (*cough* git-svn *cough*) can't use
> fast-import, and you are importing a large enough repository that
> this matters to you, use another importer that can use fast-import.

How did you guess? :) You're right of course, except that I can't
use fast-import AFAIK. The issue is also more general, as the
same scenario of adding new objects and repacking occurs
outside the context of git-svn.

   -Geert

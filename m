From: Jeff King <peff@peff.net>
Subject: Re: Possibly solved invalid free() in git-remote-http from Git
 1.7.2.1
Date: Mon, 1 Aug 2011 21:33:44 -0600
Message-ID: <20110802033344.GA17494@sigill.intra.peff.net>
References: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
 <CACBZZX5s8+O8X2mpexudGEsaQRm+tr0CQvqTZjZ700DN297__w@mail.gmail.com>
 <CACBZZX5N0DaSrU6rxW=PTMQ8b6c_sxMFJQHMaZy1L138eFFo6w@mail.gmail.com>
 <20110801180018.GA10636@sigill.intra.peff.net>
 <20110802105124.000021c3@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 05:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo5kv-0002WY-ML
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 05:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab1HBDdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 23:33:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47884
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab1HBDds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 23:33:48 -0400
Received: (qmail 25660 invoked by uid 107); 2 Aug 2011 03:34:20 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 23:34:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 21:33:44 -0600
Content-Disposition: inline
In-Reply-To: <20110802105124.000021c3@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178436>

On Tue, Aug 02, 2011 at 10:51:24AM +0800, Tay Ray Chuan wrote:

> On Mon, 1 Aug 2011 12:00:19 -0600
> Jeff King <peff@peff.net> wrote:
> > Hmm. The memory management in the function seems weird to me.
> 
> How about this?

Yes, that fixes all of the oddities I found (I assume you looked and
agreed with me that they were wrong).

-Peff

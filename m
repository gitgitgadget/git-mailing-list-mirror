From: Jeff King <peff@peff.net>
Subject: Re: implement idea firstly in script language?
Date: Thu, 31 Mar 2011 14:51:30 -0400
Message-ID: <20110331185130.GB16981@sigill.intra.peff.net>
References: <AANLkTikq7iJt97Fq-TQH63RCrrvOJb348yhYDYW4qJL6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5My2-0005WH-SV
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100Ab1CaSvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 14:51:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53854
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759091Ab1CaSvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:51:32 -0400
Received: (qmail 1579 invoked by uid 107); 31 Mar 2011 18:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:52:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:51:30 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikq7iJt97Fq-TQH63RCrrvOJb348yhYDYW4qJL6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170517>

On Thu, Mar 31, 2011 at 08:27:38PM +0800, =E5=BE=90=E8=BF=AA wrote:

> i'm wondering to implement one idea during SOC, should i take time to
> implement it firstly in script language(just to see whether it works
> well)? And then rewrite it in C later?

It depends on what the idea is.

The reason to implement something in a higher-level language first is t=
o
verify that the approach is sensible. So you are making a tradeoff: you
put less time/effort into the prototype (which has a high chance of
failure), and pay for it later by having to port a successful result
into its final form.

So knowing whether it's worth it depends on:

  1. How much time is saved by prototyping in a different language?

  2. What is the probability of the approach failing?

  3. What is the cost (in time) of porting the end result?

Estimating any of those is very specific to the problem at hand. It may
even be for some ideas that the ultimate implementation could stay in
the scripting language, which would make point (3) free.

-Peff

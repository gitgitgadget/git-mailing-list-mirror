From: Jeff King <peff@peff.net>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 04:54:32 -0500
Message-ID: <20120202095432.GA19356@sigill.intra.peff.net>
References: <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org>
 <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org>
 <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
 <20120202023857.GA11745@sigill.intra.peff.net>
 <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RstNO-0001Dy-Qs
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab2BBJyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 04:54:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53224
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab2BBJyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 04:54:39 -0500
Received: (qmail 18856 invoked by uid 107); 2 Feb 2012 10:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 05:01:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 04:54:32 -0500
Content-Disposition: inline
In-Reply-To: <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189611>

On Thu, Feb 02, 2012 at 10:44:05AM +0100, demerphq wrote:

> The general design of git seems to me to be based around providing
> building blocks that people can use to build new and interesting tools
> on top of, and so it seems counter to that philosophy to reject an
> feature based on speculative security issues that really can't be
> decided in advance but must instead be decided on a case by case
> basis.

I can't speak for Junio, but I am certainly not rejecting it. Only
saying that it needs to be thought through, and the utility weighed
against the costs. So far I haven't seen an actual patch to comment on
(or even a proposed syntax beyond starting a string with "!", which I
think is a non-starter due to conflicting with existing uses), nor have
I seen a concrete use case (you mentioned pulling the name/email from
ldap, but you also mentioned that there are lots of other ways of
solving that particular problem, so it's not especially compelling).

I'd be happy to hear a more concrete proposal.

-Peff

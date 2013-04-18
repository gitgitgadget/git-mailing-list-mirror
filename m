From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 17:44:27 -0400
Message-ID: <20130418214427.GA10119@sigill.intra.peff.net>
References: <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
 <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
 <20130417201056.GA2914@sigill.intra.peff.net>
 <7va9owd3d1.fsf@alter.siamese.dyndns.org>
 <20130418172714.GA24690@sigill.intra.peff.net>
 <7vd2tr6833.fsf@alter.siamese.dyndns.org>
 <20130418180017.GA5714@sigill.intra.peff.net>
 <7v61zj66wu.fsf@alter.siamese.dyndns.org>
 <20130418203035.GB24690@sigill.intra.peff.net>
 <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 23:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USwd9-0005sh-VF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 23:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936380Ab3DRVob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 17:44:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:43548 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936039Ab3DRVob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 17:44:31 -0400
Received: (qmail 19020 invoked by uid 102); 18 Apr 2013 21:44:35 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 16:44:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2013 17:44:27 -0400
Content-Disposition: inline
In-Reply-To: <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221696>

On Thu, Apr 18, 2013 at 02:37:53PM -0700, Junio C Hamano wrote:

> Because this is to help people who are _used_ to seeing "git add"
> not take the removals into account, I doubt that "Did I want those
> updated or not?  Let me see the details of them." will be the
> question they will be asking [*1*].
> 
> I dunno.
> 
> 
> [Footnote]
> 
> *1* "I know I didn't want to include these removals to the index,
> but I learned today that in later Git I should make myself more
> clear if I want to keep doing so; thanks for letting me know.", or
> "I've long been assuming that I have to say 'git add' and 'git rm'
> separately, but I learned today that I can say 'add --all', and in
> later Git I do not even have to; thanks for letting me know." are
> the two reactions I expected.

I am expecting a reaction more like "Hmm, I never thought about it
before. Does that make sense to me or not? Let me think about which
paths it pertains to and decide".

Which I admit is no more likely than the scenarios you outlined, but it
is close to what I thought the first time I saw the warning.

-Peff

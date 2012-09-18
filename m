From: Jeff King <peff@peff.net>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Tue, 18 Sep 2012 16:16:09 -0400
Message-ID: <20120918201609.GA27240@sigill.intra.peff.net>
References: <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
 <20120918001522.GA10283@sigill.intra.peff.net>
 <7v7grsqi98.fsf@alter.siamese.dyndns.org>
 <20120918185530.GB20498@sigill.intra.peff.net>
 <7vsjafm9hd.fsf@alter.siamese.dyndns.org>
 <20120918191653.GA21187@sigill.intra.peff.net>
 <7vboh3m7tz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4DV-0006u8-S3
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab2IRUQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:16:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47517 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab2IRUQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:16:11 -0400
Received: (qmail 24656 invoked by uid 107); 18 Sep 2012 20:16:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Sep 2012 16:16:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2012 16:16:09 -0400
Content-Disposition: inline
In-Reply-To: <7vboh3m7tz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205864>

On Tue, Sep 18, 2012 at 12:47:36PM -0700, Junio C Hamano wrote:

> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > But even without that, I still think format-patch is a reasonable time
> >> > to do it. It is the time when I proof-read my commit message and patch
> >> > in its final form, and think "do I really want to send this?".
> >> 
> >> But it is not like "I cannot sign off because I think it is still
> >> iffy".
> >
> > No, that is not the particular reason in my case, but I think I
> > explained other reasons why "format-patch -s" is not a wrong workflow.
> 
> Then I didn't read it.  What does "do I really want to send this?"
> have anything to do with DCO in any case?

Because it is an excellent time to think about "am I willing and able to
agree to the DCO?" As I said, for me personally working on git.git, that
is not generally an issue. But I think it is perfectly reasonable for
somebody to work and commit in isolation, and then only decide on the
DCO during the sending phase (perhaps because they need to clear it with
their company's legal department or some such). In other words, "it is
iffy at the time of commit" might be exactly the reason for some people.

If you are responding to my "that is not the particular reason in my
case", I will paraphrase the reason I gave earlier: I find it annoying
and pointless to type "-s" on every commit. We do not have
commit.signoff, but we do have format.signoff.

-Peff

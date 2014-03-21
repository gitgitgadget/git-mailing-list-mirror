From: Jeff King <peff@peff.net>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 14:15:32 -0400
Message-ID: <20140321181532.GC15508@sigill.intra.peff.net>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
 <CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
 <CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
 <20140320233816.GC7774@sigill.intra.peff.net>
 <CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
 <20140321034334.GA29683@sigill.intra.peff.net>
 <CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
 <xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Angelico <rosuav@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3yo-0004Rq-L0
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbaCUSPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:15:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:44219 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750785AbaCUSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:15:34 -0400
Received: (qmail 24903 invoked by uid 102); 21 Mar 2014 18:15:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Mar 2014 13:15:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2014 14:15:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244716>

On Fri, Mar 21, 2014 at 10:31:59AM -0700, Junio C Hamano wrote:

> -- >8 --
> From: Chris Angelico <rosuav@gmail.com>
> Date: Fri, 21 Mar 2014 15:07:08 +1100
> Subject: [PATCH] config.txt: third-party tools may and do use their own variables
> [...]
> +Other git-related tools may and do use their own variables.  When
> +inventing new variables for use in your own tool, make sure their
> +names do not conflict with what are used by Git itself and other
> +popular tools, and describe them in your documentation.

I think this third line should be "with what _is_ used" to match the
verb and noun pluralness[1]. Or to keep better parallel structure with
the first clause, something like "...their names do not conflict with
those that are used by Git...".

-Peff

[1] Is there a word to mean the "pluralness" of a noun or verb (similar
    to "tense" for a verb). Surely there is, but I could not think of
    it. I wanted to say here that the pluralness of "what" and "are"
    does not match (it seems like "what" is a mass noun, which usually
    matches a singular verb).

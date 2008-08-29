From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile, commit.template
Date: Fri, 29 Aug 2008 12:01:33 -0700
Message-ID: <quack.20080829T1201.lthsksnir1u@roar.cs.berkeley.edu>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
	<20080824220854.GA27299@coredump.intra.peff.net>
	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	<20080824231343.GC27619@coredump.intra.peff.net>
	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
	<quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
	<20080827002506.GB7347@coredump.intra.peff.net>
	<quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
	<7vy72jrr00.fsf@gitster.siamese.dyndns.org>
	<quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
	<20080829032630.GA7024@coredump.intra.peff.net>
	<7vod3ca2ey.fsf@gitster.siamese.dyndns.org>
	<quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
	<7vsksn4xdo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ9Ey-0003se-QP
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbYH2TBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 15:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbYH2TBe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 15:01:34 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:43298 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712AbYH2TBd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 15:01:33 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 2D3B634588; Fri, 29 Aug 2008 12:01:33 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vsksn4xdo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 29 Aug 2008 09\:08\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94315>

>>>>> On 2008-08-29 09:08 PDT, Junio C Hamano writes:

    Junio> I do not see any strong reason why the single caller of
    Junio> user_path() has to keep using the static allocation.
    Junio> Would it help to reduce the complexity of your
    Junio> expand_user_path() implementation, if we fixed the
    Junio> caller along the lines of this patch (untested, but
    Junio> just to illustrate the point)?

Yes, expand_user_path() would be much simpler, it would basically
be me original implementation except for returning NULL on error.

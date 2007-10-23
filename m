From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 18:29:59 -0700
Message-ID: <7vtzoi8voo.fsf@gitster.siamese.dyndns.org>
References: <20071016060456.GC13801@spearce.org>
	<Pine.LNX.4.64.0710161209480.25221@racer.site>
	<20071016195744.GB32132@closure.lan>
	<7v3aw2aaxu.fsf@gitster.siamese.dyndns.org>
	<20071023012140.GC22997@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 03:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik8b8-00063T-TG
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 03:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbXJWBaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 21:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXJWBaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 21:30:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:56267 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbXJWBaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 21:30:07 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 536F214E40E;
	Mon, 22 Oct 2007 21:30:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FAE114E410;
	Mon, 22 Oct 2007 21:30:23 -0400 (EDT)
In-Reply-To: <20071023012140.GC22997@thunk.org> (Theodore Tso's message of
	"Mon, 22 Oct 2007 21:21:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62068>

Theodore Tso <tytso@mit.edu> writes:

> I assume PU is what you used to build your proposed-update branch?
> I'm actually trying to use it, and it is useful, although it hasn't
> been working for me completely perfectly.  I've still been trying to
> figure out if the reason why it hasn't been working quite right is due
> to my not understanding how to use it correctly, or whether you don't
> use it these days.

Ah, these days I almost always do:

	git checkout pu
	git reset --hard next

and then merge the topics that haven't been merged anywhere by
hand, using output from

        Meta/git-topic.perl

as the guide.

> One question which I have had about the WC script is that if I
> manually add a commit to the next branch, it ends up showing up in all
> of the topic branches as a commit that was part of that topic branch
> which is in next...

Well, the policy is never to commit directly on top of next
(iow, only merge other topics and nothing else).  Otherwise it
becomes hard to allow individual topics graduate to 'master'
independently.

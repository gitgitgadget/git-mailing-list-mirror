From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Wed, 12 Dec 2007 11:50:17 -0800
Message-ID: <7vodcv7kw6.fsf@gitster.siamese.dyndns.org>
References: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
	<20071212184022.GB28377@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Xcg-0006B9-1o
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761155AbXLLTuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761148AbXLLTun
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:50:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761129AbXLLTum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:50:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1F35EA3;
	Wed, 12 Dec 2007 14:50:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B42C95EA0;
	Wed, 12 Dec 2007 14:50:25 -0500 (EST)
In-Reply-To: <20071212184022.GB28377@untitled> (Eric Wong's message of "Wed,
	12 Dec 2007 10:40:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68095>

Eric Wong <normalperson@yhbt.net> writes:

> David:
>
> I also noticed some race-conditions on this test when running this on my
> Centrino laptop (my fastest box, but I rarely use it for git
> development) and having git on my USB thumb drive.  I'm pretty sure
> these were caused by inconsistencies in handling timestamps on symlinks
> vs timestamps on the files they link to.

I actually saw that for the first time on my primary box during the
nightly rebuild last night.  I'll disable the test for now --- if we can
spot and fix the race by the release, that's good, otherwise, shipping
the test disabled is also fine, too.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sat, 05 Jan 2008 19:06:31 -0800
Message-ID: <7vy7b364aw.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<449c10960801051321g785e45e3v8f7b129bb087e1ca@mail.gmail.com>
	<7v4pdr7jco.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Tsugikazu Shibata" <tshibata@ab.jp.nec.com>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Jeff King" <peff@peff.net>, "Dmitry Potapov" <dpotapov@gmail.com>
To: "Dan McGee" <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 04:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLr7-0002O4-09
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 04:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYAFDGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 22:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYAFDGt
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 22:06:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbYAFDGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 22:06:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D12676180;
	Sat,  5 Jan 2008 22:06:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 38EB8603F;
	Sat,  5 Jan 2008 22:06:38 -0500 (EST)
In-Reply-To: <7v4pdr7jco.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 05 Jan 2008 18:56:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69707>

Junio C Hamano <gitster@pobox.com> writes:

>> I've updated the patch a bit as I noticed I completely missed the
>> user-manual.txt and a handful of other files that weren't named
>> git-*.txt. The new version is attached (gzipped).
>
> The asciidoc.conf change I resurrected from the earlier one but
> it appears this breaks build with asciidoc 7.1.2 for some reason
> (I haven't looked into that myself yet, and I won't be for the
> next 12 hours or so).

Ah, I spoke too fast.  I think I need to first do a clean-up
patch to fix "gitlink::foobar[1]" that should have been spelled
as "gitlink:foobar[1]" in a few places, and your change is good.

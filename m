From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 01:36:55 -0800
Message-ID: <7v8x2nh3uw.fsf@gitster.siamese.dyndns.org>
References: <20080118032222.GX24004@spearce.org>
	<20080118035700.GA3458@spearce.org>
	<20080118092652.GA22052@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 10:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFnfP-0006i5-7e
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 10:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbYARJhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 04:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYARJhH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 04:37:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbYARJhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 04:37:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A0A895AC4;
	Fri, 18 Jan 2008 04:37:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0960C597F;
	Fri, 18 Jan 2008 04:36:56 -0500 (EST)
In-Reply-To: <20080118092652.GA22052@hashpling.org> (Charles Bailey's message
	of "Fri, 18 Jan 2008 09:26:52 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70982>

Charles Bailey <charles@hashpling.org> writes:

> I can ACK this as fixing the test suite failures on Mac OS X 10.4.11
> both with and without NO_MMAP=Yes on top of 1.5.4.rc3.24.gb53139 and
> also on my oldish Fedora install with NO_MMAP=Yes.
>
> Acked-by: Charles Bailey <charles@hashpling.org>

Well, I do not want to be picky with these things, but you do
not own that area, so that would be "Tested-by:"

I've already committed the simplified version I suggested to
Shawn.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add more checkout tests
Date: Sun, 09 Dec 2007 21:14:03 -0800
Message-ID: <7vlk83m8ro.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712092204200.5349@iabervon.org>
	<7vprxfmczi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712092244570.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 06:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ayU-0005sS-9d
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 06:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbXLJFOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 00:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbXLJFOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 00:14:16 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:62524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbXLJFOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 00:14:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 950753FC2;
	Mon, 10 Dec 2007 00:14:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19AF03FC0;
	Mon, 10 Dec 2007 00:14:05 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712092244570.5349@iabervon.org> (Daniel
	Barkalow's message of "Sun, 9 Dec 2007 23:03:28 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67679>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Of course, a patch to clean up the user experience could have a hunk that 
> makes the test expect that the UI is cleaned up. It's not like we can't 
> change our tests to accompany improvements in behavior, and I'd argue that 
> those hunks give a useful example of the improvement.

Ok.

> The point of adding these tests (and parts of tests) is that I'd forgotten 
> to maintain some of the important information while writing 
> builtin-checkout, and there wasn't a test that it was provided. While some 
> of the output is arbitrary informative text, there's a certain amount of 
> generated information there that shouldn't get lost or be incorrect.

Fair enough.

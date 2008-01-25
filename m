From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Fri, 25 Jan 2008 15:57:50 -0800
Message-ID: <7v1w855ugx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0801251824010.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 00:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIYRW-0007HZ-4l
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 00:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbYAYX6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 18:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbYAYX6L
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 18:58:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYAYX6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 18:58:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B4D02112C;
	Fri, 25 Jan 2008 18:58:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 54C88112B;
	Fri, 25 Jan 2008 18:58:02 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801251824010.13593@iabervon.org> (Daniel
	Barkalow's message of "Fri, 25 Jan 2008 18:25:07 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71757>

Daniel Barkalow <barkalow@iabervon.org> writes:

> If the test failed, it was giving really unclear ed script
> output. Instead, give a diff that sort of suggests the problem.

Hmm.  I'd actually prefer using "diff -u" instead.

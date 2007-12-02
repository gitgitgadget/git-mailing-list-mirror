From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 02 Dec 2007 13:47:20 -0800
Message-ID: <7v1wa4vkev.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
	<7vir3hx70y.fsf@gitster.siamese.dyndns.org>
	<20071202193918.GQ6212@lavos.net>
	<7vmyssvn55.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0712021322580.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iywfd-0008HI-6Y
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbXLBVr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXLBVr1
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:47:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36933 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXLBVr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 16:47:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3BF582F0;
	Sun,  2 Dec 2007 16:47:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B1CFE9C35E;
	Sun,  2 Dec 2007 16:47:43 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712021322580.8458@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 2 Dec 2007 13:25:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66822>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 2 Dec 2007, Junio C Hamano wrote:
>>
>> The next issue would be to find who could pass an empty GIT_AUTHOR_DATE
>> without noticing...
>
> In the meantime, here's a not-very-well-tested patch to fsck to at least 
> notice this.

Thanks.

I recall that the very initial git did not use the current format for
timestamp but ctime() return value, and this will also notice them (and
convert-objects will be there for us).

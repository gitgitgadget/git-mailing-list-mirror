From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.5.3.5 will be out tomorrow
Date: Tue, 30 Oct 2007 17:28:06 -0700
Message-ID: <7vzly0i0vd.fsf@gitster.siamese.dyndns.org>
References: <7vfxzsjgos.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0710301712240.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In1Ra-0005p8-3P
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbXJaA2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbXJaA2N
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:28:13 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:48768 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbXJaA2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:28:12 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 064FE2F2;
	Tue, 30 Oct 2007 20:28:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 905379082D;
	Tue, 30 Oct 2007 20:28:30 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710301712240.30120@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 30 Oct 2007 17:16:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62770>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 30 Oct 2007, Junio C Hamano wrote:
>>
>> A fix for a segfaulting bug warrants a new maintenance release,
>> so 1.5.3.5 will be out tomorrow.
>
> Is the 
>
> 	"Make merge-recursive honor diff.renamelimit"
>
> commit in the maintenance series?
>
> If not, I'd suggest merging it.
>
> The lack of this fix bit us during the kernel x86 merge, where there was 
> no way for people using stable git versions to make their merges take 
> renames into account, because there were too many of them..

Ah, and that is especially painful now the rename limit is quite
low thanks to 0024a54923a12f8c05ce4290f5ebefab0cce4336 (Fix the
rename detection limit checking)?

Will cherry-pick that one -- thanks.

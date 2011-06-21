From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 13:19:28 -0700
Message-ID: <7vaadb6ipb.fsf@alter.siamese.dyndns.org>
References: <20110621022049.GA1632@gnu.kitenet.net>
 <7v4o3j9izr.fsf@alter.siamese.dyndns.org>
 <20110621184101.GA12108@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 22:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ7QJ-00037B-E9
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab1FUUTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 16:19:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab1FUUTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 16:19:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 527DE4F64;
	Tue, 21 Jun 2011 16:21:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AZlh9X2azvw7aPYjWSfn4h33Swc=; b=lJx65i
	icC5CZszDRoDoauTgI3aFvlP7NWqjq0P/XktO5x5T9g29KlICWLUXyXqhDOp0lz5
	R526Jv/AwyO5czoUjMlOjUPKyv/9vc/HGqKY0GM9aj7nsB2W+/bWDL+T1T5b+61K
	rzh+csthrGXB9Xeue+mIrBHtz4XulFZB0AOKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVPRLfC1nF1CGrt/D5UNkAyPRnjXmi18
	Jb8i/6ziSJefMT6W7NhoIguPnNWNndC+MmFn47tdG8Ud6w5UDE7c0gG1v+rDN9d2
	906cgZY44TETM+7W74ZneWCyR4/VoTVKc2+MgOHybZkH6IzutK2BZhnE7F08G/JV
	ud+xhMG0RU4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C5F84F62;
	Tue, 21 Jun 2011 16:21:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A930B4F61; Tue, 21 Jun 2011
 16:21:41 -0400 (EDT)
In-Reply-To: <20110621184101.GA12108@gnu.kitenet.net> (Joey Hess's message of
 "Tue, 21 Jun 2011 14:41:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1352C850-9C44-11E0-BBD1-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176197>

Joey Hess <joey@kitenet.net> writes:

> Junio C Hamano wrote:
>> In other words, I would prefer to see something like:
>> 
>> 	$ git merge --index-only [-s <strategy>] <other_branch>
>
> Would this allow merging changes into a branch other than HEAD? If so, I
> agree, I'd prefer to see it in git-merge itself if possible.

I just said "I would prefer to see", so allowing or not allowing is up to
you ;-).  If course I would prefer to see it not touch HEAD so that your
working envirnoment (checked out branch and the working tree) are not
disrupted.  See my other message in the thread.

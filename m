From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Tue, 22 Nov 2011 11:41:22 -0800
Message-ID: <7vd3ckdjx9.fsf@alter.siamese.dyndns.org>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 20:41:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSwDy-0001HX-J4
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 20:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1KVTlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 14:41:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab1KVTlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 14:41:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D2B6E2F;
	Tue, 22 Nov 2011 14:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rFR9InW85fzBnNwMLlvHlLxDwSs=; b=nb3Z4E
	wPaxSyZnM3cYszuBkZf5yiHdHnEGvi4hiARHY/eN+OV7cqFk3R75H/D25Mh1a9FE
	ADLPfII5DQVPvmXg6gLuHm9kBG1Mm1SONUfuVrqDjpOsQDVQ99e20AeFUNV6sIWs
	nTDjWUH4eFqL5t0kQhLTfe28qZPzqTMgvqSaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sxtKwUZwNy4BpBLUh6VmwuQqlYLUhOWD
	5QVLZxUzzA7OS/X8c0dkCKeZlotRy0B1/ZfsaDSgO9/U1CxHmhr1JOuhFS8g52cH
	P9VEZvW2Wyp7jQ9jZeS63JgJ+3NCCsdPGsviXVIncH+vtkeDKxKhqcQLGEeS6YQ8
	L2rPiJ8od1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F30496E2E;
	Tue, 22 Nov 2011 14:41:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C6796E2D; Tue, 22 Nov 2011
 14:41:23 -0500 (EST)
In-Reply-To: <1321970646.3289.19.camel@mastroc3.mobc3.local> (Daniele
 Segato's message of "Tue, 22 Nov 2011 15:04:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5A119D4-1541-11E1-8572-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185807>

Daniele Segato <daniele.bilug@gmail.com> writes:

> [1] according to http://git-scm.com/ the link on "Git source repository"
> is https://github.com/gitster/git

That one is as official as anybody's "git clone" from many of the
distribution points.

I do not see any reason to name an official repository, but if I were
pressed, that copy at github is not the one I would nominate.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 000/144] Use the $( ... ) construct for command substitution instead of using the back-quotes
Date: Tue, 25 Mar 2014 09:20:58 -0700
Message-ID: <xmqq61n2ntat.fsf@gitster.dls.corp.google.com>
References: <1395680321-32427-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 17:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSU6A-0001ul-V4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 17:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbaCYQVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 12:21:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbaCYQVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 12:21:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D34775E02;
	Tue, 25 Mar 2014 12:21:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zoEJnd2CVmKQk4AID10wmDz3AT4=; b=and1cgV/p/8E4oQfD2T2
	VF5okdUzvKBHrX8Ue5ZOOHlJtlVeXgqhO6DEcUdT1nc1DaTQOu61jKk16x1Roo3A
	PDcNrQLr5zhYj1ugUOFj+OS6aJfV9Z+t51eatiaretcQlhhg9X25nwSnHjBU97kR
	VZbWbZsHCJjm15AUnytKIw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mIUIf6l9LLHHTrdjmWbQLHNcjOLS9ZcgCzpig9OInIGZB0
	hglbke+bWj7nuw6jLxh1DW0bjzAShGSUrPKKKMiPn9ICoxJhjxPeTG09CcQ28qt/
	Mni3iVUoPgQXsMlnQV2qXK1FF0ggsO+sN4LfGmdLeoLTmpWr0fbfZPXgkDKjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A25475E01;
	Tue, 25 Mar 2014 12:21:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC0AF75DFF;
	Tue, 25 Mar 2014 12:21:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74CF4E22-B439-11E3-BA9A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245042>

Elia Pinto <gitter.spiros@gmail.com> writes:

> The patch is simple but involves a large number of files with different authors. 
> Being simple I think it is wasteful to cc a large number of different people
> for doing a review. 

We'd somehow need a way to parallelize the reviews, though.  Being
simple is never an indication that the series is less likely to
contain bugs, and it often is an opposite.  It is easier to slip
bugs in to a simple, repetitive and long patch.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 02 Apr 2010 09:11:14 -0700
Message-ID: <7viq89bzrx.fsf@alter.siamese.dyndns.org>
References: <m2wd411cc4a1004011514w6d350ac7l15ab6bb1a6be8d89@mail.gmail.com>
 <7veiiymk75.fsf@alter.siamese.dyndns.org>
 <y2rd411cc4a1004020843we196537ak35ab6006ce28fefe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 18:11:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxjT3-00025c-Ek
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 18:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab0DBQL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 12:11:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab0DBQLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 12:11:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D8EA7962;
	Fri,  2 Apr 2010 12:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4jp5K+KtCJXMsKd6+v861pRnM2Q=; b=NcJjqP
	9nEbP7/BPDGvmoKfQKB0bJvnNUkXuX4KN1C8XCFRbk2fX3VdrbTpzmdxzJdq63vD
	42pvwUZXhTxj9mCVQkOeGcVLsER/yjihov6ZOSqntsWR69Nr80exNeDXQFD0utjb
	demfW0Y5qmZYulTiwKMHh3D3fuihzAakrYwbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xoYzTY4Ru5HXf4tGpo5NsTGTN6cJ5LlI
	hrzlAmta6myN4UQqX3t+b1og69OgPm4Bx8dtWwmfslxtygfLm3kLCFrrjJ5gRZ4w
	zhoi+1PE3bGvkrz9K6snrHPLk6fvv9rNqjmaTmx93g5exAlOHIqE34q0lsiM+vX9
	NTE3i2aF7g4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15257A7961;
	Fri,  2 Apr 2010 12:11:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8291CA7960; Fri,  2 Apr
 2010 12:11:16 -0400 (EDT)
In-Reply-To: <y2rd411cc4a1004020843we196537ak35ab6006ce28fefe@mail.gmail.com>
 (Scott Chacon's message of "Fri\, 2 Apr 2010 08\:43\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F4E7C26-3E72-11DF-9992-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143823>

Scott Chacon <schacon@gmail.com> writes:

> I do however agree that if someone _does_ put their username in the
> url that it should only prompt for the password if it 401s.  That
> should probably be a separate patch, though.

Oh, absolutely.  Thanks for a clear explanation.

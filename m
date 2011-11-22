From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 10:29:40 -0800
Message-ID: <7vk46sdn8r.fsf@alter.siamese.dyndns.org>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com>
 <4ECB8917.8010305@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>,
	Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 22 19:29:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSv6M-0004Eb-0s
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 19:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab1KVS3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 13:29:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab1KVS3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 13:29:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F8EE5800;
	Tue, 22 Nov 2011 13:29:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erWDgU7Nj3QGFdcTCWQubbRDX00=; b=IZyJ6B
	4hKPIwoSOI0NUuereSOORHrqDxQqY2fdeVSncKNwP4p0l+99ZFWAze5gvqI+T/rq
	yo0NLPaE8wWuEdJg6/9YHxl07jjhgyYfnrZPXquWwdJ2M7XxGeTwbtkWzcMIAVH/
	5L1hyuwUomlDj7BPlxf/xvsZwhCabbDWjvs/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NAmq4NL/7yWSZ3hvWc85RMLcThtnXiAt
	TZwSsgOc4/g1ugTB+9Ge/wg9U0Z3poLKiDsynzYOQ5VkYxS4Stjka/ufefeZpeNs
	8MOSJZz/qW0BGvUM/oppRdmeRXncjuR/i00vmKDe6l1HHX0W2+66Zs4ltWI32E5e
	1KnSEb7grSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6676C57FF;
	Tue, 22 Nov 2011 13:29:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD8FB57FE; Tue, 22 Nov 2011
 13:29:41 -0500 (EST)
In-Reply-To: <4ECB8917.8010305@ira.uka.de> (Holger Hellmuth's message of
 "Tue, 22 Nov 2011 12:35:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1A29EF2-1537-11E1-B244-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185805>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> (see "Bug report - local (and git ignored) file silently removed after
> checkout" on the mailing list why exclude is better than .gitignore at
> the moment)

Don't look at it or encourage people to rely on that bug to be
fixed. exclude and .gitignore should behave the same way.

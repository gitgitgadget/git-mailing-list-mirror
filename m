From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Tue, 29 Jun 2010 08:43:33 -0700
Message-ID: <7vsk45c09m.fsf@alter.siamese.dyndns.org>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
 <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
 <4C28ED49.90906@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 17:43:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTcyY-0006Si-EI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 17:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab0F2Pnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 11:43:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab0F2Pnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 11:43:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D4A4C08CA;
	Tue, 29 Jun 2010 11:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mglWmuhfErQUIEBGy5IP9QfxcUk=; b=SSyDqE
	iqkvcmVuoWugk9J3TEnrwFTm//W8QHmdnuhzmrnEpxy0UT3U0jjkLNbyEL+Q84Ev
	5rRgYhvBoxdYP8zn4RvROx3iN4IXH6I9L36l1p+pyiWDpCa2vNhDu75K+Z8i/gWU
	eLTBR2y9ya6p2+4k5xjrIGPJFLHQKvbHB2jbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzQUoYHYR1C6mHIe9cqVBX5L2s30J416
	CAxa2jEHaQgcaJXLdMaxAeCs3s1uKp3X2P1y7k8zB1i3gjxQsCEb/etEKv8FiBn9
	9SAVxzaskB6ri3ko0eHXlIvokT0vDir6b8qz+SQcIw3KuqQMFdT4eu0vW0YN8iIy
	8hOS1C68kPY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 569CDC08C8;
	Tue, 29 Jun 2010 11:43:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88241C08C7; Tue, 29 Jun
 2010 11:43:35 -0400 (EDT)
In-Reply-To: <4C28ED49.90906@xiplink.com> (Marc Branchaud's message of "Mon\,
 28 Jun 2010 14\:43\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16FA7D18-8395-11DF-A18C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149910>

Marc Branchaud <marcnarc@xiplink.com> writes:

> How about also adding a templates/hooks--pre-auto-gc.sample file?

Please don't, as samples are propagated to all newly created repositories.

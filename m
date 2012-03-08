From: Junio C Hamano <gitster@pobox.com>
Subject: Re: who's on first? - following first parent and merge-management
Date: Thu, 08 Mar 2012 14:52:13 -0800
Message-ID: <7vaa3qbt9e.fsf@alter.siamese.dyndns.org>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
 <7vty1zfwmd.fsf@alter.siamese.dyndns.org> <20120308074911.GA23712@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5mC6-0003oF-HW
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759033Ab2CHWwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 17:52:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758685Ab2CHWwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 17:52:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDB456BF0;
	Thu,  8 Mar 2012 17:52:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f5P6Yuw1yevyD7lHMlwXcwuRZYM=; b=aebx8i
	emga3q3pjENPkiv2PY59FUNL1IRIX55x9EsTirfN1sxxzSKticXllc7DXDsAsIMk
	5DNernha1kelU1E9Gk1X5PGkEeHU8WNs1X9YOAbdvJhn8x52xQIVu6UymP8JAqSu
	QtMxaWmPO+7JtGej1VqcR0fY+qBb/pjq5VqB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fsg6bAAcWMDhty1HzUbUvmlG18t9xx4s
	RNR5ymqmZXxfR4mhKoOvAOLF+r9gm1d+DmLo95oFCU6dgiTzy4c/+gS5v+s/i1hX
	3xpFtQl7AZFqI/L6lJE0hupxTOid1SPpFS9zTIbPaCJMp6vGDDfEzGr1ZfRSRYfp
	dbUknUxiN6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C488E6BEF;
	Thu,  8 Mar 2012 17:52:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 568CD6BED; Thu,  8 Mar 2012
 17:52:15 -0500 (EST)
In-Reply-To: <20120308074911.GA23712@burratino> (Jonathan Nieder's message of
 "Thu, 8 Mar 2012 01:49:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 599F39D8-6971-11E1-8EC2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192662>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Given the above definition, the first thing to realize is that "the
>> first parent" is primarily a local concept.
> [... and much nice explanation ...]
>
> Would you mind including this explanation as a new file with some name
> like <Documentation/howto/using-first-parent.txt>?  I think the quoted
> explanation is very clear and I have not come up with any obvious
> tweaks to make to it, which is why I am simply suggesting this instead
> of sending a patch that would repeat the same text.
>
> Strawman abstract:
>
> | From: Junio C Hamano <gitster@pobox.com>
> | Date: Wed, 07 Mar 2012 22:13:46 -0800
> | Subject: who's on first? - following first parent and merge-management
> | Abstract: In this article, JC describes the "log --first-parent" and
> |  "merge --no-ff" options and what kind of history makes them useful.

Everything I write here is open source, so in that sense I wouldn't
mind, but I have a suspicion that building on existing gitworkflows
document might be more appropriate, as opposed to a self-contained
standalone document that has to be read by readers in addition to
the other existing documents.  The current gitworkflows document is
detailed in describing how the history is built, but is fairly
lacking in description on how the resulting history can be studied.

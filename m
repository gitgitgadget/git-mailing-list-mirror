From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] grep docs: document --no-index option
Date: Thu, 25 Feb 2010 21:13:01 -0800
Message-ID: <7vocjceg0y.fsf@alter.siamese.dyndns.org>
References: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
 <1267155613-22134-5-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 06:13:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NksWS-0002TK-SU
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 06:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab0BZFNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 00:13:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0BZFNM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 00:13:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21B1A9DAE7;
	Fri, 26 Feb 2010 00:13:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZVTvmn88Sp3ZNM4yHTBWpV/juU8=; b=fZidVu
	65VwRD8io7MYMN36Gh+LGDc2hyzJuh1M39eqsoRPXJNprEzuBCfvLjVdzTA06+LG
	xtklnubeQaZ4mOuvO6HRjqSsmsjQjtp/wnx5vkXvAwVprcC1JErUOA0qUseoqbAX
	Q/KzmE2n44U+UV7EgOYf8SsA/8SKzkhnp0JXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WUUBTeyobHtXAq/iyjvYXvCrQKhp+4FJ
	ID4oopwoZn4otIT47g8NRRaZAZABi9fcTgBTiL6KhGCbHHKK36i4FpiG0+5wi/hS
	rGwnf8A4OCbfebLJNxuLXcB0dJWTkEDf7U4PPzfnF1w99b5hQG4Xn7zeaYqXiQeN
	ljzbhniKBY4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F16CE9DAE6;
	Fri, 26 Feb 2010 00:13:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F44F9DAE5; Fri, 26 Feb
 2010 00:13:03 -0500 (EST)
In-Reply-To: <1267155613-22134-5-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Thu\, 25 Feb 2010 22\:40\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FB83872-2295-11DF-909A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141105>

Mark Lodato <lodatom@gmail.com> writes:

> +--no-index::
> +	Search all files in the working tree, not just those tracked by git.

I gave a quick glance to all four patches.  Everything other than this
looked fine.

This one is meant to be usable outside git directory, and saying "the
working tree" is misleading.  The "work tree" is a technical term that
specifically means the files in the directory hierarchy on the filesystem
that correspond to the index entries that represent them.

It probably should say "the current directory" or something here.

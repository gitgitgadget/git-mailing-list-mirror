From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Extending the shelf life of "git describe" output
Date: Tue, 19 Jun 2012 16:08:01 -0700
Message-ID: <7vfw9qyk6m.fsf@alter.siamese.dyndns.org>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
 <877gv34vtg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7XZ-0001h8-34
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab2FSXIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:08:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab2FSXIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:08:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD899FE0;
	Tue, 19 Jun 2012 19:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lpYbZk1PNAvH1hHhGSzIHOwtABM=; b=J8sJQt
	tuPBVFSk0zDj7Wd/ftafDc/4dwvjGzW1hBsYiAelKUMkJwXfIEmXs7yNkfERdsLQ
	f+I7jnaasa7ppVGuHK8ZkkS2TMyyH5mfwEMtnDM9ysup5Ipf3KFO4f4bWk5aRhJy
	HoAXHERzRgRuS3ixHYx+vAPAGg8DSeq8fnCbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhC5HKN6i9qQNdoM5Rstct7oH1H9kRqB
	FeJ0+mJ2RsRM/7pQIJXDEJ1DR/ecPAqywKT9+sz4P0o/Vlgz5A7tNpceThVjvMSx
	tuM/OFBxgE7DFUSFKfpJNobtN4clm8AefBS0GUwF1Cp9CR1zG6eTO5p4igsmXChh
	IY9nwQdndcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B019FDF;
	Tue, 19 Jun 2012 19:08:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 303FC9FDB; Tue, 19 Jun 2012
 19:08:03 -0400 (EDT)
In-Reply-To: <877gv34vtg.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Jun 2012 09:14:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F98ECB6-BA63-11E1-B79A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200263>

Thomas Rast <trast@student.ethz.ch> writes:

> Two random thoughts:
>
> * The commit_only flag is only one thing you may "know" about the
>   parsing, as you state above.  E.g., we may know the distance from a
>   certain tag.  Given this, wouldn't it be cleaner to patch a struct
>   things_we_know into the call chain instead of only a flag?
>
> * The treeish:path syntax also "knows" that the left side must be or
>   peel to a tree, so it makes no sense to go looking for a blob.

Both good.  I take it to mean that we found a volunteer to take the
ownership of the second idea to build on top of the series ;-)

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #01; Fri, 2)
Date: Fri, 02 Sep 2011 15:29:02 -0700
Message-ID: <7v7h5q1sup.fsf@alter.siamese.dyndns.org>
References: <7vbov21tvi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 00:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzcEh-0005Oi-F6
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 00:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab1IBW3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 18:29:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab1IBW3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 18:29:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 855A3564C;
	Fri,  2 Sep 2011 18:29:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FPoD7EQC9sFNd2zm4FfsI6ZDgcM=; b=htqeT0
	ome4fPV/RtXhO6rlbSpehMYevMrV0xOluflkJt1S+SkwfWp4lhltpCaRDm36wR1Z
	Xk9UdcUKmoDoYvYWzJU3HqGpvY2FkNhgtzuGis/xRA8gElslkp8SC1hX5B9ozY2Z
	gsOVplQZ7KCqflUW57y0P3se/v7JgkJrhowh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QSzlJ3lszN59MDUPns9eQdAp0rDSnqAy
	Vad1KxZM4KBx6N06f1Wi3GA1G2/+tWPVQj2gqPQ4mG3QnKaYon3eATU24uMbxbuj
	u2HO9iH08szeBkyTRMBLjsszeVTuGGlvS7T01VaEWcNVKlrHrd3ZTT1jEHE7vl3X
	IEh/eEeVcow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BE62564B;
	Fri,  2 Sep 2011 18:29:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11303564A; Fri,  2 Sep 2011
 18:29:03 -0400 (EDT)
In-Reply-To: <7vbov21tvi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 02 Sep 2011 15:06:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6B1060A-D5B2-11E0-A946-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180640>

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
>
> Some of the recent patches are fixes to new feature topics already merged
> to "master" and are being fast tracked for 1.7.7-rc1, but otherwise
> patches for new features and fixes to longstanding issues will stay in
> 'pu' or 'next' until the 1.7.7 final.

I pushed the result of this week's intergration out, but not to the k.org
repository. You should be able to fetch from any of the following places
in the meantime:

[remote "repo"]
	url = git://repo.or.cz/alt-git.git

[remote "github"]
	url = https://github.com/gitster/git

[remote "gph"]
	url = https://code.google.com/p/git-core/

[remote "sf.net"]
	url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core

[remote "sfjp"]
	url = git://git.sourceforge.jp/gitroot/git-core/git.git

Thanks.

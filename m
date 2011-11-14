From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Sun, 13 Nov 2011 22:27:03 -0800
Message-ID: <7v62inkymg.fsf@alter.siamese.dyndns.org>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 07:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPq0h-00083e-AZ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 07:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab1KNG1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 01:27:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab1KNG1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 01:27:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 493D53BF0;
	Mon, 14 Nov 2011 01:27:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mf1orEbYHiOjfWlmNX88l5/2+yM=; b=x72ak5
	A8nUTNrpB7lDVwjiMgOrC3Nq9EUQ4RB446G2O5w9dZj3i7Vto1IrDAtPyqS33LiK
	URhw03dwUElIoiwIhqLJCdZe0E9VIo1AK48bc2SgilMaLvGCDmxmj8CfNPe/ZpvT
	vBAEBuNy81FaNlnzLp13EG02M3sHMeJegbmwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kMno7D6VZxxE7MgnySvg7aMKA/Bv9IkN
	Iw44ndK+qSBhxiun8zJUChn27+ZHXBndtEacC23EZJ9nqt302uWRzq6mN476qnSs
	fRreDBSzuuaevZ+2k4aYIkjDAZ9bWx5Wz2APGAkmcFfx8W1uvA2nzcMKBUxCEZtY
	nTfUSlEFI9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 422F43BEF;
	Mon, 14 Nov 2011 01:27:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C760C3BED; Mon, 14 Nov 2011
 01:27:04 -0500 (EST)
In-Reply-To: <buomxbzutjm.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Mon, 14 Nov 2011 15:06:37 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB7D9A30-0E89-11E1-91F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185366>

Miles Bader <miles@gnu.org> writes:

> Do you mean a more elaborate UI that does this nicely...?

Yes, that is what I meant. I also have a feeling that people would prefer
to have an option that treats these two repositories equally; your
illustration makes one a subordinate to the other.

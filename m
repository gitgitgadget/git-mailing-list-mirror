From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] contrib/subtree: general updates
Date: Wed, 13 Mar 2013 20:30:38 -0700
Message-ID: <7vvc8uzmht.fsf@alter.siamese.dyndns.org>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
 <874ngebsm9.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Campbell <pcampbell@kemitix.net>, git <git@vger.kernel.org>,
	David Greene <greened@obbligato.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 14 04:31:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFysq-0006fS-Al
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 04:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454Ab3CNDal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 23:30:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932743Ab3CNDal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 23:30:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78FB0B91E;
	Wed, 13 Mar 2013 23:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jXd3N4Q8e8jPfM4Nu/yn5vnbJOY=; b=f36BVT
	ZAO1s2ESv4VIC4oZUwhTRepi5kHqaJo3u23qeT/lD9opybaH3+4PJMyOr8NoM1MJ
	y2hQtG97X7OTh7NcvAOJjpI/nLV/HeL0cesxvBnGAWjhAvx3Qu9I1TbQlv5GGygd
	ufK1cmmIYWrhsn+4g61Vs0weoIsedwaCncFXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BiigwR5RPq26hMwo8wNqA/0erXWO6a9+
	qUPANjo0VT3tIvrzG48OVxXwZgVuse9toBkEdBtL02u0RcFsThQve082W6RGqIVj
	BakMk88JnRo5VCxz2RZgC4Y2Rt5LmJseU+xtGfcCkgNU+EHI9ewYWLjD0ZDOqUXc
	K7jjgzlQm9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E032B91C;
	Wed, 13 Mar 2013 23:30:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6733B91A; Wed, 13 Mar 2013
 23:30:39 -0400 (EDT)
In-Reply-To: <874ngebsm9.fsf@catnip.gol.com> (Miles Bader's message of "Thu,
 14 Mar 2013 11:52:14 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B226980-8C57-11E2-A84C-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218110>

Miles Bader <miles@gnu.org> writes:

> Paul Campbell <pcampbell@kemitix.net> writes:
>> James and Michael's patches add if clauses that use the
>> bashism 'if []' rather than 'if test'.
>
> "Bashism"...?  I dunno how portable is, but "[" is an old unix alias
> for "test" ... it certainly predates bash...

Correct. [[ ... ]] is new and spelling out "test" indeed is more
traditionalist than [ ... ], but for contrib/subtree/ that does not
work with anything but bash, I do not think such a rewrite has much
merit in the first place.  Being consistently "bash script" (as
opposed to being old-style) is more appropriate for it.

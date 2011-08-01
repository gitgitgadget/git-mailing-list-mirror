From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] bisect: introduce --no-checkout[=<ref>] support into
 porcelain.
Date: Sun, 31 Jul 2011 17:53:04 -0700
Message-ID: <7vaabukl5b.fsf@alter.siamese.dyndns.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
 <201107301634.33710.chriscool@tuxfamily.org>
 <CAH3AnrqaruBM8djz6Hfs0Rj5nqHBv6kU+yWNV5QYtaHrOKhRew@mail.gmail.com>
 <201107310236.31237.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 02:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qngl0-0005P8-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 02:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab1HAAxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 20:53:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753094Ab1HAAxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 20:53:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B14444A7;
	Sun, 31 Jul 2011 20:53:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=imNCyrX+PHiPgg22ry35vO3k8TU=; b=KRUQPr
	0IE2bKi3+MgXMlGiDroteTd5uUpiJXv/3qLWL86gtMxjGsy0ifnuKEdoLxVzqRMM
	+i5mnaVvCfzKK9uLLHvBbOrDnk7cxG3TOLKDDKiAFHl/nxWOgD2z9PWkn76TlTSO
	Hu5bsPR2H8OclvOlqcroyDojX49GVfgQrEE18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzyiNU//cERzMvuQSiM9eJB52KaYPV9o
	cBMMafNCmqZEeZ7AizFXt9Cej5wotMVGVm+da7o5DuQqx3ckqWtN9WD+WIFQmALO
	30CsDj9MioB4z6hkBfYtUtFZ9GT1E+IoV/9zL10Xsq4TEuaLCmdV0ttEsgwE/FET
	lDUEJ7D3FsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E8644A5;
	Sun, 31 Jul 2011 20:53:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAA0E44A4; Sun, 31 Jul 2011
 20:53:05 -0400 (EDT)
In-Reply-To: <201107310236.31237.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sun, 31 Jul 2011 02:36:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DFD5DE0-BBD8-11E0-B37B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178287>

Christian Couder <chriscool@tuxfamily.org> writes:

>> I've pushed a revision that addresses your comments to github  -
>> https://github.com/jonseymour/git/commits/no-checkout-v2
>> (git@github.com:jonseymour/git.git)
>
> I commented on some of the patches there.

Please do not do _there_ hiding from others who expect to see the topic
getting polished _here_.

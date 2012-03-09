From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: modernise style: more uses of test_line_count
Date: Fri, 09 Mar 2012 14:26:15 -0800
Message-ID: <7vpqcl4diw.fsf@alter.siamese.dyndns.org>
References: <08c65508e2a643cb3352b829675f79d592c917cb.1331329464.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68Gd-0007ZG-CM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870Ab2CIW0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:26:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030192Ab2CIW0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:26:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87B836E96;
	Fri,  9 Mar 2012 17:26:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rh8lfaGVmmCQWgWnXR9QWqL4xaQ=; b=MVjatO
	S/4Ad/Rj4iNUobiwWNsDTr3cPD3IcngzKwyom25A4r8vljaX750uL+8yZDVR4XKD
	GvRAAkivWPGWA/3L/qMRDsmp3cPBk5AV+RwzaFylmKaMPSqJztuGuZx6eHMK5EC2
	E5CVkqztHb6vZ++h3W+aV/DCQr1i1jyrPRTW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vR0tjTXiGm6IvvOfsfXtyjlc4E2FzRd2
	okHYAgLyj6f5Bm8FDHeyL2s0j2kmYhZgICfOjdXNCx6VFeRC/9SEsxq/xYUJQWm8
	zH8zl6u5xqlxd5rWkI72LyXNdFsp6qr/xWYHh1IMlWgM4axT+hdf2m/b4qJk8NYW
	KO+kRjxfSCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F8526E95;
	Fri,  9 Mar 2012 17:26:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1444B6E93; Fri,  9 Mar 2012
 17:26:16 -0500 (EST)
In-Reply-To: <08c65508e2a643cb3352b829675f79d592c917cb.1331329464.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 9 Mar 2012 23:17:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E33B9B1C-6A36-11E1-B0BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192746>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

>  This change modernizes one (and just one) kind of obsolescent idiom
>  throughout (almost) all the tests, rather than tweaking one single test
>  with lots of different and unrelated modernizations.  This approach
>  seems safer, and IMHO makes for patches easier to write and review.

Yes, but during the pre-release "regression fix only" period is not
a good time to do so.

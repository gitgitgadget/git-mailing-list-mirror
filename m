From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] merge: Make 'merge.log' an integer or boolean
 option
Date: Tue, 24 Aug 2010 12:01:40 -0700
Message-ID: <7vmxsbu963.fsf@alter.siamese.dyndns.org>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
 <1282494398-20542-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 21:02:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onyku-0003HW-BX
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab0HXTBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:01:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab0HXTBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:01:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34742D0B35;
	Tue, 24 Aug 2010 15:01:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FQYXCj0vTAA6h+XsiFpAWLKca5I=; b=rU+b55T8mWUEGrdH6Q1iAzG
	BmgSwAQf7QDyF+IUiyQI9RbN8lU7lcRhhNJlb0YVpdNwyVCaj9RDN6+hIw6ChGev
	VS7KV/sSO1Zor+aGDk8kmaBDIlB8qRGRChGZ6Ow6p4GHl5KlN5WTnvLsJ2tHJSvW
	YG6eMcs5woOPpM4X0F0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MF9s4u83bEF1wkXngutuHuUDS50C956Sbq/KLN2386m0xyJ8Q
	uhl8zWwyMS8yFJTDj0LdTCtxKES+Ojc1skGTr/zlYaTd+cEVS5OKgWyGpRhOrM3s
	TK8YIH+zUfTeBqk8QcVK5Uf3d/qciiahFWlWk9lk8cb8i5+kfjRjXyxJIs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD0A3D0B2B;
	Tue, 24 Aug 2010 15:01:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3068D0B25; Tue, 24 Aug
 2010 15:01:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B84E1B4-AFB2-11DF-990A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154338>

This makes sense, but I agree with Jonathan's reviews on 1/5 and 2/5, I'll
ask you to reroll this on top of what I'll push out shortly.

As to 4/5, I think we should proceed a lot more carefully than what your
patch does, just like we were extra careful when we went to v1.7.0 than
when we went to v1.6.0 (see release notes to 1.6.6 for a summary,
especially paying attention to the third and the fourth paragraph in
"Preparing yourselves" section).

I've queued 5/5 directly on maint.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] correct a few doubled-word nits in comments and
 documentation
Date: Wed, 28 Mar 2012 08:57:42 -0700
Message-ID: <7vty18wweh.fsf@alter.siamese.dyndns.org>
References: <87d37xun9r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCvG2-0003DO-MQ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab2C1P5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:57:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758359Ab2C1P5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:57:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBEED6548;
	Wed, 28 Mar 2012 11:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gjYIoJXfWAzpm0J6p0lMkWvIiJE=; b=Rs+gnm
	A+9Uv+WOJagxXNks69Fb5lQRM6JuNoIeSBLLjxtJK6uu56UkBkPE9lbi0cMM8J4/
	HnshYMl1lSdUq23SN3dbLRfHpyUVk1JSuR98/LpdxyYkKAA/jO5x93JLvxjAy8yd
	P+leEgXpO8bVWteimn2ya/c16EjBdgLZqRrWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLvlZ9W3isxN00wP+N0lE/g/QQ4lAVNJ
	iiqKOwMJ7To3H3/7komm0zZp6LkfE2SV477ScA3LeT7it86Dof6CkHRytLq9vkRq
	hp96vhY4BZL3t6SLS3BuMQQRAqBIOSzccrzVhSESWz0XnQEpyxP5uFs4dW2CJxkj
	36UIk6PFXgU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B361F6547;
	Wed, 28 Mar 2012 11:57:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A9326546; Wed, 28 Mar 2012
 11:57:44 -0400 (EDT)
In-Reply-To: <87d37xun9r.fsf@rho.meyering.net> (Jim Meyering's message of
 "Wed, 28 Mar 2012 10:45:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C19558A6-78EE-11E1-8F04-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194141>

Thanks; by the way, you have an extra patch message concatenated after
the main one.

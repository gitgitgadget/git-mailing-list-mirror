From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-parse --since=1970-01-01 does not work reliably
Date: Thu, 03 Nov 2011 17:36:28 -0700
Message-ID: <7v39e4enar.fsf@alter.siamese.dyndns.org>
References: <20111031161708.GA29924@altlinux.org> <20111031231320.GA3857@do>
 <CACsJy8AewxbocqQ3gvgcrbSuNyKa0BCqDn6OV31m_6-P1AxJCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 01:38:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM7nQ-0001Ht-5K
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 01:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1KDAgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 20:36:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab1KDAgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 20:36:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4256C6242;
	Thu,  3 Nov 2011 20:36:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bb81qmfeYphcZJNS+OAgr31Xwv0=; b=vj/xYO
	qgnTC4ypBII9wedDiQtOagqCNRyk+oxycRDzedagyuj1jhfwgLRoUjypF97SwEQB
	V3dCvAoG1SaKWP1UiE1gZ6EDy2CFkvES3S4jyXqr6NcMbFfYnMpJbk5+IjE1l6rH
	3mM8Ecq3sYNd6RB+Z7ptUVgMWDTuwEr3G5QlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NVY9vZwKLjHRxa1P2FYVxXeGCuV62+E3
	Kh/nVC++CqDMkyaLW9iZHhT4vyXQ39qcJfnlXwqPVxFm63dnnwCXbO8kzt+n5NYS
	o3ChJvkcBdcUlJkReTT32g2SvQXWhsJBMxm0qGD9U1+9hKcLd8Cjx3651/ernujN
	z6xkBgVF4ZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38BF16241;
	Thu,  3 Nov 2011 20:36:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4DAF6240; Thu,  3 Nov 2011
 20:36:29 -0400 (EDT)
In-Reply-To: <CACsJy8AewxbocqQ3gvgcrbSuNyKa0BCqDn6OV31m_6-P1AxJCA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 4 Nov 2011 06:37:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09845124-067D-11E1-9F9A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184753>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/11/1 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> Subject: [PATCH] Do not accept negative time_t
>>
>> We use unsigned long internally to present time, negative value just
>> breaks thing.
>
> Junio, what do you think about this patch?

At this late point in the release cycle, the topic itself is a Meh for me,
especially when other discussions for next cycle occupies my attention.

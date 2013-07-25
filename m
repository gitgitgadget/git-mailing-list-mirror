From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] web--browse: support /usr/bin/cygstart on Cygwin
Date: Thu, 25 Jul 2013 08:59:36 -0700
Message-ID: <7vtxji4olz.fsf@alter.siamese.dyndns.org>
References: <1371799472-11564-1-git-send-email-yselkowitz@users.sourceforge.net>
	<7vbo6zo3d1.fsf@alter.siamese.dyndns.org>
	<51EF0391.5070502@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yaakov \(Cygwin\/X\)" <yselkowitz@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jul 25 17:59:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2NxD-0005Wq-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 17:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab3GYP7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 11:59:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab3GYP7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 11:59:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 243AD31E51;
	Thu, 25 Jul 2013 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U1XCHKu7XZZJJFmIc/LO6224Whc=; b=OWJhub
	vSw0/NmsNunkH6ES5Khj/veb2zccw0UcF+NnJrAZLlH79PGC/k08RG/RwzcDAZYj
	a9XEKZmTcLVm0UA0kdl2sGHVpdfV4FHJmql7tjezmMxPFfcujos2YaMtrnrC1Iep
	X3vDKxnR13exP8ssmNkbeAm0KCXF4yJ5HMScM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xonQPIQjK5ntZ4NdWIZtIYuKMGB7OAgx
	24ui7ywLF7Tub1+AEC2J1V1iPN4Vuo0aHkHzSMLtLQeKLzyf6U1gXHMV4AMG5oKm
	ibhJDDE4XkvRl1MsTp2Oa4fFWsxFsB7GuwCupkt+aL814fLJOsJIHLMFRshpt0ZH
	WmVv57npwVw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD57631E4E;
	Thu, 25 Jul 2013 15:59:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C234C31E46;
	Thu, 25 Jul 2013 15:59:38 +0000 (UTC)
In-Reply-To: <51EF0391.5070502@users.sourceforge.net> (Yaakov's message of
	"Tue, 23 Jul 2013 17:28:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 361E1088-F543-11E2-8A8F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231141>

"Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net> writes:

>>> Signed-off-by: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
>>
>> Will queue and wait for somebody from Cygwin land to comment.
>
> Ping?  Is there someone in particular whose input you are looking for?

Nobody in particular.  Nobody complained nor reported breakages, so
we are good to go ;-)

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 01/10] git p4 test: wait longer for p4d to start and
 test its pid
Date: Wed, 27 Jun 2012 21:05:52 -0700
Message-ID: <7vsjdg5bdr.fsf@alter.siamese.dyndns.org>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
 <1340798463-14499-2-git-send-email-pw@padd.com>
 <7vfw9g78w5.fsf@alter.siamese.dyndns.org> <20120628024807.GA16349@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 06:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk5zU-0001BC-Db
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 06:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab2F1EF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 00:05:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab2F1EFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 00:05:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2D5C302E;
	Thu, 28 Jun 2012 00:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z4DxuPAyC+dza/NxEbU6KKd2AUQ=; b=albMYm
	X0owsyn8/oPB2E8+x+dgORR73SpggDvkpLZXGshk81clQSuLcZtIvW90dfhbJXeG
	X/HSPQtSZ2f9kND0m63wicCqwYA37oY66cMOsHY6TxHXye3YcNbBsYeUbh8F9DEz
	BTP8PQiT720Ff/1kdUfiMzlzTJD1jKH5kvvms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rsx3TpD5o1Wg7mSB0sW6XTjV9ITOeOC0
	a0g8aaEghBOqeKIKEQ/spHCaQw+Yt5dqlCFevM1L6f0kLMLIc4QC9XkXmAa/Olog
	THueXm7CWEuALO57e8Wdhz4TyOafgZczFSLol5YdgzEYkbBtpWro86bkjJB7+kCT
	rp2upajDLLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9AA6302D;
	Thu, 28 Jun 2012 00:05:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38FB5302C; Thu, 28 Jun 2012
 00:05:54 -0400 (EDT)
In-Reply-To: <20120628024807.GA16349@padd.com> (Pete Wyckoff's message of
 "Wed, 27 Jun 2012 22:48:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E666A4E-C0D6-11E1-AA98-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200775>

Pete Wyckoff <pw@padd.com> writes:

> Just this patch changed; if it's easy to replace one in the
> series?  Else I could resend all 10.

Thanks, sending only this one is just fine.

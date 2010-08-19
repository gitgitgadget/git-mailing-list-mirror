From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/regex: define out variables only used under
 RE_ENABLE_I18N
Date: Thu, 19 Aug 2010 14:07:13 -0700
Message-ID: <7vlj8271mm.fsf@alter.siamese.dyndns.org>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
 <1282242601-2630-1-git-send-email-avarab@gmail.com>
 <7vtymq74mp.fsf@alter.siamese.dyndns.org>
 <AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 23:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmCKe-0004db-N6
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 23:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab0HSVHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 17:07:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0HSVHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 17:07:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ABF5CE698;
	Thu, 19 Aug 2010 17:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bdbq5DD1yCP+
	x6la6+DP61YqYZQ=; b=AlXkldZ2g+SEFZcQVkKb6HUC4WzAZdRLVtmQ0PfHZExK
	/UdXDEsUU9FznQMhvPAN4QzwLAqMMJWM57dQWLmoW+8Cz1q7HrbGEYR60YvWbC8a
	R9dA3id8OmJ2eVN1P7nCih1DVYSnAjz3gNgN5Q/+J3Fl72ktfqUhmts8c07rBU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u7Mv0z
	eW59o0ZqtTgzinozFxvqu9CD0rLLqSppPqmRlO0n1OmzxC8boSfJWSx58PVuVjt2
	bjrVnvOgrP7ux81R2BVrVwEVajw/TW4uPsonELdY7TyWtjm9PzZkA5/dpMwYCwFj
	BtGhR9rVGLnqLN1K5ha10O5RGQmv965M6v7i4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9292CE697;
	Thu, 19 Aug 2010 17:07:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2919DCE696; Thu, 19 Aug
 2010 17:07:15 -0400 (EDT)
In-Reply-To: <AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 19 Aug
 2010 20\:31\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C06E583E-ABD5-11DF-9F9F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153959>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Could you compile the old compat/regex library on the same system?

Did I ever say this was a regression?

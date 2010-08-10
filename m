From: Junio C Hamano <gitster@pobox.com>
Subject: Tonight's pushout...
Date: Mon, 09 Aug 2010 22:35:33 -0700
Message-ID: <7vd3tr3u8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 07:36:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OihVc-0005n4-N1
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 07:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab0HJFgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 01:36:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab0HJFgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 01:36:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D22CC329;
	Tue, 10 Aug 2010 01:36:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=HRxj
	7Cba2A4ulJEK79vI905oGQc=; b=Wqsy1wu5FXIhEJgPhR4uB1CQE58O3Y824ror
	X7DPMWwgbOtf36pVPvAANAoGJnqj7NJMEPWenLGpvBlmZPAUJwskLgXu0LJw+8BH
	hbfrF+Vsgb5x2QqjRns3tOISRKWxvAjZDcBrzLiR4YkJ4nnV1OOQH/MndT4WvEXa
	uNfQciQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=chF
	dnm7vo7lLE4Mj3bhaAbsKkK1KC4HwhhS0JPiGmdoROhwALlNZIctJyA0vPaUeNJU
	gpkR+73KvPhvV+6VkbP0vM1zeuphXufyYKqUuCWwo8vRIY+ZheQCoKQKs/13YGbb
	Wi8+2LogIYjdp5zpBinIZ5KcLTfJYMXg1lvTVsnk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C519CC328;
	Tue, 10 Aug 2010 01:35:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44423CC326; Tue, 10 Aug
 2010 01:35:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26B21E60-A441-11DF-A928-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153076>

... contains 'pu' which is known to be broken (the merge at the tip
doesn't even have a correct merge resolution).  I am a bit under the
weather (and on antibiotics) and am lacking concentration right now.  but
I just wanted to push out the tips of topic branches out to show which
ones are already queued to be considered.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Tue, 01 Jun 2010 21:40:20 -0700
Message-ID: <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
References: <cover.1275309129.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:40:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfkk-0002Qc-RD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0FBEk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 00:40:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0FBEk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 00:40:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05BE8B6F14;
	Wed,  2 Jun 2010 00:40:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=fhWYnnk70KXNgju1Vxz6uWGso
	Vc=; b=KV7QKCb0PW2TYCKU4gkDgm2FxcAdxhnwI9dUut59Tj6mTDHfLqq91ytVU
	/xECH3fYm9dLzQT93MgLgNiwu+LOepwZ5ezTNQYQbMM3ecaTwvfMakOA5NS+xseZ
	h/Xl+1NCW8xH+cQZPBLesPDVZ3eqjgp5Wkfcur2+jOJOaX31LI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=b9/qIHz44h4H3WP3nFr
	Zq5YLgI5uAFwTtSQarielu3y/IzC3b06BUCRsKTc5tCC3LCjoUaJyJxRNStMXrwp
	+/AqEEdMve2n+6Cx2rXRxzwCMwRzkMZTHTQSMfVuOCtYNNmk28kHUQqR7NuYX3sF
	hJ3W8CDCxDvr+81KfLFaQfxs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D72E0B6F12;
	Wed,  2 Jun 2010 00:40:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BEC2B6F0C; Wed,  2 Jun
 2010 00:40:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5DF9950-6E00-11DF-8075-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148197>

"Henrik Grubbstr=C3=B6m (Grubba)" <grubba@grubba.org> writes:

> This is useful for repositorys not containing fully normalized files
> (eg containing CRLF's or expanded $Id$ strings), where a later attrib=
ute
> change implies a conversion mode change. Without this set of patches
> the user would need to recommit semantically unchanged files to get
> a clean index.

A more fundamental (or perhaps "silly") question is if that "user would
need to" is necessarily a bad thing.  If the user wants to cleanse such
abnormality in the recorded blobs, shouldn't there be a conscious act,
iow, a commit that records that "I am fixing that mistake, and from now
on, the recorded data are normalized"?

Perhaps I am missing something very trivial that you have already
explained to the list but I forgot amid my moving and other confusion, =
and
if that is the case I apologize in advance ;-).

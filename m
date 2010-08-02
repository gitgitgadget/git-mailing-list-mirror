From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] Documentation: flesh out =?utf-8?B?4oCcZ2l0?=
 =?utf-8?B?IHB1bGzigJ0=?= description
Date: Sun, 01 Aug 2010 21:32:03 -0700
Message-ID: <7vbp9lprcs.fsf@alter.siamese.dyndns.org>
References: <20100801025439.GA9592@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfmhU-0001my-CF
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab0HBEcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 00:32:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab0HBEcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 00:32:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62011CAA91;
	Mon,  2 Aug 2010 00:32:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2V3eMhKLHa1T9z28glySJeWAzdQ=; b=wqYtes
	mogaVOTKgpVABjz+MbdVq9XJ43q5ln9y70yEJtlWIvdxKwWO4968X8WAmmF/HmDs
	YCvgez+v9VKMeked94+uLhoHiKxiEcND88D65tDXsUSjTWCSwRDVkyLzXl+n1VqX
	3UApRaMCZqkRVPfYDEtzYsU97GVyci3YwaxVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bf4uzNp+e+phheYNtXVoMhMuiwRVtGuC
	WHXFwXScXFz6qaISOhBV0Uul97QOPg32iTF+0nY6sMNr05zYwUGiIgwpu1Jz/x3g
	KoAvqzJKGxvQyShjbq2MhfVW4kj7mdrz30UW/SxsfNu3RakTlAVnJLIc11wVDHZL
	o2f0Nxt6aII=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 119F1CAA90;
	Mon,  2 Aug 2010 00:32:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F166CAA8F; Mon,  2 Aug
 2010 00:32:04 -0400 (EDT)
In-Reply-To: <20100801025439.GA9592@burratino> (Jonathan Nieder's message of
 "Sat\, 31 Jul 2010 21\:54\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EABD425C-9DEE-11DF-9A15-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152392>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio: ideally for this to work, git-pull.html would need to get the
> same special treatment as git.html gets.  Does that seem doable?  Is
> Meta/dodoc.sh still the script to do it?

I am a bit reluctant to see stalenotes[] being abused; that ugly hack is
in effect _only_ while k.org documentation is being built to hang the "You
are reading the latest dev version, newer than anything released" sign on
the front door.

People with older git have documentation shipped with their versions, no?

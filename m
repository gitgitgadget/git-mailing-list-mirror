From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: simplify "missing PREREQ" message
Date: Tue, 24 Aug 2010 12:01:21 -0700
Message-ID: <7v4oejvnr2.fsf@alter.siamese.dyndns.org>
References: <20100811014325.GA4169@burratino>
 <1281528278-15659-1-git-send-email-avarab@gmail.com>
 <20100824073410.GA5562@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 21:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onykt-0003HW-5Z
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab0HXTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:01:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab0HXTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:01:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BC1CD0B1C;
	Tue, 24 Aug 2010 15:01:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0z2YdnTe2EzzYtheu8THY5aLcqg=; b=ULX/uwjw0oU5DWykT2kxysk
	QAr9wfD8qOhj5JA4zdlvcq2jJXZjsfXY+3/fGMQ8jDwmQRK3L5OGeAGZ3THTq4/x
	baXDLuhhgfByzLZnDWRpk6Ujt3eLuVAesAOXjoharzSp9VTZM7EIdMt2n/cB35fC
	TugxPzJBfW2DzkLWZX50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nQ2GkF/Ae3b0b+aVCphCNc5Jt40JQr3nzPatIt9Ly0Iu7vIrc
	TczCg+/x/Ry4bVDPExGKRP8uJW/SQGvwU8iOVKNgg8w3qVuh1NWut4g0DuLcC+Vp
	KvGIhhfBgNe0aDlWYg5ckJZ0wRERvExMyJ4XN9QRznfL+ellPGZgpbjfDg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 348CDD0B1A;
	Tue, 24 Aug 2010 15:01:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4F2D0B14; Tue, 24 Aug
 2010 15:01:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF4F5514-AFB1-11DF-876F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154336>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Noticed this when building "next".  Thoughts?

Definitely nicer ;-)

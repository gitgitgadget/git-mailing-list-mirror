From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] patch-id: Add support for mbox format
Date: Tue, 20 Apr 2010 09:54:26 -0700
Message-ID: <7v4oj6hxod.fsf@alter.siamese.dyndns.org>
References: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org>
 <1271666774-11619-1-git-send-email-bonzini@gnu.org>
 <1271666774-11619-2-git-send-email-bonzini@gnu.org>
 <7vy6gjp0zy.fsf@alter.siamese.dyndns.org> <4BCD6A36.90208@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 18:54:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Gif-0003CC-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 18:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab0DTQyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 12:54:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab0DTQyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 12:54:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0691EAC76A;
	Tue, 20 Apr 2010 12:54:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7oN1iMT9IifY+nKOSSDVdl3bjFc=; b=up07HQ
	5aYT7BxTk9zj8k41TofZJHa/XgS6wlMhSRZw2QP96sA10RqwzFk4mi2jEqXllAwG
	oGx7SJpKtZDlGiktnDMzf2attxiR0RUqnsCSOUOhLpYhOeKrvH1lhv4g27ab+wuF
	KWjdmJwWus6zwaiCWo86RwvwEPrrTyH3kQE98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lhEWABp3fPvEI3uSjysbRzrubx/cFgVt
	GfMjMEFxRUjLGjZvx0njV+nniZYazQMYBW5pepA78cubTZlUPED4zeyvgdW065YK
	tAUhdwqHXJppOuRDLzlDjkIqDMzgwThW38NM3jhKzU2yKdtQuHbn7caYZSRXajnb
	oI+IYpmkMX8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D589CAC766;
	Tue, 20 Apr 2010 12:54:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11EBCAC75D; Tue, 20 Apr
 2010 12:54:27 -0400 (EDT)
In-Reply-To: <4BCD6A36.90208@gnu.org> (Paolo Bonzini's message of "Tue\, 20
 Apr 2010 10\:47\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6429C550-4C9D-11DF-ADBD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145389>

Paolo Bonzini <bonzini@gnu.org> writes:

> This v2 also handles MIME, see the tests.

I was more worried about quoted-printable (or base64) when I said MIME ;-)

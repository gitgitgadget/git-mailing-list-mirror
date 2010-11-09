From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH en/cascade-tests] tests: add missing &&
Date: Tue, 09 Nov 2010 14:25:34 -0800
Message-ID: <7vr5eukuch.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino> <7vr5f73umz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 23:26:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwdh-0001Wr-N4
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab0KIWZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 17:25:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab0KIWZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 17:25:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2834A30AE;
	Tue,  9 Nov 2010 17:25:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UVECPU/FrHXw4FpNysWzJ9MKqMY=; b=T+pPuS
	qmDJcOdVPAomaHpVyuCdPo+0bwRcL7m3n0jARwiX2heCbWC+G9rehDZeEQJHqoJI
	CZzZlEHZZhJhgz51x1pKYOT3MPNiUi1x9hNVzDcN4YPY0N3+Z1SXEt5QLC+C+e0/
	PjveFE8w7j0xR7Z/XwI4D/h3Naw5Py7QvxIsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0YYO0JZ04lb0r1rpMomUJTie3sVPuYM
	ylN+0KIda11+/YYBf4W51yvjvB7emDAVCVPXZrOrmbINBuPIkIPVpPc9sgVn3YZA
	2dzKNyNMl/kc3SdUOtFsO+1y8/8v7inkGKDx2SpMT13ZPx79pF4OhOgAF9jp12Dm
	/FUC+UUJ1nk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF5B030AD;
	Tue,  9 Nov 2010 17:25:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9491830A8; Tue,  9 Nov 2010
 17:25:40 -0500 (EST)
In-Reply-To: <7vr5f73umz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 30 Oct 2010 20\:31\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4BDD815A-EC50-11DF-A6CE-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161105>

Junio C Hamano <gitster@pobox.com> writes:

> Looked up to but not including t5302 and all looked Ok.

I looked at the rest and it looked fine.  Queued on top of en/and-cascade-tests
and seems to merge to 'pu' without much conflicts.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lock_any_ref_for_update(): clarify switch case statement
Date: Tue, 10 May 2011 13:07:49 -0700
Message-ID: <7vliyeiaju.fsf@alter.siamese.dyndns.org>
References: <4DC925F1.4060307@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:08:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtDv-0005LN-P2
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab1EJUH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:07:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab1EJUH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB04059FA;
	Tue, 10 May 2011 16:10:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ly3Q7SRWTIY2uWB/etKwN2Drfxs=; b=NvVoT1
	Tu+6u/NDpQpaPOl92XXEpA6eiUnYG4EQ22t0a7PGnaClW1VTKsDkOCgHdZvqkr27
	87qwhJyJmviPklwBixTzD0P4zSiXFIqgeKY2C0gwMt8hwj6ZI9kVXaCauzv+psgX
	Q4wzRZiWBLJ7asQrdKCV31/w4c9AF4eUbL6/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BoWONFjSuPoey2Q5/vianKQSjFZYXX9R
	8oq05GGZ5W4xGKhsclFoY6DOkXTso7MQ3uvVPphuJ3F1i6tbMr44ztB33/Zxw+r0
	CKj4PLEiT+kCu90pFhs28uh4zFddK03cGWsmRtC1G908J+em7I35QHZQ2je5tOuE
	NB8EgiDTWlU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D6C459F9;
	Tue, 10 May 2011 16:10:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 84A7559F8; Tue, 10 May 2011
 16:09:57 -0400 (EDT)
In-Reply-To: <4DC925F1.4060307@elegosoft.com> (Michael Schubert's message of
 "Tue, 10 May 2011 13:48:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BE7FBA2-7B41-11E0-B922-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173355>

Michael Schubert <mschub@elegosoft.com> writes:

> Write CHECK_REF_FORMAT_OK instead of '0' to be more verbose.

It is not wrong per-se to spell it out to be more descriptive, but I would
think 0 is clear enough that there is no error.

In any case, being verbose is never a goal ;-).

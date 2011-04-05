From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn: Cache results of running the executable
 "git config"
Date: Tue, 05 Apr 2011 01:15:53 -0700
Message-ID: <7vd3l15d1i.fsf@alter.siamese.dyndns.org>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu>
 <1301944148-7950-3-git-send-email-asedeno@mit.edu>
 <20110404215331.GB4224@dcvr.yhbt.net>
 <7voc4l5hm5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	=?utf-8?Q?Alejandro_R=2E_Sede?= =?utf-8?Q?=C3=B1o?= 
	<asedeno@mit.edu>, git@vger.kernel.org,
	James Y Knight <jknight@itasoftware.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 10:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q71R1-0001IF-Ff
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 10:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab1DEIQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 04:16:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab1DEIQR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 04:16:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DB2E37A3;
	Tue,  5 Apr 2011 04:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Shn41OUFA+hr
	B9CBpkyPpUBsyIg=; b=wOLfqhHGqyI3AQexz/BHtogPl9KCzmOOiRmuEnmrDyhB
	8zrF6LRkyZI1kh1sJOynARcJBNPMHZs0AFfQvPiL5jd6r3fyj+9cU+q8tm9twAe3
	ljG0+MtHlXMbXtennaj6SDeB5i2mopdta+qAJpIYvMJ+bizh7JAXItNcOZQpHMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M72S8r
	rSB80rAJXkEcnxXv5T/OtSG3DuDI0zGmxog3wn8fPk98P8KZta6XJN7DtqGfaOU4
	nHJ7Q5vFmBolz05DIjW7GkyYcezdsDz0oaNgJdFq23oet6zK2V5mJCQJVXn+bifF
	Y3uosIFNmIgqI1RtiHKhqkzxTAFBzH+/pCZok=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3894A37A2;
	Tue,  5 Apr 2011 04:17:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB9D837A0; Tue,  5 Apr 2011
 04:17:47 -0400 (EDT)
In-Reply-To: <7voc4l5hm5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 04 Apr 2011 23:37:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37A6D45E-5F5D-11E0-BA86-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170875>

Eric Wong <normalperson@yhbt.net> writes:

> "Alejandro R. Sede=C3=B1o" <asedeno@mit.edu> wrote:
>> From: James Y Knight <jknight@itasoftware.com>
>>=20
>> Running programs is not cheap!
>>=20
>> Signed-off-by: James Y Knight <jknight@itasoftware.com>
>> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>
> Thanks, acked and pushed out to git://bogomips.org/git-svn.git

Hmph, any comment on 1/2 of the series?

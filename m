From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t9700: Use Test::More->builder, not
 $Test::Builder::Test
Date: Sun, 27 Jun 2010 11:27:30 -0700
Message-ID: <7vvd94fi0d.fsf@alter.siamese.dyndns.org>
References: <1277554872-6402-1-git-send-email-avarab@gmail.com>
 <1277556161-8718-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 20:27:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSwZy-0007OB-Gi
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 20:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab0F0S1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jun 2010 14:27:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0F0S1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 14:27:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE8ABF644;
	Sun, 27 Jun 2010 14:27:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=o2sqIiWldV3L/cdEQ/8g9jC8f
	8I=; b=xwAbbepBcdN0yaH0lV9WdGusita/u1i0lxc/0rzt0Qc3c0wq4QYjc9Jh0
	BFMN7V3bsIVVR/yZsfINMXjtEaJBcQaNpdE3SDiwVWlFyAtbaYsJO6cD0MNV+BS1
	4DwZPMj6tFlI/LwdhyQz/knMwxj+ExdXxQ3RpJv70x+lGhAhTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=om7GqIKwlNOzNM5v1OR
	bpWpl0UP9n3SwEbNbanwLKNo5q+ADoh7JTSXeqEvHVdSses2ehZjQVePVmq5DDf9
	lxhWcarGN1bnbm1+iAsVplmzSPJwpyROq41ZPyN8dYlZgnesENsj+NdawyMTlFhF
	V8xCNRhSRTISnRET20hCGW3A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F202EBF642;
	Sun, 27 Jun 2010 14:27:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ECA8BF641; Sun, 27 Jun
 2010 14:27:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A80D5820-8219-11DF-A48B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149798>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> $Test::Builder::Test was only made into an `our' variable in 0.94
> released in September 2009, older distros are more likely to have 0.9=
2
> or earlier. Use the singleton Test::More->builder constructor instead=
=2E

Ah, that is what it was.  I was wondering what it was that showed 1..1 =
and
then 1..40.

Thanks; will queue on top of ab/tap.

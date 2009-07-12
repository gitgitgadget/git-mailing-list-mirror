From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 14:34:51 -0700
Message-ID: <7vbpnplh50.fsf@alter.siamese.dyndns.org>
References: <4A598E03.10204@gmail.com>
 <1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7v8witn4e5.fsf@alter.siamese.dyndns.org> <20090712203716.20ac4261@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ6hK-00018v-CB
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbZGLVe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 17:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbZGLVez
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:34:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbZGLVez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:34:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CA0927ED5;
	Sun, 12 Jul 2009 17:34:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7CC1F27ED4; Sun,
 12 Jul 2009 17:34:52 -0400 (EDT)
In-Reply-To: <20090712203716.20ac4261@gmail.com> (=?utf-8?Q?=22Micha=C5=82?=
 Kiedrowicz"'s message of "Sun\, 12 Jul 2009 20\:37\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7145FE4-6F2B-11DE-80E9-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123162>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> BTW: There is a difference:
>
>> diff --git a/builtin-init-db.c b/builtin-init-db.c
>> index 4a56006..9b1ce45 100644
>
> and=20
>
>> diff --git a/builtin-init-db.c b/builtin-init-db.c
>> index 4a56006..d68f61b 100644

Yeah, I was blind; I see them now.

Thanks, will queue.

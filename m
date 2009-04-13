From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: test applying criss-cross rename patch
Date: Mon, 13 Apr 2009 12:28:45 -0700
Message-ID: <7vvdp8e4k2.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
 <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vd4bgh560.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 21:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtRri-0006Dj-5W
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 21:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbZDMT2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 15:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZDMT2x
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 15:28:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZDMT2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 15:28:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E5B6CE6A1;
	Mon, 13 Apr 2009 15:28:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4FE13E6A0; Mon,
 13 Apr 2009 15:28:47 -0400 (EDT)
In-Reply-To: <7vd4bgh560.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Apr 2009 09:47:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50BEC972-2861-11DE-A934-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116478>

Junio C Hamano <gitster@pobox.com> writes:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>
>> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
>> ---
>>  t/t4130-apply-criss-cross-rename.sh |   35 ++++++++++++++++++++++++=
+++++++++++
>>  1 files changed, 35 insertions(+), 0 deletions(-)
>>  create mode 100755 t/t4130-apply-criss-cross-rename.sh
>>
>> diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-cri=
ss-cross-rename.sh
>> new file mode 100755
>> index 0000000..30187ff
>> --- /dev/null
>> +++ b/t/t4130-apply-criss-cross-rename.sh
>> @@ -0,0 +1,35 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git apply handling criss-cross rename patch.'
>> +. ./test-lib.sh
>> +
>> +create_file() {
>> +	for ((i=3D0; i<100; i++)); do
>
> Please don't; isn't this a bashism?

I've queued your two patches with minimum fix-up (not covering all the
points in my comments) to 'pu'.  You may want to take a look and send i=
n
improvement to replace them.

Thanks.

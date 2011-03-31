From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove "bashism" from
 contrib/thunderbird-patch-inline/appp.sh
Date: Thu, 31 Mar 2011 14:56:45 -0700
Message-ID: <7vvcyzhs2q.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
 <4D9103D3.5010403@zoho.com> <7vei5qtnc5.fsf@alter.siamese.dyndns.org>
 <4D9261AE.5070103@zoho.com>
 <AANLkTim+0gxGKZT=vfmX7v0QZrApjRwAzW3PiLePL-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?=C3=81ngel_Gonz?= =?utf-8?Q?=C3=A1lez?= 
	<ingenit@zoho.com>, Victor Engmark <victor.engmark@terreactive.ch>
To: Maxin john <maxin@maxinbjohn.info>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Prc-0007iF-H8
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 23:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758943Ab1CaV5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 17:57:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab1CaV5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 17:57:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C6025141;
	Thu, 31 Mar 2011 17:58:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=0KprmKoJYb/kZP64RckhFNv78
	WI=; b=m2dizEAqQRUX1419eSGpPy09NJz3X0D08KwGtZMWGP9mzQRjdyTsITHQW
	fm/pUpN6t67xw0ch2L+NkyD/4lqo+djtJuzxEyRIzanf6NN43D6CPgAqXrjnbtQe
	huPEZ7hSR80J0s9L9lUR08jyltfarkuKMD+UhmIHq5zGjNNAVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Ybf1lC27MhLCJvUrB+l
	C73t4UX0EYihhUp1VkzdJIWAbOOMhrf0udlYjq1DS2K4yivPabZmnL5p8+vtynvI
	jmkurKTHlk8SvkuR0X65E0AYXSwtST6G35KACCZmoCuyQI2YTyISn6DDEg+/StuY
	dtGAzajbM+cnQeC8sQj4/2mo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42BFA5140;
	Thu, 31 Mar 2011 17:58:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 03B6D513F; Thu, 31 Mar 2011
 17:58:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0ABA9EE0-5BE2-11E0-AFF4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170534>

Just for the record, the patch at the bottom is what I queued.

-- >8 --
=46rom: Maxin john <maxin@maxinbjohn.info>
Subject: [PATCH] contrib/thunderbird-patch-inline: do not require bash =
to run the script

The script does not have to be run under bash, but any POSIX compliant
shell would do, as it does not use any bash-isms.

It may be written under a different style than what is recommended in
Documentation/CodingGuidelines, but that is a different matter.

While at it, fix obvious typos in the comment.

Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/thunderbird-patch-inline/appp.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunder=
bird-patch-inline/appp.sh
index cc518f3..5eb4a51 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -1,8 +1,8 @@
-#!/bin/bash
+#!/bin/sh
 # Copyright 2008 Lukas Sandstr=C3=B6m <luksan@gmail.com>
 #
 # AppendPatch - A script to be used together with ExternalEditor
-# for Mozilla Thunderbird to properly include pathes inline i e-mails.
+# for Mozilla Thunderbird to properly include patches inline in e-mail=
s.
=20
 # ExternalEditor can be downloaded at http://globs.org/articles.php?ln=
g=3Den&pg=3D2
=20
--=20
1.7.4.2.422.g537d99

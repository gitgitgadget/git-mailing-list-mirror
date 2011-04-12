From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: document --quiet option
Date: Tue, 12 Apr 2011 12:52:22 -0700
Message-ID: <7v8vvfp7rd.fsf@alter.siamese.dyndns.org>
References: <1302622538-7535-1-git-send-email-cmn@elego.de>
 <4DA36D95.6060108@windriver.com> <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
 <1302623497-7658-1-git-send-email-cmn@elego.de>
 <7vfwpnp9uf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Apr 12 21:52:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9jdi-0001av-IE
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 21:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab1DLTwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 15:52:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab1DLTwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 15:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B37314016;
	Tue, 12 Apr 2011 15:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7N6ES+waGTyF
	9RQIzmiioRRTq2Q=; b=OM2OoRtJKuP2/rfnRptkHOQ/BaJFQoFiRA3FH+XL/vgR
	gbqKaLaSYaAM4xgle4ndSj7vQHAYmIHFPOqpPQnFkhbVhF4saxMR7ZhkGyem5wf2
	tq/SUdA/3HsZ3iINqU06h1J71Qwa9ws3cSDxeS594R7OQicdZPOT0NdZcssL7kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ef64yM
	oZv/kSMOq/TrddUqdrLkj1IyaQ/31N22bWJVcsCgCh16z58Xi/BDczCMLu3Z2ib9
	hXoivA/NeQZOHy8iwfaH+B3skuUi6tzwzOexoYF/yek7JcO88yvtOFkY/clFIMZE
	z5ex4QnAJlqybOzEKeyn1pCwcFuDQOjwyqWz8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 81BC64015;
	Tue, 12 Apr 2011 15:54:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 44B0E4014; Tue, 12 Apr 2011
 15:54:22 -0400 (EDT)
In-Reply-To: <7vfwpnp9uf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Apr 2011 12:07:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABB9047A-653E-11E0-83AD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171415>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -192,6 +192,9 @@ will want to ensure that threading is disabled f=
or `git send-email`.
>>  	filenames, use specified suffix.  A common alternative is
>>  	`--suffix=3D.txt`.  Leaving this empty will remove the `.patch`
>>  	suffix.
>> +
>> +--quiet::
>> +	Do not print the patch names to standard output.
>
> I see "filenames" in the context and that is "generated filenames".
> ...

Also the existing "Note that ..." that followed your added lines actual=
ly
belong to the description of the previous item.  Thusly....

-- >8 --
=46rom: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Subject: [PATCH] format-patch: document --quiet option

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index a5525e9..f4e959d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=3DSubject-Prefix]
 		   [--to=3D<email>] [--cc=3D<email>]
-		   [--cover-letter]
+		   [--cover-letter] [--quiet]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
=20
@@ -196,6 +196,9 @@ will want to ensure that threading is disabled for =
`git send-email`.
 Note that the leading character does not have to be a dot; for example=
,
 you can use `--suffix=3D-patch` to get `0001-description-of-my-change-=
patch`.
=20
+--quiet::
+	Do not print the names of the generated files to standard output.
+
 --no-binary::
 	Do not output contents of changes in binary files, instead
 	display a notice that those files changed.  Patches generated
--=20
1.7.5.rc1.16.g9db19

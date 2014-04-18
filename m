From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] i18n: Only extract comments marked by special tag
Date: Fri, 18 Apr 2014 10:48:08 -0700
Message-ID: <xmqqy4z2bkbr.fsf@gitster.dls.corp.google.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
	<2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
	<xmqqk3anesml.fsf@gitster.dls.corp.google.com>
	<CANYiYbGkjpdrzE25iRS33sm1=AodiREqWmJVkKVEok4mb4G5mQ@mail.gmail.com>
	<xmqqha5qd1hl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 19:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbCte-00033o-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbaDRRsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 13:48:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbaDRRsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 13:48:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB76679CA3;
	Fri, 18 Apr 2014 13:48:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8hcbaT1FTPNBD8oCar+Vx/+pnWs=; b=dNJ9BF
	SBDmhszRtmdFb8Qy5AzNtVYZxtdy1az2R8Rvd2g+lKh58ZgMjYMXm9z3Bu34KKIg
	7ztCQl10dNb5VgQbASdxLnVsfSrBM4MpstUBwrbC4bGKp/UmBijFZqlNGNtQfG1K
	HASzOiwgkVXLodRyjvs60x0a4kYVEkchvJOHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bRbewdtUgMR0gKj+0vSP1FElfXr5aYH+
	947Jab+KctnCK3uHIOAQy3wmKYPSOaZ85bytvtsZT9iKkWzvIAW1jbymp5j03Icg
	bNi/J9TLn3Yr8p42i5/Y6d9+S1bYbACf0IjoSBhRQ/95wHJewXnpfZGfW8nDVV9O
	BVgltOhC6dE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F88679CA2;
	Fri, 18 Apr 2014 13:48:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19FDA79CA1;
	Fri, 18 Apr 2014 13:48:10 -0400 (EDT)
In-Reply-To: <xmqqha5qd1hl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 18 Apr 2014 09:52:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9B1D59AC-C721-11E3-844E-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246478>

Junio C Hamano <gitster@pobox.com> writes:

> Documentation/CodingGuidelines may want to have a sentence of two to
> explain this, though.

After re-reading what I sent out, I realized that the way I singled
out multi-line comments was misleading.  Here is an updated version.

-- >8 --
Subject: [PATCH] i18n: mention "TRANSLATORS:" marker in Documentation/CodingGuidelines

These comments have to have "TRANSLATORS: " at the very beginning
and have to deviate from the usual multi-line comment formatting
convention.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index dab5c61..f9b8bff 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -164,6 +164,16 @@ For C programs:
 	 * multi-line comment.
 	 */
 
+   Note however that a comment that explains a translatable string to
+   translators uses a convention of starting with a magic token
+   "TRANSLATORS: " immediately after the opening delimiter, even when
+   it spans multiple lines.  We do not add an asterisk at the beginning
+   of each line, either.  E.g.
+
+	/* TRANSLATORS: here is a comment that explains the string
+	   to be translated, that follows immediately after it */
+	_("Here is a translatable string explained by the above.");
+
  - Double negation is often harder to understand than no negation
    at all.
 
-- 
1.9.2-651-g78816bc

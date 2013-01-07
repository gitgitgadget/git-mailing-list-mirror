From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 07 Jan 2013 08:53:35 -0800
Message-ID: <7v8v85j5o0.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org>
 <7vtxr1bg4g.fsf@alter.siamese.dyndns.org>
 <CAPYzjrT_8g26y-QrYvbQYoySWskGdn15jCX60rz04wQFQ2ikVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: =?utf-8?Q?=E9=83=91=E6=96=87=E8=BE=89=28Techlive_Zheng=29?= 
	<techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsFxX-0005JL-GE
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 17:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab3AGQxk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 11:53:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab3AGQxj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 11:53:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 911E7BAF1;
	Mon,  7 Jan 2013 11:53:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=238zldblGkaB
	csqvc32l40Lcgmc=; b=dI/dawKdcqyOLGMsiig2ajk8SkfQDV3K0bDiN36sRwhm
	MAe+iruhsfh/mymkrhCTbZ1RD41YjkNbZcN/jAovAZzUXbHraSNi0ItbbBpQUy1L
	8hlwBDIqUlmMu1GRrziUXj6TRRcmnDGokTxFHnlFr/u/Pk2mZu+B5sFrKQNjch8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LptK/7
	qR0QT9aaVtj9qcEp2XgjDLMg7RCIl/4MKX2J7yQ0c/qrfU4NV9DUq52qqVb00ap3
	MGK67ZzNpz/UwUVs45X33Ti28VvUejh3jg7StCUAZptneGeDK9tUU8HaZalxNz2O
	HVMt0fBkRdMWmn8QQUM7qnsQ4sUzreeTe/uwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B073BAF0;
	Mon,  7 Jan 2013 11:53:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF90ABAEF; Mon,  7 Jan 2013
 11:53:37 -0500 (EST)
In-Reply-To: <CAPYzjrT_8g26y-QrYvbQYoySWskGdn15jCX60rz04wQFQ2ikVw@mail.gmail.com>
 (=?utf-8?B?IumDkeaWh+i+iShUZWNobGl2ZQ==?= Zheng)"'s message of "Mon, 7 Jan
 2013 23:18:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C82DD878-58EA-11E2-9C89-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212904>

"=E9=83=91=E6=96=87=E8=BE=89(Techlive Zheng)"  <techlivezheng@gmail.com=
> writes:

> Though, this patch defintely should be merged, becuase no one expects
> his commit message be altered durging the splitting process.

Are you saying that after double-checking what was posted?  It said
something like this below, which does not look like 'definitely
should be' to me.

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
index 920c664..f2b6d4a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,7 +296,12 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
+	# Use %B rather than %s%n%n%b to handle the special case of a
+	# commit that only has a subject line.  We don't want to
+	# introduce a newline after the subject, causing generation of
+	# a new hash.
 	git log -1 --pretty=3Dformat:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b'=
 "$1" |
+#	git log -1 --pretty=3Dformat:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1"=
 |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL

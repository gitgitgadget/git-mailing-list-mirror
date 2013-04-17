From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Wed, 17 Apr 2013 16:02:08 -0700
Message-ID: <7v4nf4ep73.fsf@alter.siamese.dyndns.org>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
	<1906942.3yyCMUNxTB@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, trast@student.ethz.ch,
	jk@jk.gs, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Thu Apr 18 01:02:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USbMo-0000PN-0B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 01:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966994Ab3DQXCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 19:02:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966936Ab3DQXCM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 19:02:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4C51771F;
	Wed, 17 Apr 2013 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qMwOnBTpB8Vd
	6H4eY2w+lKSrQqg=; b=PrQyui4t95bWW+C5BFLhLC1P+8T/tSCvUT82v+Bcf+S4
	/Ki64dx6hKva6RkC/Y8KZijnVQnui4pYazK8P6wSHrUT7ijT23+CIJzodrEgMBwc
	QwNzQsAzirLnZRCYQjYUAzpLU6e3N6n6XM61qiISTsthc6cwzRo4+bXY4Sgl+a8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pxNQQn
	ZodkMIetrMPSwxCvAUNHCaHMSfkRitx8mXU7oIOCTIU//f8VUxgQSmupr37Q2t2E
	A0tLbDSnWP1uKiZvcWTuGdzzbDny9w2ql6b+hSC3sLZrBHc7M8mAHZAwMkjcZGtn
	BnlRXoAfdrK16YQX7hdkoRpxd4XLgOwhISkBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D27021771E;
	Wed, 17 Apr 2013 23:02:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C9981771C;
	Wed, 17 Apr 2013 23:02:10 +0000 (UTC)
In-Reply-To: <1906942.3yyCMUNxTB@cs-pc> (Christian Stimming's message of "Mon,
	15 Apr 2013 21:26:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D581FC0E-A7B2-11E2-8230-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221583>

Christian Stimming <stimming@tuhh.de> writes:

> Thanks for the regular update! This is great work.
>
> One issue with the plural form messages, though:
>
> Am Montag, 15. April 2013, 18:27:40 schrieb Ralf Thielow:
>>  #: bundle.c:186
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "The bundle contains this ref:"
>>  msgid_plural "The bundle contains these %d refs:"
>> -msgstr[0] "Das Paket enth=C3=A4lt %d Referenz"
>> -msgstr[1] "Das Paket enth=C3=A4lt %d Referenzen"
>> +msgstr[0] "Das Paket enth=C3=A4lt diese Referenz:"
>> +msgstr[1] "Das Paket enth=C3=A4lt diese %d Referenzen:"
>
> The msgstr[0] must still contain a %d conversion specifier (which wil=
l be=20
> filled with the number 1) even though the translated sentence wouldn'=
t need=20
> the 1 anymore. The previous msgstr[0] was correct; the English singul=
ar msgid=20
> is not.
>
> Technical background: The ngettext function chooses only the string i=
tself,=20
> which will then be fed to printf() as a second step. If the printf se=
es more=20
> variadic arguments than conversion specifiers in the string, it will =
be=20
> unhappy. At least that's what I remembered about the ngettext things.=
=2E.
>
> http://www.gnu.org/software/libc/manual/html_node/Advanced-gettext-
> functions.html

This vaguely sounds familiar:

  http://thread.gmane.org/gmane.comp.version-control.git/218173
  http://www.gnu.org/software/gettext/manual/gettext.html#Plural-forms

In the English singular case, the number =E2=80=93 always 1 =E2=80=93 c=
an be
replaced with "one":

          printf (ngettext ("One file removed", "%d files removed", n),=
 n);

This works because the =E2=80=98printf=E2=80=99 function discards exces=
s arguments
that are not consumed by the format string.

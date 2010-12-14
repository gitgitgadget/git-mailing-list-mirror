From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #04; Mon, 13)
Date: Mon, 13 Dec 2010 18:20:44 -0800
Message-ID: <7vzks9umbn.fsf@alter.siamese.dyndns.org>
References: <7v7hfe5awz.fsf@alter.siamese.dyndns.org>
 <AANLkTikGneq+zeN5Z5XrUseX4Arevft67U7pV+h+5Tr+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:21:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKVe-0005iO-NE
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117Ab0LNCUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 21:20:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759112Ab0LNCUx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 21:20:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE51132F4;
	Mon, 13 Dec 2010 21:21:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7yqWpj/xWftttyuOzFNcWjF7g
	eE=; b=QGopQRJmq2hEIO//WFM2Ui8CWKTX69js1NIeamTMKE2EodamA36nIyXnN
	aqKHTwFbdQK4SQeRKadH4loel5YsQWfiNZanX3YSVSWghlQeF029f/lRPCnRVB3a
	a3rB6nz6KZ57j1T2wOojxLpqtCK1rLEWnm0hBoTEjSdGLKwGVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Nx97G3s71KGI0fsWKms
	NZV6d5ZiwEjrnQNntz7IOgSyZXuHwnThpsBnHo6JLI7D59cmjm7+z7l4oWov33It
	jw4qGHzRSaRcbdNFwAHVHBQc0vkd6YQVSzV2cFogeVuJkQyIppHS+ztejKbcMceP
	Wx7SXq8SPzEx0mP56nHdEVwg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C42C32F3;
	Mon, 13 Dec 2010 21:21:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B6FB732F2; Mon, 13 Dec 2010
 21:21:11 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D34951EE-0728-11E0-84B0-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163622>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Dec 13, 2010 at 09:34, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> Needs a bit more minor work to get the basic code structure right.
>
> And I'm still not sure (see earlier replies to "What's Cooking" posts=
)
> what needs to be done to make it better.

One open question was why you do not want to move 'LIB_OBJS +=3D gettex=
t.o'
away from the LIB_OBJS section down to the configuration evaluation
section, i.e., why gettext.o would be different from block-sha1/sha1.o.

(sorry for a delayed and short response --- have been firefighting
elsewhere).

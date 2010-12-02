From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 02 Dec 2010 09:46:23 -0800
Message-ID: <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODEv-0005JO-0o
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675Ab0LBRqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 12:46:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757303Ab0LBRqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 12:46:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C1BC93ADE;
	Thu,  2 Dec 2010 12:46:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5wUmHJbqMN7n
	BZuMHqa5ijAae64=; b=PKgvtiJTRzPPSa9wUzmfIfJug5esjL/Pt5fr6qpsf92I
	ymVwqR+p4pTLja/t6Jv+PrEuvPsFmv62wBZbmmZWDzq1ubXDdvT+Z/jbl6joTvAY
	+SKqtt6prHWNuBcUdG8/EFG5lJuvtFroxvA5MSATUVtCWHFGSaNiaDGI/4p3+zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=duTMku
	EdfW6B5CCt0B7QDiA5o1c39nFq59enacdNzVOE3xiI4bU8y9w5S68LRSZ0OqMLe2
	vWvDy0Z4cWaC0W8S+dJUlKg4oY+0vKGgiWS41Jf1SeDTNbVBJaCQREtQi6VgNE2U
	g2OHxIIG0ppsCxORZtIF1sIQ4rZ9WcLLXXQiI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E9F23ADD;
	Thu,  2 Dec 2010 12:46:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A03B3ADB; Thu,  2 Dec 2010
 12:46:46 -0500 (EST)
In-Reply-To: <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 2 Dec
 2010 14\:23\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2454D6E4-FE3C-11DF-937D-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162717>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
>> I am trying to use perl's Git.pm module, but for some reason, it kee=
ps
>> bailing out:
>
> Why are you using it? It's for internal use only.

That is not a valid question nor answer, I am afraid.

It probably is showing that perl/Git.pm is underdocumented.  We should
make it possible if not trivial for people who want to write the next
great git-svn.perl or whatever that uses the module to interact with th=
e
repository.

I don't understand why the Josef's scriptlet passes Directory to the
initialization code.  Is it working with a bare repository?

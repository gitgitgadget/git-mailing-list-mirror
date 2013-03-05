From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Tue, 05 Mar 2013 08:52:16 -0800
Message-ID: <7v4ngpvlfj.fsf@alter.siamese.dyndns.org>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
 <7v8v61vn3h.fsf@alter.siamese.dyndns.org>
 <CACBZZX5=ARahxswkN_mLbBF3fQxV-HtKgehe_3ogHg5-i7utYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCv6c-00076l-0v
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab3CEQwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 11:52:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab3CEQwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 11:52:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D56AA18B;
	Tue,  5 Mar 2013 11:52:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QqcS/Sa47j/6
	f5bmDl5rqVQTzNQ=; b=hq2kUDgueJqzmr7cksfWDswyJHQTj2bmNOhvESDsz5V+
	AKdONtNR+YQSYcsgB7UlDjh/eJ58YGdh/g0Vn1H3Fe8ogRp1URdDinHSgyx1xr3e
	I0aqs3T0s/0pZUNxCYNcExd0W5RWHjXxR2TxaYS97t1o605qJf90mP9c8Alk+PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CHw9t7
	o5oYcLwYcylNBYQ7oaIEcgz9icA3lnP/4+FVKkLainy+mbkKccqEvvekhw8QObVU
	VAj682fgsij9wsN9X8dhiDUf/8fXbCxVKOOz7xN4ymEgtTkCFl64ShYcTR+X6H96
	w3U1h0lRfQ63nWDaSXsOAIlKjS/bCDIBSbgqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51423A18A;
	Tue,  5 Mar 2013 11:52:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A849BA186; Tue,  5 Mar 2013
 11:52:17 -0500 (EST)
In-Reply-To: <CACBZZX5=ARahxswkN_mLbBF3fQxV-HtKgehe_3ogHg5-i7utYw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Mar
 2013 17:32:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09F26C1E-85B5-11E2-A141-099C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217463>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> No objection to the patch in principle though? I.e. not showing you
> what the alias points to.

I am not interested enough to even strongly object to such a change,
because it is not reasonable to react with a "I know!" to the output
of "git co --help", i.e. "'git co' is aliased to 'checkout'", in the
first place.  Also some users may find it inconsistent if a single
bareword jumps directly to the manpage and other input shows alias
expansion.

So,... I do not see a very big plus in the proposed (and then
amended by others in the thread) change, but if the damage to the
code that is necessary to implement it is not too bad, perhaps it is
an OK thing to do.  I don't know without seeing the patch.

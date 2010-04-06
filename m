From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Tue, 06 Apr 2010 10:26:28 -0700
Message-ID: <7vochwijaz.fsf@alter.siamese.dyndns.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <m2md411cc4a1004052157v200f902ek22420456e4a45512@mail.gmail.com>
 <7v1vetkt8i.fsf@alter.siamese.dyndns.org>
 <u2hd411cc4a1004060652k5a7f8ea4l67a9b079963f4dc4@mail.gmail.com>
 <v2wd411cc4a1004060653nd8d8e924t92183c55543e8294@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 19:26:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzCY1-0005MH-Kl
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 19:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab0DFR0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 13:26:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0DFR0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 13:26:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B9E2A8179;
	Tue,  6 Apr 2010 13:26:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AzCs9TotJW9h
	rnndoDTEhLZeLiA=; b=HCqus0tiOhAidaULE81VZvf580idrehvSQr9qSvZAZoj
	I82ReZYhuE3LxKhVkSAYZPe3whQ1KkQnaS/rxu7fM9QicU5Eus19yyMBP56wN3aw
	YjVR0ddgtspmS/Ygg5WoFtdX0BA4adb5mzSATJ8JMhLtAyku54y2widriY6z49A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q2swSk
	Sn3KOSYwlTkxUKcBArNM4xNI8K2pUKehYWaV6Yy3zHqlfDPwWlkc+ZvsuH5dhAfg
	CQYqEoR7jboQFdPHB54Bn+U/2MPmVDgB3ikr4OklrObCcyIHTLm/4ba0DofBtoPG
	WivsGuBf3JmkLnnNdEmWEzvg0mjWnK8wWCM9Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67AEAA8178;
	Tue,  6 Apr 2010 13:26:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA159A8177; Tue,  6 Apr
 2010 13:26:30 -0400 (EDT)
In-Reply-To: <v2wd411cc4a1004060653nd8d8e924t92183c55543e8294@mail.gmail.com>
 (Scott Chacon's message of "Tue\, 6 Apr 2010 06\:53\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C4E3F5E-41A1-11DF-8377-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144159>

Scott Chacon <schacon@gmail.com> writes:

> I understand, it wasn't meant as a criticism, I was just curious why
> this file was never included. =C2=A0That the series was marked as RFC=
 makes
> sense. =C2=A0Could I request that this one patch be included? =C2=A0O=
r if Shawn
> has a more recent one?

I also understand and I didn't mean to sound as if I took offense.  I v=
ery
much appreciate reminders like yours of old discussions and patches tha=
t
were basically good but did not reach conclusion at the end to avoid
wasted effort.

A pointer is good, but if you are reviving an old patch, it would be
much easier if you did a resend/forward for people to comment in-line,
by the way.

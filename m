From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 02 Dec 2013 13:09:03 -0800
Message-ID: <xmqqbo0zq7tc.fsf@gitster.dls.corp.google.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
	<CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
	<1385985997.2054.27.camel@localhost.localdomain>
	<xmqq61r7rua0.fsf@gitster.dls.corp.google.com>
	<CANQwDwe827gsq4pP_XN_ZUSxTJhZupijuVK0gwVJToNcEXDueg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>, sunshine <sunshine@sunshineco.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 22:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnakw-0005sJ-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 22:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab3LBVKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 16:10:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab3LBVJI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 16:09:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E04DA582A8;
	Mon,  2 Dec 2013 16:09:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IW4cPUn+XM1V
	2TT0pLzdTOmIoR8=; b=i1/4nsNaG/hW2MPwhi62DR0oneDl5WfWXBtuyt0esmCN
	AeGEIXxbsDc3z5UfflReuA1uLkPhrjB+f48CaY/GXzI8LSKvx1LQJLZzu5nKXSlQ
	wVJX037X167vSYLJ0vDGStuui2Ntiak0XgQQbT4yCA2gj9J7FUwniy5gedsbo/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cwTTmE
	i0nN8FhpzLbo28XMDl+VIAYTQbffJp4DVeCYkA+ggbn7cUjtaGQUkpOb9psyeyJN
	ex60cOwaAGXNReL3WiaFhYXk00S5s7dn85PlA/kT9fWNxPoxDFZ4pWGqvvRc/946
	yg8Wlm6biku3xSZ4RS28z2xPEg8TxlKx+gEIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D071F582A7;
	Mon,  2 Dec 2013 16:09:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15366582A6;
	Mon,  2 Dec 2013 16:09:07 -0500 (EST)
In-Reply-To: <CANQwDwe827gsq4pP_XN_ZUSxTJhZupijuVK0gwVJToNcEXDueg@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Mon, 2 Dec 2013 19:25:07
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB059CDC-5B95-11E3-A36F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238654>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I think that additional-branch-refs (or just branch-refs) is differen=
t enough
> from remote_heads feature (which is about showing "remotes" section
> in "summary" view, and IIRC adding "remotes" view) that it should be
> kept separate.
>
> On the other hand it is similar enough that I think style of implemen=
tation
> should also be similar, i.e. use %feature hash.

Sounds sensible.  Thanks.

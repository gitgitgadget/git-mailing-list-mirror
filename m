From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Fri, 06 May 2016 10:17:08 -0700
Message-ID: <xmqqwpn73y3v.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	<xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605061658580.2963@virtualbox>
	<xmqqh9eb5eo0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 06 19:17:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjNM-0007tZ-63
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419AbcEFRRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 13:17:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757735AbcEFRRL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 13:17:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 131FF173E7;
	Fri,  6 May 2016 13:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3+pzINVWGLoiMRG4xZlUh/QloNE=; b=AQYsli
	HDNrG7H+naZ/gv2nQlHMHIW5YZdoO2jWjfPX/fsAOUaITYZ53LYM0UwkfoDSIGVa
	rG0OSBJ/aOfzR40TWqh80dx0i+Vn3xybCCQFFG/yiPKI6vIraBHd9gw3BR3kZKj/
	2EmfGZuxjP8TPPxytgsg3gt92ML+kObFoZYbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+62rKnAFZ05++WlUgIzIdBmBEC9VJK8
	rwbXNljDdbv2gRoNmzRn9nVyt4abaJNsdgM9HuSuF4mTnpD92+dl5LZwMGmG+QmB
	ZZNp/tsRsJd5Xp7Ero1WG0eq3b+gFzq92SY9mWL6nR+co56KNDtLNS5GsbjyawRb
	SMWVFLc6CVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A4DA173E6;
	Fri,  6 May 2016 13:17:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FEDE173E5;
	Fri,  6 May 2016 13:17:09 -0400 (EDT)
In-Reply-To: <xmqqh9eb5eo0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 May 2016 09:34:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D814622-13AE-11E6-A8F3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293836>

Junio C Hamano <gitster@pobox.com> writes:

> If you are sure we do not need that, that is one less reason we
> would be better off without mark_as_git_dir().

Oops.  To many rounds of rewriting followed by a rather careless
final round of reading.  I couldn't decide between "That is one less
reason why we need it" and "That is one more reason why we are
better off without it".

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 00:57:00 -0800
Message-ID: <7vk42rzfab.fsf@alter.siamese.dyndns.org>
References: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: suvayu ali <fatkasuvayu+linux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 09:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6eat-0004WC-KR
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 09:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2CKI5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 04:57:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab2CKI5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 04:57:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8118598E;
	Sun, 11 Mar 2012 04:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cvgGsQFv/VgZME6MSfIzjRUDMiQ=; b=IzhsKg
	PDbSJUkiivQ6/TMj9Tv89NGJJgJeuJ4MDBeE1rlgCkpldw79B/tqV5wN2XPkmKLz
	GDF47n9hTkftNe0zS+IWPk78N+FxnT0xcoAWlt4ycNQGUXU1egzWqX1xmLuACWM+
	S9g65V5yxvXgFpveAuh9QCceDvDNzNr1gEo3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1raElrPrr9vtS0IH14KpygmYzspCBhn
	KxhLcS9SforshOjJ/N4nGR223YFTJeCIzrOiwWwECAb0BszmH0LvfZ4o0wVC5/2G
	mB2lK89RRxQqRL29ymfL6Mt77ZEmKmw1dEvqUCbxbp+f69UYIAxCWqNcyCu8LVzY
	KJi8gL14ozU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE725598D;
	Sun, 11 Mar 2012 04:57:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42116598C; Sun, 11 Mar 2012
 04:57:02 -0400 (EDT)
In-Reply-To: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com> (suvayu
 ali's message of "Sun, 11 Mar 2012 00:47:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B22ABCE-6B58-11E1-AFDC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192798>

suvayu ali <fatkasuvayu+linux@gmail.com> writes:

> ... So when I came across
> the possibility of using .gitattributes for file specific merge
> strategies, I tried the following:
>
> pattern merge=ours

I do not think we say .gitattributes can give merge strategy
anywhere in our document.

You can choose one of the few built-in merge drivers but "ours" is
not one of them.  Have you defined your own merge driver "ours"
following the example in the gitattributes documentation (look for
"feel-free merge driver")?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! git-remote-mediawiki: New git bin-wrapper for developement
Date: Mon, 08 Jul 2013 08:56:42 -0700
Message-ID: <7vr4f911vp.fsf@alter.siamese.dyndns.org>
References: <CAETqRCh0_gc_MqN5eXLn_guCELYKgfHdN3986d9WPubxUFeLqQ@mail.gmail.com>
	<1373290241-10517-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	celestin.matte@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDo4-0005f9-IV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab3GHP4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:56:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab3GHP4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:56:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967FF2CFA5;
	Mon,  8 Jul 2013 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvSk+WkSoClj7A7NtDEpfqUeZIA=; b=p5QFPd
	ZoZbYoQpIe1nUv3UDpljjFfH/QYssBlifL6G0ZiB5lC6PGDWc0qAweLFJR7mkT0/
	3LOiLXQrtZFfWqnkhgric/FEbDlqzL5GN4lIWTz1KgAOC6FjPsZewyfdjwnS6iig
	s/hK0w5ZbP4urLVZnJ5QUPOFvsmoeNZeNjca4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Np1gLMZbZgkY8ZAeroZ1B+QB4p0rjT98
	l/jdookqJHuMDVFCPodYzjsbDjZxEUqJNekCU3v9t5jTDhADWZZu31X2HkMQM9gF
	vwq2ki4qUd6oKCnOCosi+FXU6gVdU6t2Z2dDI7sp8adRCLrHLBEDeePI7unqottN
	Jjrvin7P1+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B7A2CFA4;
	Mon,  8 Jul 2013 15:56:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08AD92CFA3;
	Mon,  8 Jul 2013 15:56:43 +0000 (UTC)
In-Reply-To: <1373290241-10517-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 8 Jul 2013 15:30:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC93C1A0-E7E6-11E2-8E0E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229871>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> > The colon after "make" and the indentation look weird. Shouldn't this be
>> >
>> > +# To build and test:
>> > +#
>> > +#   make
>> > +#   bin-wrapper/git mw preview Some_page.mw
>> > +#   bin-wrapper/git clone mediawiki::http://example.com/wiki/
>> > +#
>> >
>> > ?
>> 
>> oops, yes definitely.
>
> Junio, can you apply this fixup to bp/mediawiki-preview?

Will do; thanks.

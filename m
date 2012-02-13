From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Setting up a Git server (+ gitweb) with .htaccess files HOWTO
Date: Mon, 13 Feb 2012 11:10:56 -0800
Message-ID: <7v1upyft1b.fsf@alter.siamese.dyndns.org>
References: <vpqbop266ak.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx1In-0001XY-0a
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab2BMTK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 14:10:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207Ab2BMTK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 14:10:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 076A27617;
	Mon, 13 Feb 2012 14:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+uzQeHS4FXa7j7b+T45GGucFdIM=; b=UWcv/e
	JbMKHtV91g3zRZCxf1Fmp/9UVuhN8b9Hl5WT7H+clksAXw3Qf4wolixNU3hBIqRN
	Zjmx6udnuRn2sZFnSq04Ajk4BR1pWReZ6d7XzTTu7nAO1aFWZ7Pbxz3tiZ3+/6qR
	jKHBKmOKMrlbmf1HylTprRYnUVaVY2iSWLDGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gzdnlpE4PN3HF3EjjqEYJfoZA1t+WSed
	svTDKJgEFh/A5lX7k28TR0q5u+A4O9LNZDeY7RUiBWAD1PSCic9NsMaacZqN+4Mk
	FlSoYkckbhCRDFmi4e7KzBiQCIWNRMEGnAQwnkYmurxrXOyNFHUxRqjLgk3e2TCO
	/tsAfez/HBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE4C37616;
	Mon, 13 Feb 2012 14:10:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82FD77614; Mon, 13 Feb 2012
 14:10:57 -0500 (EST)
In-Reply-To: <vpqbop266ak.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 13 Feb 2012 17:34:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 758333EC-5676-11E1-96F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190650>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I've set up a Git server on a machine on which I have a webspace,
> permission to run CGI scripts, but no shell or root access. Good news:
> it worked :-).
>
> I've documented the process here in case anyone's interested:
>
>   http://www-verimag.imag.fr/~moy/?Host-a-Git-repository-over-HTTP-S

After seeing the section that runs "git init" in a throw-away CGI script,
I started wondering what the point of this site in forbidding a shell
access in the first place.

After all, if you changed that example with a script that feeds its input
to a shell, you would have enough "shell access" to do anything you need.

So...

Well, my reaction at this point was "why bother?", but then I realized
that that reaction is meant for the administrator of that hosting site,
not a user of that site, i.e. you.

Thanks for an amusing read, anyway.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git with uucp for deployment
Date: Fri, 06 Jul 2012 13:02:35 -0700
Message-ID: <7v3954odyc.fsf@alter.siamese.dyndns.org>
References: <jt5crg$ku1$1@dough.gmane.org>
 <863954ai7l.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri Jul 06 22:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEjj-00056o-RD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 22:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab2GFUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 16:02:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab2GFUCi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 16:02:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA78A96D7;
	Fri,  6 Jul 2012 16:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=68yvKA9HVefu50J7ZwZFbL7KdqQ=; b=jTImgo
	iyjP8FSNcQenTkZPI4ZpqUmYAjwfJW+7WW7F326spOFtWT1WlYaFfwvVVlQbeItZ
	2YjH+TU+6F0DI31GC6tY+CjTUvSB4X7ax71T42AWVUfb+gqgJxmGck105wXUXISl
	1p27z+SyQycH02WezrMUnCAUJjF2A25Q5Ebl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yZ/fGqdJs7i8JNZokdDLPxQGxbH9xu3V
	GgVXbl+poS8xui4pW6w8Q6yLY0ndYib2HPxVM+kMu3neZ5OI0usCB2laCc7X7MXD
	naMZbt8bhi5U6eoatuFhW3djVz7afWKVSpY7Rkg9FDDXgXa6Hd44rfhhIBfcP8Ai
	8HJt6TqIkXw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD3396D6;
	Fri,  6 Jul 2012 16:02:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 453E196D5; Fri,  6 Jul 2012
 16:02:37 -0400 (EDT)
In-Reply-To: <863954ai7l.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Fri, 06 Jul 2012 10:54:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8896F900-C7A5-11E1-B491-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201146>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Neal" == Neal Kreitzinger <nkreitzinger@gmail.com> writes:
>
> Neal> Does anyone use git with uucp to deploy software?
>
> Isn't there a gap of about two decades between those two things? :)

Are you suggesting us to get rid of use of Perl from Git, or C for
that matter?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Fri, 15 Jun 2012 11:13:39 -0700
Message-ID: <7v62asbfzg.fsf@alter.siamese.dyndns.org>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
 <1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
 <CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
 <CANYiYbFx=Z7TTYUbAhzgHFYB6O_grROWoWHbtuhuABeXdFk4-Q@mail.gmail.com>
 <7vpq9ft3ls.fsf@alter.siamese.dyndns.org>
 <CANYiYbGnoZDMkOq-goaPO98L4Ar1HzMVS-JjjBz7rNHVgv4ywQ@mail.gmail.com>
 <20120615174149.GG10752@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:13:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfb1m-00054t-GK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab2FOSNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56199 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab2FOSNl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:13:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 082AB8D3F;
	Fri, 15 Jun 2012 14:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T1S4eLJqwvsE350AVFKiUINWpTk=; b=fNyy+o
	vJ3z+YNKR13Te/OrIVfHrExSUeJqrV17xHHHgGA9E0AaP13JTsHf/ogbP2cO0GOu
	dX3QFCAg5elG4ZWexS6nFmze5AJ/lgmfUMZ/X9F/bK+NtDZQT3CAv1fXi6RjdOKp
	ucRMTfVquAJ1peGgE+g1SAxXLNR54oUWE/7a0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FYvNoqwm9eky+yDs+kdGbxHtbKexKXtd
	cLEbq33S1NZ9d9n1lN3odWZGnmuM/Sxbh8aIquVKzWjsRmE2CCIF9k+kRtty8/CR
	S+YATKks2ogbbsWbMGB4REKcxLgL6ekl5KY5ToWCkf9xk7yvjAtrG4026RO3APaW
	e4XayHEh9Pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B968D3E;
	Fri, 15 Jun 2012 14:13:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F6728D3D; Fri, 15 Jun 2012
 14:13:40 -0400 (EDT)
In-Reply-To: <20120615174149.GG10752@burratino> (Jonathan Nieder's message of
 "Fri, 15 Jun 2012 12:41:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5B661C6-B715-11E1-B009-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200074>

Jonathan Nieder <jrnieder@gmail.com> writes:

> For what it's worth that does seem to me like the most sensible
> workaround in the short term. :/
>
> 	gittext () {	# or sane_gettext or literal_gettext or something
> 		gettext -- "$1"
> 	}
>
> 	gittextln () {
> 		gettext -- "$1"
> 		echo
> 	}
>
> Thanks,
> Jonathan

Thanks for rephrasing ;-)  That "g*I*ttext" looks a bit too cute for
my taste, but something along that line does seem to be a reasonable
way forward.

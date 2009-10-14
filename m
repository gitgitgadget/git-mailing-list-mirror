From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Wed, 14 Oct 2009 12:10:11 -0700
Message-ID: <7vzl7tdc6k.fsf@alter.siamese.dyndns.org>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
 <4AD32024.6020005@drmicha.warpmail.net>
 <94a0d4530910121009r52d45522jf1c27dd102db4ad9@mail.gmail.com>
 <4AD42A1C.1080709@drmicha.warpmail.net>
 <94a0d4530910140726i4465e919h77045904aa33c61a@mail.gmail.com>
 <4AD5F7BE.9000704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 21:12:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My9H3-0006vz-HH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 21:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbZJNTLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZJNTLI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 15:11:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZJNTLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 15:11:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3E558634;
	Wed, 14 Oct 2009 15:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DFzNpIDW9d5gvuSeXO1kE7JJwf0=; b=isGOUH
	lJQkec2tBSosqF8bC/sUto5pBvNT+O+H++MNXfYgGYC9O22+/nfNfYPH0S556g3n
	fHtRXHIctcS9HaIHSu/VxiHeblUCaj6drK6zYFLZwQcN80fwJZP6FM3ksv1oGkPV
	Ij8nxXxHkr+BhQCCo1uZ4yUtvTOJ0laB9Y7aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfofVHAdJu34DuxWecMLEJqU70YB6cpZ
	lu/UyLLfSYa703m/HvcLxrGBdyiEukR9/ZUaXG3ssaG7BAKN2VSrTrmO+b5P5A+i
	6ucoD9gPTKUJjQxCkcd+8PryIMO3rifcF1zIw6n77skER9Qb/+4d8J6tgf7oNYgq
	lTsLRddWxEU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F061B5862E;
	Wed, 14 Oct 2009 15:10:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E807858624; Wed, 14 Oct
 2009 15:10:12 -0400 (EDT)
In-Reply-To: <4AD5F7BE.9000704@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 14 Oct 2009 18\:09\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 368F955C-B8F5-11DE-A568-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130325>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Well, Junio certainly is authoritative, and I don't want to risk any bad

Even though I usually call them "configuration variables", I do not
consider myself authoritative in this particular issue, as I did not care
about the wording myself that much.  It is not like we have two (or three)
distinct concepts that the user need to be aware of among configuration
variable/option(/setting).  In other words, I never thought consistently
sticking to one variant matters that much for this particular case, and
I've used the word very casually and interchangeably, but except in one
specific context---see below.

I am open to be corrected by Documentation/glossary.txt and other sources.

> 2d2465c (Add documentation for git-config-set, 2005-11-17)
>
> is the origin of that doc for git-config. I'm not just claiming it
> myself. That commit introduced "option", uses it in all but one place,
> and this never changed since then! [The ratio went up from 6:1 to 40:5]
> I have no objection to changing this established notion, but established
> it is. I haven't tracked down the use of option vs. variable in other
> places than git-config.txt and its predecessors.

I am Ok with calling them "configuration options", and I am also Ok with
calling them just "options" when it is clear from the context that we are
talking about configuration file.

The _only_ thing I deliberately do is to avoid calling them configuration
"options" when discussing "command line options override what you have in
the configuration file", but even there I would use "settings" and
"variables" interchangeably.  E.g. both of these are fine with me:

    The settings in your .git/config file will give the default when there
    is no command line option given.

vs

    The variables in your .git/config file will give the default when
    there is no command line option given.

but personally I think it would make it less easier to follow if you
changed these "settings/variables" to "options".

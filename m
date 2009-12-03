From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git documentation consistency
Date: Wed, 02 Dec 2009 17:34:01 -0800
Message-ID: <7vaay096ye.fsf@alter.siamese.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com>
 <20091129051427.GA6104@coredump.intra.peff.net>
 <m1NFAji-000kn2C@most.weird.com>
 <20091202200904.GA7631@coredump.intra.peff.net>
 <m1NG0O6-000kmgC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: The Git Mailing List <git@vger.kernel.org>
To: "Greg A. Woods" <woods@planix.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 02:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG0aF-0001Dk-Vu
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 02:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZLCBeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 20:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZLCBeD
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 20:34:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZLCBeC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 20:34:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 601ABA372D;
	Wed,  2 Dec 2009 20:34:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MwOo0np9XGstSBOhMzrllxWkBKM=; b=h4jcnS
	BoSIyd+zwWqKzP/6DitkxqNXb/kun0Bl6ovyLIr8rxo7HzWzkGAUZk4lYUZD5aXo
	XqPh+tlcvqUqm8xlw5JNI84mYKYtwYK6Vm7iegp7PQc8McSU6ghLHbcXVPNI/LUa
	XKD4DtYc7rOKbLz2J+N445/q76/n76KwJblqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqvbjBQps410FODWB/cm5F3KvsLG4QKK
	/4Vbn7YSpg0njJaEOCEOm/KhpfxYnw6ZrMD2Ju/Vws0SN/AboWflbODWFBGhaZhE
	5zPAbqPFUsRqiG23smo82g54eHmi55IFtwhXUimIcg0cQ1sfRrK2ok7N0HWJIU3M
	g95AFk2fwzg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F057A372C;
	Wed,  2 Dec 2009 20:34:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 318E1A372A; Wed,  2 Dec 2009
 20:34:02 -0500 (EST)
In-Reply-To: <m1NG0O6-000kmgC@most.weird.com> (Greg A. Woods's message of
 "Wed\, 02 Dec 2009 20\:21\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F21D2CF8-DFAB-11DE-96EC-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134423>

"Greg A. Woods" <woods@planix.com> writes:

> 	$ ls -?
> 	ls: unknown option -- ?
> 	usage: ls [-AaBbCcdFfghikLlmnopqRrSsTtuWwx1] [file ...]
> ...
> Most other commands know '-?', and despite
> the silliness with GNU Ls, use of '-?' to request summary usage
> information is pretty much a de facto standard for unix commands.

I think you are showing ignorance here, as -? is *not* even close to
standard, nor even widely used practice at all.  I somehow doubt your ls
would respond to "ls -X" any differently from "ls -?", but is giving the
same canned response to any unknown option.

The "usage: ls [-AaBbC...] [file...]" indeed is much better than abstract
"usage: frotz <options> <args>" that does not list what <options> are, but
that is a totally different thing.  On that point, I think Peff already
made a good suggestion of giving the full help text in such a case.

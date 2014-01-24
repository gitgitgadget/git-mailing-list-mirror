From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 12:00:16 -0800
Message-ID: <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
References: <20140124090104.GA396@x4>
	<0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
	<20140124170739.GC396@x4> <20140124170909.GD396@x4>
	<20140124182341.GB8202@sigill.intra.peff.net>
	<20140124183222.GE396@x4>
	<20140124185538.GA9836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:00:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6mvV-0002du-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbaAXUAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:00:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbaAXUAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:00:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6F056504A;
	Fri, 24 Jan 2014 15:00:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9Q1rZJT3lRGstGhcEjaih3lwt0=; b=XNZUlO
	f9WsFRYhwG/RbiTWC6fyLZK5ERUob5Iy+wIo7TlYZ1ZX5kCbuJQYVfneP7vLKGFz
	BUIkxeOeRQlbWckpfyti8p1Kc9IN8tVCmH2zGj9ctMZI9noHbxg8oAuKU7BythE+
	4PN8qprAtAMDi5+qREzfRfOpeOLmtOp3AqXYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LfyLJ+uEWNM6dKajWxu0rkmiOB6VhQ+n
	H6pomcTUdtsfPbnL0G/Yo0eApT33T5t2e9zsTIhMjkX2/ESqbpxE0sexlbMCH5tK
	xLRoEvSbjsmtAqqx/dUl2CizTuY5pr3bb9Vethi6K7RGANlo+OTl0hA5u4eokec/
	WKPrt1KWwvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 879C065049;
	Fri, 24 Jan 2014 15:00:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6631265047;
	Fri, 24 Jan 2014 15:00:21 -0500 (EST)
In-Reply-To: <20140124185538.GA9836@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jan 2014 13:55:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 286BE3AA-8532-11E3-B925-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241026>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 24, 2014 at 07:32:22PM +0100, Markus Trippelsdorf wrote:
>
>> > However, you do have to specify each branch individually. You probably
>> > want to say "all branches except X", and you cannot currently specify
>> > a negative refspec like that.
>> 
>> Yes, that was the question I wanted to ask (, sorry for not formulating
>> it more clearly). 
>> Is this "negative refspec for branches" a feature that is planned for
>> the future?
>
> It is something that has been talked about before, but I do not think
> anybody is actively working on. It would probably not be too hard a
> feature if you are interested in getting your feet wet in git
> development. :)

The end result might be not so hard in the mechanical sense, but
designing the interface would be hard.  I do not offhand think of a
good way to do this.

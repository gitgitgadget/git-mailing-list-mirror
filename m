From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 15:36:57 -0700
Message-ID: <7vy5lmgyra.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
 <20120810174605.GA29113@sigill.intra.peff.net>
 <7vlihmk2ab.fsf@alter.siamese.dyndns.org>
 <20120810215020.GA1841@sigill.intra.peff.net>
 <CAJo=hJsaQyBEjH8uWHqnR9Sk9HwFqCwe81HRN3HxUi2j76YNAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:37:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzxpM-0006P2-2B
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 00:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760206Ab2HJWhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 18:37:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab2HJWhA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 18:37:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AD8B9C1E;
	Fri, 10 Aug 2012 18:37:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dIxH3yat5nq7vRG1GQKkVMwczwo=; b=gY69lk
	mMqPr8oAck5R3Pcxo1nOzlata49lW9i3D1BcKs5ssFBwcBQr3ljY550wnT4k3ko3
	GfAXpdrLwwxMY0bHkaN11itnjt68cn+FtpMcAPV+zF7w40ZYlSu9/YGbzGrmwFrU
	7zFBgCmAztdwu4RHqWk7q88KckvEnrj/oPMCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TebWAd8JspRuWQlKLomhTa2JeqMY25ZM
	Az9qfthvzZvVwQYhifVCzTro3rhctuK6vywg28QZy6UHEYdsegrfYryQO5shSCOu
	pyT3XvYkJhpc7fA+vbnVqRekYZmZ8JMRuFj/EeLugzgz+31m9G3h16QjR9B3xzun
	zrzBUPlQxSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D749C1D;
	Fri, 10 Aug 2012 18:37:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6661F9C1C; Fri, 10 Aug 2012
 18:36:59 -0400 (EDT)
In-Reply-To: <CAJo=hJsaQyBEjH8uWHqnR9Sk9HwFqCwe81HRN3HxUi2j76YNAg@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 10 Aug 2012 15:29:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5B56D5E-E33B-11E1-8090-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203274>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Aug 10, 2012 at 2:50 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, Aug 10, 2012 at 11:52:28AM -0700, Junio C Hamano wrote:
>>
>>> When evaluating a change in the interoperability area, it does not
>>> add much more confidence to the correctness that the change has been
>>> in use for months with the same partner than that it has been used
>>> to talk to many different partners even for a short period of time,
>>> I guess.
>>
>> Traditionally our interoperability testing has been to cook things in
>> "next" and "master" and see if anybody complains. It would be nice to
>> have an interoperability test suite that could hit some common hosting
>> sites, as well as older versions of git-core itself. I suspect
>> automating that would be a big pain, though.
>
> I don't know that you need to hit the hosting sites themselves, just
> the implementations they are using. Dulwich and JGit are both open
> source. It should be possible to build a smallish compatibility test
> suite that grabs everyone into one tree, compiles a small test server
> from each, and runs the matrix locally. Then its up to the hosting
> sites to worry about making sure their implementations are included in
> this suite, and up-to-date.  :-)

Yeah, and do that for all the major versions of these
implementations.

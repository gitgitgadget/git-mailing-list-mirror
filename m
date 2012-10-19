From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Fri, 19 Oct 2012 15:43:06 -0700
Message-ID: <7v4nlqhymd.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
 <nnglih0jotj.fsf@transit.us.cray.com>
 <7vfw78s1kd.fsf@alter.siamese.dyndns.org>
 <nngsjb8i30w.fsf@transit.us.cray.com>
 <7v6284qfw8.fsf@alter.siamese.dyndns.org> <20120827214027.GA511@vidovic>
 <nngr4qqhp7x.fsf@transit.us.cray.com>
 <7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
 <CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
 <CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com>
 <7vvce6i5j2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	dag@cray.com, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, greened@obbligato.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 00:43:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPLHm-00052I-OP
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 00:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab2JSWnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 18:43:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab2JSWnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 18:43:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C9F88F8D;
	Fri, 19 Oct 2012 18:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MiURADwGCVGMTiNOsyj/sK1OFH4=; b=U3CeNb
	gRk6AKbyKX0zfFU3QrCQB16v1j8fEee76KAIZvTQ+66CaY1OjFEVgmVPmqLegWP3
	TwgGaeqSorq+k4JszudcFikHwZKl0ekZFO5Yi+c2rR6pUuy8DuwHR2J6rxO/jO/m
	Iq1fGFxB0oG4sChv5kx2g+ssBTk9dvuhnSvJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gb7kQOwmZJyMQfBeSpYbsAYRQpuQ0s41
	zhlhFu1DJljnyXWYo8Im9pomAVcf6iom4Pmlzvr6H9ockCVzTSTMYfwuaYMNMExS
	q/tQSLWfeeL5OKom6FGSOHwSrjguYIssEY5ihhM6BpbmnlkmFriYS9u2kKJ2OsnM
	gPQdDrHOBHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A08E8F8C;
	Fri, 19 Oct 2012 18:43:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0FEE8F8A; Fri, 19 Oct 2012
 18:43:07 -0400 (EDT)
In-Reply-To: <7vvce6i5j2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Oct 2012 13:13:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A3D82CC-1A3E-11E2-84B3-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208075>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Thiago Farina wrote:
>>> [...]
>>> With some structure like:
>>>
>>> include/git.h
>>> src/git.c
>>>
>>> ...
>>>
>>> whatever.
>>> [...]
>>
>> Junio- is it reasonable to expect the directory-restructuring by 2.0?
>
> I actually hate "include/git.h vs src/git.c"; you have distinction
> between .c and .h already.

Having said that, I do not mind moving codeblocks around to make
some files purely library-ish while others purely commands.

Ideally, if you run

    $ nm --defined-only -g builtin/frotz.o

you should see nothing but "T cmd_frotz" (there are exceptions, most
notably, what the commands in the "log" family do are so close with
each other that builtin/log.o can define cmd_* for all of them).

    $ nm --defined-only -og builtin/*.o  | grep -v 'T cmd_'

a handful of offenders.  If these functions with external linkage
are truly useful across subcommands, we should move them to a more
library-ish location.

It may require splitting the bits that are too closely tied to the
external interface they are implementing from these functions,
generalizing only the core-ish logic from them, and moving them to a
more library-ish file as a preparatory step.  Such a library-ish file
may be created inside lib/ subdirectory from the get-go.

Until that kind of code restructure happens, I do not see much sense
in just moving files, e.g. renaming revision.c to src/revision.c or
lib/revision.c or somesuch.

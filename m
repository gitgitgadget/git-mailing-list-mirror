From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GNU patch close to next stable release (2)
Date: Wed, 01 Aug 2012 10:58:06 -0700
Message-ID: <7v8vdyfqa9.fsf@alter.siamese.dyndns.org>
References: <CAHpGcM+DkL_CCisCjF9m0j3NRJUNAdfL05T0cfLjLfVORQHrpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bug-patch@gnu.org, git@vger.kernel.org
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <agruen@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwdBY-0001OQ-C6
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 19:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab2HAR6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Aug 2012 13:58:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688Ab2HAR6J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2012 13:58:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D5191EC;
	Wed,  1 Aug 2012 13:58:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1fn5jNxpv+oS
	kLss54IrFb5CDfk=; b=QpA5c+f2KzY3kJhVbm0BN3t5940pk9gnXsrEDuq4AZa3
	zkBWwsFjDtO/G/tuA+h7TkZbBkA0WaP9CaH4Ns/DNWMn16mprRODIur5wrZpuAIH
	ohdD4uQi3OpqI5iMfYhTM2YYigty/eYbI6b06SRXGQDAqGTNwkPKJocFeniRAb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EEx5rl
	/MbqDDyoPByYQapI1xkzWwkmWoJlh7JNWby97UmqGKBvD3pSzdotmGhoMjR7+xS1
	RPHSO2vK7Wxta9PENibO25UFAocxT+QOvSJLEOI+qbm3VYumFsgP3opGBdASqdux
	ZhlyoEk6YRMVuTiWzC1HQxEsa8PQc84MMWPfo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEA4791EA;
	Wed,  1 Aug 2012 13:58:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3108291E9; Wed,  1 Aug 2012
 13:58:08 -0400 (EDT)
In-Reply-To: <CAHpGcM+DkL_CCisCjF9m0j3NRJUNAdfL05T0cfLjLfVORQHrpw@mail.gmail.com>
 ("Andreas =?utf-8?Q?Gr=C3=BCnbacher=22's?= message of "Wed, 1 Aug 2012
 13:50:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7368583C-DC02-11E1-B430-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202716>

Andreas Gr=C3=BCnbacher <agruen@gnu.org> writes:

> * Support for double-quoted filenames in the "diff --git" format: whe=
n a
>   filename starts with a double quote, it is interpreted as a C strin=
g
>   literal.  The escape sequences \\, \", \a, \b, \f, \n, \r, \t, \v, =
and \ooo
>   (a three-digit octal number between 0 and 255) are recognized.

Is this also available in non-git diffs?  IIRC, this extension to
allow funny characters in pathnames was proposed by and discussed
with Paul Eggert (listed as one of GNU diffutils maintainers at
www.gnu.org/software/diffutils/) and git happened to adopt it
earlier than "GNU diff" itself did.

I found it a bit odd to see this listed as one of the items needed
to support "diff --git" oddity.

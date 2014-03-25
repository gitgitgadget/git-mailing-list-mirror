From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Tue, 25 Mar 2014 10:23:38 -0700
Message-ID: <xmqqior2mbtx.fsf@gitster.dls.corp.google.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
	<5330196A.3030101@ramsay1.demon.co.uk> <53306910.3090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:25:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSV6G-0005m3-Kz
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbaCYRXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:23:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbaCYRXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:23:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27D6977F48;
	Tue, 25 Mar 2014 13:23:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7GYIfuC2NF4XSU4JfWOJgQae47k=; b=fQDQzo
	LVikLnPRmeX5wSrCLa3FXnUjlRpqe94I5cunNzPJSoJU5DPfcjbiKBYigbnTkCTP
	uX8Ewx+UGiyLG6Zq6WvgRASJpyBH2rRgz7VfvUZbKtLR6PnJVQa9q03XOrtsNeFG
	Q89bhY0qwtXsvYh+bqvZAYg4Z7rfzBZJTdUPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0mpiBPH+EQNlgUHPBtFgoRj7r4UlEqR
	5FBz2/P02Fq2wkxxsG4GoyhMEem1JUP1uMuk6TsXHMXxhjEjyPLwhvhQ1GNDSAk4
	8aKTfDJN1x0qYpe3YC87pu/8i9AMFWHX0P59x6lxXubYS2pFyrDHU21wjosPARVG
	n5HokDJIW1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 184F377F46;
	Tue, 25 Mar 2014 13:23:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4869B77F45;
	Tue, 25 Mar 2014 13:23:40 -0400 (EDT)
In-Reply-To: <53306910.3090807@gmail.com> (Ilya Bobyr's message of "Mon, 24
	Mar 2014 10:19:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 351B06FA-B442-11E3-971D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245057>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> On 3/24/2014 4:39 AM, Ramsay Jones wrote:
>> On 24/03/14 08:49, Ilya Bobyr wrote:
>>> Most arguments that could be provided to a test have short forms.
>>> Unless documented the only way to learn then is to read the code.
>>>
>>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>>> ---
>>>  t/README |   10 +++++-----
>>>  1 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/t/README b/t/README
>>> index caeeb9d..ccb5989 100644
>>> --- a/t/README
>>> +++ b/t/README
>>> @@ -71,7 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
>>>  (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
>>>  appropriately before running "make".
>>>  
>>> ---verbose::
>>> +-v,--verbose::
>> OK
>>
>>> [...]
>>>  
>>> ---valgrind=<tool>::
>>> +-v,--valgrind=<tool>::
>> The -v short option is taken, above ... :-P
>
> Right %)
> Thanks :)
> This one starts only with "--va", will fix it.

Please don't.

In general, when option names can be shortened by taking a unique
prefix, it is better not to give short form in the documentation at
all.  There is no guarantee that the short form you happen to pick
when you document it will continue to be unique forever.  When we
add another --vasomething option, --va will become ambiguous and one
of these two things must happen:

 (1) --valgrind and --vasomething are equally useful and often used.
     Neither will get --va and either --val or --vas needs to be
     given.

 (2) Because we documented --va as --valgrind, people feel that they
     are entitled to expect --va will stay forever to be a shorthand
     for --valgrind and nothing else.  The shortened forms will be
     between --va (or longer prefix of --valgrind) and --vas (or
     longer prefix of --vasomething).

We would rather want to see (1), as people new to the system do not
have to learn that --valgrind can be spelled --va merely by being
the first to appear, and --vasomething must be spelled --vas because
it happened to come later.  Longer term, nobody should care how the
system evolved into the current shape, but (2) will require that to
understand and remember why one is --va and the other has to be --vas.

We already have this suboptimal (2) situation between "--valgrind"
and "--verbose" options, but a shorter form "v" that is used for
"verbose" is so widely understood and used that I think it is an
acceptable exception.  So

         --verbose::
        +-v::
                Give verbose output from the test

is OK, but "--valgrind can be shortened to --va" is not.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Tue, 03 Mar 2015 12:06:32 -0800
Message-ID: <xmqq8ufdc0c7.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu>
	<xmqq385nb2yg.fsf@gitster.dls.corp.google.com>
	<54F5D869.4010104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 21:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSt5U-0006vJ-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbbCCUGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:06:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755528AbbCCUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:06:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 942183D387;
	Tue,  3 Mar 2015 15:06:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9i5zltNcvrQUX1tEQYzvcaXp0dQ=; b=uLOykE
	yHfQui7tEM/S3qWwf6isDbdhr6JLa7HB92VldfAh2jHhYZ7C5UTFdSqR/4xrXB5s
	htbWi5WG3qvwys1nHMdBRJhTCl6+vr9nHbuFE6EK2E7Coe7FCia2HF/dAoGjdvt5
	1gb0yPjXnmOmin7WF5Kq0DAEBnRHaI7XNWGh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uUaJmqVsM4OEommrG6edj+N6+t5e/AYy
	v8wp0apaQ0mOrU5iOcAAFSevDaFipYzeZz5IhdVIHzHd/1at1Quxh+NLOffynfpb
	8nF3yofHlR8Dly9Wh2PVg0NZMETu0hpPJlJw0G5NjzX9cMDpl9SiY7F9SJ1vuTLG
	ZWoLSZXKi+E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A3523D386;
	Tue,  3 Mar 2015 15:06:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E81DE3D384;
	Tue,  3 Mar 2015 15:06:33 -0500 (EST)
In-Reply-To: <54F5D869.4010104@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 03 Mar 2015 16:51:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA59888E-C1E0-11E4-9E07-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264678>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 02.03.2015 20:43:
>> Anders Kaseorg <andersk@mit.edu> writes:
>> 
>>> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
>>> ---
>>>  t/t5516-fetch-push.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>>> index 85c7fec..594d7a6 100755
>>> --- a/t/t5516-fetch-push.sh
>>> +++ b/t/t5516-fetch-push.sh
>>> @@ -238,7 +238,7 @@ test_expect_success 'push with pushInsteadOf' '
>>>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
>>>  	mk_empty testrepo &&
>>>  	test_config "url.trash2/.pushInsteadOf" testrepo/ &&
>>> -	test_config "url.trash3/.pusnInsteadOf" trash/wrong &&
>>> +	test_config "url.trash3/.pushInsteadOf" trash/wrong &&
>>>  	test_config remote.r.url trash/wrong &&
>>>  	test_config remote.r.pushurl "testrepo/" &&
>>>  	git push r refs/heads/master:refs/remotes/origin/master &&
>> 
>> Interesting.
>> 
>> Now an obvious and natural question after seeing this change is how
>> the original test passed with misspelled configuration.  Is a test
>> that pushes into "trash/wrong" checking the right outcome?  If the
>> reason why the existing tests passed without this patch is because
>> they do not test the right thing, then shouldn't they be corrected
>> together with the above fix?
>> 
>
> Ha, I was look there, too, just today and was wondering the same.
>
> I guess the test wanted to make sure (among other things) that
> url.trash3/.pushInsteadOf does not affect the push to remote r (which
> has an explicit pushurl)...

OK, so it makes sure the push goes to testrepo/ but it does not make
sure trash2 or trash3 are not touched.  Makes sort of sense.

Thanks.

I am not sure how the intention of the commit 1c2eafb8 (Add
url.<base>.pushInsteadOf: URL rewriting for push only, 2009-09-07),
which introduced the behaviour verified by this test, interacts with
the desire to redefine what URL and pushURL mean in our recent past,
what e.g. e6196ae1 (remote: add --fetch and --both options to set-url,
2014-11-25) wanted to do, though.  Thoughts?

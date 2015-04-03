From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/4] git-p4: update locked test case
Date: Fri, 03 Apr 2015 14:55:46 -0700
Message-ID: <xmqqk2xsg9lp.fsf@gitster.dls.corp.google.com>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
	<1428087218-8186-5-git-send-email-luke@diamand.org>
	<CAPig+cSsPZZ=kEQ9jwj-BKkO+gKFwZYVi-FrTvvTZpmatmokAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:55:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9ZB-0003Nq-QM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbbDCVzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:55:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751781AbbDCVzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:55:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 084D44537B;
	Fri,  3 Apr 2015 17:55:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zv4bKhdkSDO0GtnVETqWbGsRHi8=; b=kGvgJ7
	eTUREqwYWNU4hei/mh6FOEYGU5OpO1vjmjdkmfFYmYiGa/g653Uu2Jxlp1VWWVWf
	8M+D8ahqHDAbMi7sLNDPGGzgEb3qYyRWPZ2IHsv5+sKf5G3jm78w0nJc+PeIozE2
	C+XwwjHaFEkHfvK2rxXpYDSgzwpYaOsxtcIss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HfYO9WwlcmYZz3+LxXlRUemK4d2f5PYN
	o9UEruyUOMFQHmdfU1vavdqy0yhYwr8FXddbMEdWNP/rFXg72nW0rO1+n+wWTNu8
	TSMRQQrkevGFq0ZcTgsGl3hANCwee8eturlcF1vuo8KBrjtF6NnLSf+mPd4O/gci
	g5bwEE6nSLg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3D354537A;
	Fri,  3 Apr 2015 17:55:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 630AB45377;
	Fri,  3 Apr 2015 17:55:47 -0400 (EDT)
In-Reply-To: <CAPig+cSsPZZ=kEQ9jwj-BKkO+gKFwZYVi-FrTvvTZpmatmokAQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 3 Apr 2015 16:00:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F5D0AF2-DA4C-11E4-8CD8-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266736>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Apr 3, 2015 at 2:53 PM, Luke Diamand <luke@diamand.org> wrote:
>> The add-new-file and copy-existing-file tests from
>> t9816-git-p4-locked.sh now pass. Update the test
>> case accordingly.
>
> This patch should be folded into patch 3/4, shouldn't it?

If the fix and tests were done by the same person, we strongly
prefer to see the code fix and test expectation update in the same
commit.

What Luke is doing here is to spread the credits/blame to two
people.  If I were playing Luke's role, I might have squashed them
into a single commit, kept the authorship of the whole thing under
Blair Holloway's name, and extend the log message by mentioning that
I flipped the test expectations, but I'd say either is fine for this
change.

>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>>  t/t9816-git-p4-locked.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
>> index 464f10b..d048bd3 100755
>> --- a/t/t9816-git-p4-locked.sh
>> +++ b/t/t9816-git-p4-locked.sh
>> @@ -35,7 +35,7 @@ test_expect_success 'edit with lock not taken' '
>>         )
>>  '
>>
>> -test_expect_failure 'add with lock not taken' '
>> +test_expect_success 'add with lock not taken' '
>>         test_when_finished cleanup_git &&
>>         git p4 clone --dest="$git" //depot &&
>>         (
>> @@ -107,7 +107,7 @@ test_expect_failure 'chmod with lock taken' '
>>         )
>>  '
>>
>> -test_expect_failure 'copy with lock taken' '
>> +test_expect_success 'copy with lock taken' '
>>         lock_in_another_client &&
>>         test_when_finished cleanup_git &&
>>         test_when_finished "cd \"$cli\" && p4 revert file2 && rm -f file2" &&
>> --
>> 2.3.0.rc1.30.g76afe74

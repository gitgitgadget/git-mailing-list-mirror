From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 6/7] test-hg.sh: help user correlate verbose output with
 email test
Date: Mon, 11 Nov 2013 16:17:14 -0500
Message-ID: <5281495A.3080607@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>	<1384142712-2936-7-git-send-email-rhansen@bbn.com>	<5280c2c3e066c_6841541e7824@nysa.notmuch>	<52812DD2.9030506@bbn.com> <CAMP44s00iTM00mU-+ESicBHeK=VH9MQTiZw6pFRXjTv2-xb_AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 22:17:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyrH-0000i2-Qs
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab3KKVRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:17:15 -0500
Received: from smtp.bbn.com ([128.33.1.81]:22700 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab3KKVRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:17:15 -0500
Received: from socket.bbn.com ([192.1.120.102]:44808)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfyrC-000PsH-RE; Mon, 11 Nov 2013 16:17:14 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 878583FEF1
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAMP44s00iTM00mU-+ESicBHeK=VH9MQTiZw6pFRXjTv2-xb_AQ@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237655>

On 2013-11-11 14:29, Felipe Contreras wrote:
> On Mon, Nov 11, 2013 at 1:19 PM, Richard Hansen <rhansen@bbn.com> wrote:
>> On 2013-11-11 06:42, Felipe Contreras wrote:
>>> Richard Hansen wrote:
>>>> It's hard to tell which author conversion test failed when the email
>>>> addresses look similar.
>>>>
>>>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>>>> ---
>>>>  contrib/remote-helpers/test-hg.sh | 20 ++++++++++----------
>>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
>>>> index 84c67ff..5eda265 100755
>>>> --- a/contrib/remote-helpers/test-hg.sh
>>>> +++ b/contrib/remote-helpers/test-hg.sh
>>>> @@ -209,16 +209,16 @@ test_expect_success 'authors' '
>>>>
>>>>      >../expected &&
>>>>      author_test alpha "" "H G Wells <wells@example.com>" &&
>>>> -    author_test beta "test" "test <unknown>" &&
>>>> -    author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
>>
>> Notice the two betas here in the original code.
> 
> Ahh, that's a bug.
> 
>>>> -    author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
>>>> -    author_test delta "name<test@example.com>" "name <test@example.com>" &&
>>>> -    author_test epsilon "name <test@example.com" "name <test@example.com>" &&
>>>> -    author_test zeta " test " "test <unknown>" &&
>>>> -    author_test eta "test < test@example.com >" "test <test@example.com>" &&
>>>> -    author_test theta "test >test@example.com>" "test <test@example.com>" &&
>>>> -    author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
>>>> -    author_test kappa "test@example.com" "Unknown <test@example.com>"
>>>> +    author_test beta "beta" "beta <unknown>" &&
>>>> +    author_test beta "beta <test@example.com> (comment)" "beta <test@example.com>" &&
>>>
>>> Two betas?
>>
>> See above.  I can change them to beta1 and beta2, or if you'd prefer I
>> can change them to beta and gamma and increment the subsequent entries.
> 
> Yeah, I would prefer that in two patches, one that fixes the sequence,
> and the other one that changes the emails.

Will do.

Thanks,
Richard

> If you don't have time for
> that the original patch is OK by me. The problem with the sequence can
> be fixed later.
> 
> Cheers.
> 

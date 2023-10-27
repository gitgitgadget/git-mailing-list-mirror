Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8151946F
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0190F3
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:47:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 16B11202F9;
	Fri, 27 Oct 2023 13:47:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwQvm-jZa-00; Fri, 27 Oct 2023 19:47:34 +0200
Date: Fri, 27 Oct 2023 19:47:34 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phil@crinan.ddns.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <ZTv3to98QT8Ma+ag@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly>
 <ZTtyHScKkMg4qnMH@tanuki>
 <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>
 <ZTuUa5bA8dh29cyv@ugly>
 <b6ef74b7-2c77-4621-9969-d911c34561d5@crinan.ddns.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ef74b7-2c77-4621-9969-d911c34561d5@crinan.ddns.net>

On Fri, Oct 27, 2023 at 03:32:48PM +0100, Phillip Wood wrote:
>On 27/10/2023 11:43, Oswald Buddenhagen wrote:
>> On Fri, Oct 27, 2023 at 11:22:35AM +0100, Phillip Wood wrote:
>>>>>> +    CI_BRANCH="$CI_COMMIT_REF_NAME"
>>>>>> +    CI_COMMIT="$CI_COMMIT_SHA"
>>>>>>
>>>>> assignments need no quoting to prevent word splitting.
>>>>> repeats below.
>>>>>
>>> I think it is quite common for us to quote variables when it isn't 
>>> strictly necessary as it makes it clear to anyone reading the script 
>>> that there is no word splitting going on
>> 
>>> and ensures that we don't start splitting the variable if the contents 
>>> changes in the future.
>>>
>> the point was that it *isn't* content-dependent; it's simply the shell 
>> rules.
>
>Oh, I'd misunderstood what you were saying which was that assignment and 
>case statements are not subject to field splitting.
>
>> of course, many people (apparently you included) don't know these 
>> subtleties
>
>I find this comment to be condescending, needlessly antagonistic and 
>completely at odds with the norms of constructive discussion on this list.
>
the observation was necessary for the point i subsequently made (which 
was basically agreeing with the first part of your response).

i think it's a rather uncontroversial statement that many people don't 
know the ins and outs of the shell's word splitting rules. in fact, this 
is to be expected given how arbitrary the rules seem.

that you seem to be among these people was a reasonable inference from 
what you actually wrote. mentioning it was meant to provide a segue and 
add emphasis.

regards

From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Fri, 06 May 2016 16:20:58 +0200
Message-ID: <20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
 <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Junio C Hamano <gitster@pobox.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 06 16:21:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aygd3-0002yw-QP
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 16:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757850AbcEFOVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 10:21:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40578 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757007AbcEFOVF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 10:21:05 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aygcm-0005YG-Gz; Fri, 06 May 2016 16:21:00 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1aygcl-0006wl-0y; Fri, 06 May 2016 16:20:59 +0200
Received: from x4db02b4a.dyn.telefonica.de (x4db02b4a.dyn.telefonica.de
 [77.176.43.74]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 06 May 2016 16:20:58 +0200
In-Reply-To: <CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462544460.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293784>


Quoting Eric Sunshine <sunshine@sunshineco.com>:

> On Thu, May 5, 2016 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>> This series of patches add a configuration variable for verbose in
>>> git-commit.
>>>
>>> Changes wrt v15:
>>> * Remove the previous patch 7/7 and split the tests. Include one in
>>>   initial patch 6/7. The other one is introduced in a separate commit
>>>   after 4/7.
>>> * Include tests in patch 3/6 for --no-quiet without -q, multiple verbose,
>>>   --no-verbose with -v as suggested by Eric Sunshine
>>
>> Thanks for a pleasant read.  Modulo minor readability nits I sent
>> separately on 7/7, this looked good.
>
> Agreed, this version was a more pleasant and coherent read than  
> previous ones.
>
> Considering that this series is already at v16 and the 7/7 review
> comments were very minor, I'd be fine seeing this series land as-is,
> rather than expecting v17.

v16, wow, I totally lost track of this series, sorry.

And I hate to bring this up this late again... at v16 of a now 7 patch
series, when all this started out like two months ago as a GSoC mini
project...
But I do it anyway.  Oh well.

A while ago in a related thread Peff remarked about 'git commit's
'--quiet' and '--verbose' options:

    I think that is a UX mistake, and we would not do
    it that way if designing from scratch. But we're stuck with it for
    historical reasons (I'd probably name "--verbose" as "--show-diff" or
    something if writing it today).

http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=289069

Then I replied:

    However, that doesn't mean that we have to spread this badly chosen
    name from options to config variables, does it?  I think that if we
    are going to define a new config variable today, then it should be
    named properly, and it's better not to call it 'commit.verbose', but
    'commit.showDiff' or something.

http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=289303

Any thoughts on this?  Before a poorly named config variable enters to
the codebase and we'll have to maintain it "forever"...

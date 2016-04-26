From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] config doc: improve exit code listing
Date: Tue, 26 Apr 2016 20:41:30 +0100
Message-ID: <571FC46A.1090202@ramsayjones.plus.com>
References: <20160426181058.7901-1-sbeller@google.com>
 <571FBD52.4040206@ramsayjones.plus.com>
 <CAGZ79ka_spZCCwpKtUhJTA+osetbzZDpmmv6GWYV+QeBkU5Tmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:42:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8rt-0002Bn-KD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbcDZTli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 15:41:38 -0400
Received: from avasout08.plus.net ([212.159.14.20]:55797 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbcDZTlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 15:41:36 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id n7hZ1s0012D2Veb017haWU; Tue, 26 Apr 2016 20:41:34 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=1XWaLZrsAAAA:8 a=gW8RpNARDj_721OHMQEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAGZ79ka_spZCCwpKtUhJTA+osetbzZDpmmv6GWYV+QeBkU5Tmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292653>



On 26/04/16 20:18, Stefan Beller wrote:
> On Tue, Apr 26, 2016 at 12:11 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 26/04/16 19:10, Stefan Beller wrote:
>>> The possible reasons for exiting are now ordered by the exit code value.
>>> While at it, rewrite the `can not write to the config file` to
>>> `the config file cannot be written` to be grammatically correct and a
>>> proper sentence.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  Documentation/git-config.txt | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>>> index 6fc08e3..6843114 100644
>>> --- a/Documentation/git-config.txt
>>> +++ b/Documentation/git-config.txt
>>> @@ -58,10 +58,10 @@ that location (you can say '--local' but that is the default).
>>>  This command will fail with non-zero status upon error.  Some exit
>>>  codes are:
>>>
>>> -- The config file is invalid (ret=3),
>>      ^
>> I don't see why this is capitalised, so ...
> 
> Because the whole listing is a bunch of sentences,
> stringed together with commas at the end of each line.
> Note that there is a ',' at the end of each line, except for
> the last, where you see a '.'.

Heh, I hadn't noticed the commas, no - I assumed periods.

>                                 I thought about breaking that
> up into a list and make all of the bullet points either a sentence
> (all capitalised and ending in dot) or part sentences (lower
> case for each bullet point, not clear about the ending)

That's probably what I would have done.

> I kept it as is in a long sentence as I expected to see
> lowest resistance there. ;)

'One long sentence' split into a bullet/numbered list is err ...
Hmm, I'm lost for words. ;-)

>> Only a minor point.
> 
> If the current state bothers you too much,
> please send a patch with correct lists. :)
> (Feel free to squash this patch into that or
> just on top of this)

Having said all that, (since I have very few documentation
skills), I will leave this for others to improve, if
necessary.

ATB,
Ramsay Jones

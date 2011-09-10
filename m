From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Sat, 10 Sep 2011 07:10:39 +0100
Message-ID: <4E6AFF5F.6090805@diamand.org>
References: <1315514452.10046.0.camel@uncle-pecos>	 <loom.20110909T115356-849@post.gmane.org>  <4E6A514C.5080200@diamand.org> <1315590747.10046.5.camel@uncle-pecos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "L. A. Linden Levy" <alevy@mobitv.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 08:10:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2GmC-00066J-UY
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 08:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab1IJGKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 02:10:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63192 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1IJGKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 02:10:43 -0400
Received: by wyh22 with SMTP id 22so2114292wyh.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 23:10:42 -0700 (PDT)
Received: by 10.216.137.104 with SMTP id x82mr220419wei.77.1315635041944;
        Fri, 09 Sep 2011 23:10:41 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com [86.26.7.206])
        by mx.google.com with ESMTPS id et17sm9556356wbb.0.2011.09.09.23.10.40
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Sep 2011 23:10:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <1315590747.10046.5.camel@uncle-pecos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181139>

On 09/09/11 18:52, L. A. Linden Levy wrote:
> I noticed that it only skipped the edit check. That is why I added the
> skipSubmitEdit option. If they are both true then it never opens the
> editor and never checks for an edit. Probably they should just be one
> option. I think it should probably also be a command line option to skip
> the editor.

Sounds plausible. If the skipSubmitEdit is true then the edit check 
should always be skipped.


>
> - Alex
>
> On Fri, 2011-09-09 at 13:47 -0400, Luke Diamand wrote:
>> On 09/09/11 11:05, Vitor Antunes wrote:
>>> L. A. Linden Levy<alevy<at>   mobitv.com>   writes:
>>>
>>>>
>>>> Hi All,
>>>>
>>>> I have been using git-p4 for a while and it has allowed me to completely
>>>> change the way I develop and still be able to use perforce which my
>>>> company has for its main VCS. One thing that was driving me nuts was
>>>> that "git p4 submit" cycles through all of my individual commits and
>>>> asks me if I want to change them. The way I develop I often am checking
>>>> in 20 to 50 different small commits each with a descriptive git comment.
>>>> I felt like I was doing double duty by having emacs open on every commit
>>>> into perforce. So I modified git-p4 to have an option to skip the
>>>> editor. This option coupled with git-p4.skipSubmitEditCheck will make
>>>> the submission non-interactive for "git p4 submit".
>>>
>>> Hi Loren,
>>>
>>> This option was already included in a recent commit. The name that was
>>> used is "skipSubmitEditCheck". Please make sure you are using the most
>>> recent version of the script.
>>
>> I put that option in - glad it's of use!
>>
>> That option actually just skips the check of 'did the user edit the
>> file'. git-p4 will still go ahead and bring up the file in the editor first.
>>
>> I get around this myself by setting EDITOR=/bin/true. That works for me
>> because I'm only using it in a script.
>>
>> But it's possible that an additional option would actually be useful.
>>
>>
>>
>>>
>>> But don't let this discourage you from submitting patches. Just makesure
>>> you clone git's repository and apply your patch over "maint" or "master"
>>> branches. For more details on how to submit patches you can read
>>> Documentation/SubmittingPatches.
>>>
>>> Vitor
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

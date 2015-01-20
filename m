From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_messes_up_=27=C3=B8=27_character?=
Date: Tue, 20 Jan 2015 22:26:29 +0100
Message-ID: <CACBZZX5f0ciqmJizYxe+UvKL-g9iDZTca52=9xZP4_qiuEaO3Q@mail.gmail.com>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de>
 <54BEB7ED.2050103@tronnes.org> <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
 <54BEC75C.3090207@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <notro@tronnes.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgK5-0003Tf-L6
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbbATV0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 16:26:50 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:40231 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbATV0u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 16:26:50 -0500
Received: by mail-oi0-f50.google.com with SMTP id h136so723087oig.9
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JYII9xl44WoFGKtO5RXMNVroweHUPvjVJc4X2+JemSM=;
        b=uJfKxuu4Q3A7cwbBzrfo4PlpgoNh85+0jme21gBr4Px+987Rr9+27kOvWkx4S8Flok
         yepsfAohJZ8XsfqLcGtJj6gqH/rZ865OeQpdtLsXhEO0mNT4rFjjRIm3g5oOYpGHJ6yA
         nnhcSh+EPw/SDlMDttsDMG/+By7DFMG0VrcioacNEPGTpwcsED4M4Zpsk5TCf6BXB0b0
         V7VLFrN5aUWkhWkNL9XuH5cze52NQ4jRMB7PN2xj75UkFGBldj0Zku84/vf7eGyVarBs
         EWJnyKgBqQZuxy9auh5WMsCbOURPj+3VtYIcb0A117P+pZf1yHyMU/KAMNaxU73Td3G0
         YgSg==
X-Received: by 10.202.186.8 with SMTP id k8mr16678122oif.39.1421789209438;
 Tue, 20 Jan 2015 13:26:49 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Tue, 20 Jan 2015 13:26:29 -0800 (PST)
In-Reply-To: <54BEC75C.3090207@tronnes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262693>

On Tue, Jan 20, 2015 at 10:23 PM, Noralf Tr=C3=B8nnes <notro@tronnes.or=
g> wrote:
> Den 20.01.2015 21:45, skrev =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> On Tue, Jan 20, 2015 at 9:17 PM, Noralf Tr=C3=B8nnes <notro@tronnes.=
org> wrote:
>>>
>>> Den 20.01.2015 21:07, skrev Torsten B=C3=B6gershausen:
>>>>
>>>> On 2015-01-20 20.46, Noralf Tr=C3=B8nnes wrote:
>>>> could it be that your "=C3=B8" is not encoded as UTF-8,
>>>> but in ISO-8859-15 (or so)
>>>>
>>>>> $ git log -1
>>>>> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
>>>>> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
>>>>
>>>> What does
>>>> git config -l | grep Noralf | xxd
>>>> say ?
>>>>
>>> $ git config -l | grep Noralf | xxd
>>> 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoral=
f
>>> 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.
>>>
>>> $ file ~/.gitconfig
>>> /home/pi/.gitconfig: ISO-8859 text
>>
>> What's happened here is that:
>>
>>   1. You've authored your commit in ISO-8859-1
>>   2. Git itself has no place for the encoding of the author name in =
the
>> commit object format
>>   3. git-format-patch has a --compose-encoding which I think would s=
ort
>> this out if you set it to ISO-8859-1, but it defaults to UTF-8
>>   4. Your patch is actually a ISO-8859-1 byte sequence, but is
>> advertised as UTF-8
>>   5. You end up with a screwed-up commit
>>
>> You could work around this, but I suggest just joining the 21st
>> century and working exclusively in UTF-8, it makes things much easie=
r,
>> speaking as someone with 3x more non-ASCII characters their his name
>> than you :)
>>
>
> Ok, then the question is: How do I switch to UTF-8?
>
> To me it seems I'm already using it:
> $ locale charmap
> UTF-8

Your .gitconfig has an ISO-8859-1 string, from an earlier mail of yours=
:

> $ git config -l | grep Noralf | xxd
> 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoralf
> 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.

On a system configured for UTF-8 this would be:

$ echo Noralf Tr=C3=B8nnes | xxd
0000000: 4e6f 7261 6c66 2054 72c3 b86e 6e65 730a  Noralf Tr..nnes.

Note the "f8" v.s. "c3 b8".

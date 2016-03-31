From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Date: Thu, 31 Mar 2016 19:41:44 +0100
Organization: OPDS
Message-ID: <3130A15B06774B23AF4F56D4939918F1@PhilipOakley>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com> <CAAErz9jeLPU+QocSKNssknoJdZoi4Sq0YfZiNnpf4wD70JKQUQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Zachary Turner" <zturner@google.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:41:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhXT-0001F0-SC
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbcCaSlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:41:46 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48532 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbcCaSlp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:41:45 -0400
Received: from PhilipOakley ([2.96.204.202])
	by smtp.talktalk.net with SMTP
	id lhXLaqN4OEnBtlhXLaPP0F; Thu, 31 Mar 2016 19:41:43 +0100
X-Originating-IP: [2.96.204.202]
X-Spam: 0
X-OAuthority: v=2.1 cv=YNU/sUyx c=1 sm=1 tr=0 a=nBDDDTVn/lToA/VoCIgfnQ==:117
 a=nBDDDTVn/lToA/VoCIgfnQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8
 a=UEyZKOYoAAAA:8 a=VwQbUJbxAAAA:8 a=GtPq3gqbNhobXgMMZrQA:9 a=QEXdDO2ut3YA:10
 a=x8gzFH9gYPwA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfP6rosqUQXaslyLb0G83GtvvQRnzA8/nUV9X+pzIXQfGE9Gxf/on+avMtgv9hE6pF77KOSBf5sIrQP4N+wEM8UqIeWhlHzq2AR9ZPGkGCCqxsMZE06gD
 8EDcGvEPejZYJO/lFrZQKZqWnuTyBRyw/gt8DVKKBZDwNVfBpE+w8omDPCPWICZzSmde5MTo6ffnf10ZljZtivd4P4yJUQg5SKE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290443>

From: "Zachary Turner" <zturner@google.com>
>I dug into this some more, and as surprising as it is, I believe the
> release of Git 2.8.0 is just busted.  I had an installer for 2.7.0
> lying around, so after uninstalling 2.8.0 and re-installing 2.7.0,
> everything works fine.
>
> I'm not terribly active in the Git community so I don't know what the
> procedure is for things like this, but this seems like a fairly
> serious regression.  Suggestions on how to proceed?

see https://github.com/git-for-windows/git/issues/711#issuecomment-204003950
"Indeed, the culprit is git-for-windows/msys2-runtime@7346568 and reverting 
it fixes the issue. Will continue tomorrow." @dscho


>
> On Wed, Mar 30, 2016 at 5:07 PM, Zachary Turner <zturner@google.com> 
> wrote:
>> Hi, just recently I installed the latest build of Windows 10 of my
>> machine. This is my second Win10 machine. On the other I am using git
>> 2.7.0.windows.1 and everything is working just fine.
>>
>> On the second machine I am using git 2.8.0.windows.1 and vim does not
>> work. I sent a bug report to bugs@vim.org, but frankly I don't know whose
>> bug this is, so I'm including it here as well.
>>
>> The problem is that vim is just a black screen when git launches it. If I
>> mash enough keys eventually I see something that resembles vim output at
>> the bottom, but I can't actually use it.
>>
>> I tried going into program files\git\usr\bin and just running vim.exe.
>> Again, black screen. If I press enter about 10 times I can see the
>> introduction screen. Then if I press : about 10-20 times it will go into
>> command mode and a single : appears. after pressing a few more keys all
>> the rest of the :s appear. Basically, everything is completely unusable.
>>
>> I tried downloading vim 7.4 from www.vim.org, and low and behold, it
>> works. For now I've replaced the copy of vim.exe that ships with git with
>> the copy from www.vim.org. But this leaves me nervous that something is
>> seriously wrong.
>>
>> Has anyone seen anything like this before, or have any ideas how I might
>> better diagnose this?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

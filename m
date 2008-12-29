From: david@lang.hm
Subject: Re: turn off "LF will be replaced by CRLF" thingy
Date: Mon, 29 Dec 2008 09:29:13 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812290928370.15026@asgard.lang.hm>
References: <gjaqta$tg7$4@ger.gmane.org> <37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com> <gjat90$5la$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 29 17:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHKyj-0008Nh-5P
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbYL2Q1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbYL2Q1L
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:27:11 -0500
Received: from mail.lang.hm ([64.81.33.126]:49512 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYL2Q1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:27:10 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBTGR7UW001956;
	Mon, 29 Dec 2008 08:27:07 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <gjat90$5la$4@ger.gmane.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104108>

On Mon, 29 Dec 2008, Zorba wrote:

> Thanks Dmitry,
>
> So I have two options to do this - edit the files direct or issue a command,
> thank you !
>
> Now, my next problem is taking all my changes ($ git add .  -> puts 5k files
> into index, with LF in place of CRLF) out of the index.
>
> Because I haven't committed anything in this repo yet...

I think if you just do a git add . again it will put the files into the 
index without doing the conversion.

David Lang

> $ git reset --hard
>
> ....falls over, as it has no HEAD to reset to
>
> I think I read how to do this in a tutorial somewhere, maybe with
> git-checkout, but I'm searching and can't find it.
> Any kind soul can point me in the right direction ?
>
> thanks !
> "Dmitry Potapov" <dpotapov@gmail.com> wrote in message
> news:37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com...
>>> I'd rather not let git change any files, many of which are PHP that run
>>> on
>>> Apache
>>> I think I remember reading that this is a config option that gets
>>> swithced
>>> on by default on windows (which we are running git on)
>>>
>>> how do I switch it off ?
>>
>> git config core.autocrlf false
>>
>> or if you want to ensure that all your text files have only LF then
>>
>> git config core.autocrlf input
>>
>> or if you want to disable conversion for some specific files then you can
>> use 'crlf' attribute. See 'gitattributes' for more information.
>> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
>>
>> Dmitry
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

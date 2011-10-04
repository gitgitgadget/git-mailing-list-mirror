From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Unable to remove a file
Date: Tue, 04 Oct 2011 09:57:57 +0200
Message-ID: <4E8ABC85.7090705@in.waw.pl>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>	<m262k6jc2c.fsf@igel.home> <CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzsN-0001bb-Nf
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab1JDH5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 03:57:15 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:37051 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754909Ab1JDH5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 03:57:14 -0400
Received: from beck.fuw.edu.pl ([193.0.82.235])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RAzsG-0004R1-Ny; Tue, 04 Oct 2011 09:57:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Icedove/3.1.13
In-Reply-To: <CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182742>

On 10/03/2011 10:57 PM, robert mena wrote:
> Thanks.
>
> It accepted the command but rejected my push.
>
> git filter-branch --index-filter 'git rm -q --ignore-unmatch --cached
> scripts/\\' HEAD
> Rewrite 5ac83187fa298add60cf81fd1d54b194da7ae783 (57/57)
> Ref 'refs/heads/master' was rewritten
> git push
>   ! [rejected]        master ->  master (non-fast-forward)
> error: failed to push some refs to 'git@myserver:repository'
>
> Should I do anything special?
git push -f

Zbyszek

>
> On Mon, Oct 3, 2011 at 12:04 PM, Andreas Schwab<schwab@linux-m68k.org>  wrote:
>> robert mena<robert.mena@gmail.com>  writes:
>>
>>> I found the command filter but it is not working.
>>>
>>> git filter-branch --index-filter 'git rm --cached scripts/\\' HEAD
>>
>> $ git filter-branch --index-filter 'git rm -q --ignore-unmatch --cached scripts/\\' HEAD
>>
>> Andreas.
>>
>> --
>> Andreas Schwab, schwab@linux-m68k.org
>> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
>> "And now for something completely different."
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

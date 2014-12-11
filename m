From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitignore.txt: do not suggest assume-unchanged
Date: Thu, 11 Dec 2014 16:13:10 +0100
Message-ID: <5489B486.6060608@drmicha.warpmail.net>
References: <5486B342.8090800@drmicha.warpmail.net> <fe381f27dd50afd44d451577e2315ed5580e3034.1418123458.git.git@drmicha.warpmail.net> <20141210010658.GD16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?U8OpcmdpbyBCYXN0bw==?= <sergio@serjux.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Philip Oakley <philipoakley@iee.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 16:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz5Qh-0002Fn-5e
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 16:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbaLKPNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 10:13:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32823 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754331AbaLKPNP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 10:13:15 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id F1FBC20B5F
	for <git@vger.kernel.org>; Thu, 11 Dec 2014 10:13:12 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 11 Dec 2014 10:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=JienXYJfsNJZ3IOinhLqcL
	+Z1sU=; b=AGz6aY798EczInixwiE0yLD4ETkMzXS+GzbVsaX2bbLKPNGGTQpK1E
	tQSRiyzburDX6JYGsEx8AWZzPZdyi1iKDakVi1+TqZ8EeF37K4IIXnmwfla4CJLs
	jqvUCi3qwOEUsptwqnOUnknEFNZUJwA6xEcV3O9tB5GdzQCcIa3FQ=
X-Sasl-enc: x1Uc5DKIWSKsEjbh2qYlQoHYhsg5etpY1uPeAE5EAugc 1418310792
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E4A596801B7;
	Thu, 11 Dec 2014 10:13:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141210010658.GD16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261280>

Jonathan Nieder schrieb am 10.12.2014 um 02:06:
> Michael J Gruber wrote:
> 
>> git-update-index --assume-unchanged was never meant to ignore changes
>> to tracked files (only to spare some stats). So do not suggest it
>> as a means to achieve that.
> [...]
>> +++ b/Documentation/gitignore.txt
>> @@ -138,9 +138,6 @@ NOTES
>>  The purpose of gitignore files is to ensure that certain files
>>  not tracked by Git remain untracked.
>>  
>> -To ignore uncommitted changes in a file that is already tracked,
>> -use 'git update-index {litdd}assume-unchanged'.
>> -
>>  To stop tracking a file that is currently tracked, use
>>  'git rm --cached'.
> 
> Makes sense.
> 
> But we need some advice to replace the paragraph you are deleting.  Is
> the idea something like
> 
> 	Git will not ignore uncommitted changes in a file that is already tracked.
> 	If you have time to work on that, please contact git@vger.kernel.org.
> 
> (perhaps without that second line)?
> 
> Thanks,
> Jonathan

I seems you're missing that info only because you know what used to be
there.

If you reread - trying to read only what is there now - you will see
that the text clearly says: gitignore files are about ignoring untracked
files to ensure that they remain untracked.

But maybe I'm somewhat professionally preoccupied :)

That is: Even if it clearly says it is about untracked files, it doesn't
hurt to say what it is not about (namely tracked files). It's just that
it is not about many other things either.

Michael

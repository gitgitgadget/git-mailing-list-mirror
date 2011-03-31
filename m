From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 15:55:54 +0200
Message-ID: <4D9487EA.4090507@drmicha.warpmail.net>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net> <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com> <4D948105.3050009@drmicha.warpmail.net> <AANLkTi=S9WUWHE8DZvQ2sxMLAJigi1wm3iU_PL5h4Mzd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:59:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5IPK-0007Sn-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 15:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785Ab1CaN7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 09:59:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37461 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894Ab1CaN7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 09:59:24 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1C7C5206B3;
	Thu, 31 Mar 2011 09:59:24 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 09:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WI7jZCbKNXvrCYu4qeZXSET+UIQ=; b=h5IovyaSaMekitWIXMk3Sy8MXMwWpGcpZ5g6eaEpfrQhEsCDOt45Jl81HWyMDLl00+xwrP4xJBTrSYJlxWOV9UKkafJ1qVKWmPldklzrKDrTdw+vdhxfLjT7Io+lvIDH7y2E6kMVIK0HxuxcwvzCePBomHX4mJ8c2OEwZau7wq4=
X-Sasl-enc: 9EgWsDRCoiNskPwyY7AYV1F2n9QSItUsG82AS2gEBfDJ 1301579963
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 60371401D7D;
	Thu, 31 Mar 2011 09:59:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTi=S9WUWHE8DZvQ2sxMLAJigi1wm3iU_PL5h4Mzd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170491>

Nguyen Thai Ngoc Duy venit, vidit, dixit 31.03.2011 15:35:
> On Thu, Mar 31, 2011 at 8:26 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>>> Tests please?
>>
>> Heck, we don't have any to begin with, and this is marked RFC. Given our
>> usual reluctance to change even undocumented behavior I'm not going to
>> bother with tests for an RFC.
> 
> Ugh.. I missed the "RFC" part on the subject. Sorry.
> 
>>>> As an intended side effect, users mistaking "git show commit -- path"
>>>> for "git show commit:path" are automatically reminded that they asked
>>>> git to show a commit, not a blob.
>>>
>>> Nor a tree. I don't really see how "git show commit:path" and "git how
>>> commit -- path" are relevant for it to be mentioned here.
>>
>> "git show commit:path" is relevant because that is what the OP was
>> trying to do, and "git show commit:path" is relevant because that is
>> what the OP tried and confused him because there was no output at all.
>> Not to mention that this is the command this patch is about.
> 
> Thanks. I see I also missed the original thread somewhere. Someone
> needs a sleep, me thinks :)

I'm trying with the coffee that I had suggested (seems to be working),
but I guess that decision (between coffee and sleep) depends on the
timezone also :)

Michael

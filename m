From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 21:16:34 +0030
Message-ID: <4d8e3fd30808221346g21999899s980be4411aabee0e@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
	 <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
	 <20080822182718.GQ23334@one.firstfloor.org>
	 <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
	 <4d8e3fd30808221311w7c507abboecd0893def85a073@mail.gmail.com>
	 <20080822203606.GB1598@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andi Kleen" <andi@firstfloor.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdXq-0006gT-Av
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYHVUqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 16:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYHVUqg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:46:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:25819 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbYHVUqf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 16:46:35 -0400
Received: by wf-out-1314.google.com with SMTP id 27so853624wfd.4
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MLAzvZ00nPSEhAW0JnTC+WinsSqo84+KaL2Y9zwXXCg=;
        b=WoSLskQZ6L2dLOLeyMSvia04/ajXNf8iK3bUxF7TDogqVIvH32TuffOE0oqywFLZDF
         AAo2/aQaIWxaiLu4NCeHxuoF5c6Xlsdniw4gyW5QOqx/FWvqniveBbJxsZ7ntaaXxS1f
         P2XAjBiIl0PYPl7599P1qWtYL58rc1BRcgiAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FQB1FJcN/zh0rpBUsqG92RkM5i1Uex1XrV9z0pjHbqWxK1nGWVPAQM7E7UkpC9vXnB
         zjMKgcLOyM2mMli88eVvjXkTdLyG3CvcKCitkGpXGsom2IEB5lVd94CiZGwpozcVui/m
         r9/G8FIFiV4xJXvmEHKFMfK0DazrEc2upR1+A=
Received: by 10.143.6.19 with SMTP id j19mr545473wfi.330.1219437994400;
        Fri, 22 Aug 2008 13:46:34 -0700 (PDT)
Received: by 10.142.194.8 with HTTP; Fri, 22 Aug 2008 13:46:34 -0700 (PDT)
In-Reply-To: <20080822203606.GB1598@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93360>

On 8/22/08, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> On 2008.08.22 22:11:42 +0200, Paolo Ciarrocchi wrote:
>> since tip/master is often rebased (as pu or linux-next) what I do is
>> the following:
>> git branch -D tip-latest
>> git checkout -b tip-latest tip/master
>>
>> but I guess lot of people would expect to "throw away" and "checkout
>> again" with a single git command.
>
> git reset --hard tip/master

good point.

> or just don't create a local branch at all and do testing on a detach=
ed
> HEAD, ie. just:
> git checkout tip/master
>
> That works after each fetch.

yes, that's the same suggestion that i got from linus.
Thanks Bjorn, Linus.

these hints should probably get some visibility in lkml as well.

ciao,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/

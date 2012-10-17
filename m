From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Can git pull from a mercurial repository?
Date: Wed, 17 Oct 2012 14:44:00 +0200
Message-ID: <CAMP44s2DtMfeDQqgQfBamC3ZpbssnRrzveqP5nQ6Sehaw4+oVQ@mail.gmail.com>
References: <k39lir$gpm$1@ger.gmane.org>
	<50585F10.3080307@op5.se>
	<000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de>
	<37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 14:44:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOSys-0000qW-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 14:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab2JQMoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 08:44:01 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56112 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab2JQMoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 08:44:00 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7337118oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KYnIGC9+2+E/1sklRoaJLi82jsndyuk13sP8bHk24LQ=;
        b=ro5VGNrbdhNPJHT6aJ/jJN8Tl6hoEbrFfx0NPgxCRcX5EEhz0Vcrff1UNUhX0D3qJY
         LbtcvDv7pO9e8FqshmAD4BZZ8EZZJx37BtJ1BeCYNFRaNOLPb/elzpdgdkSBu8+jKCxI
         UC5/j7CrvMSAR9OQLUSyF0Qxdc9/qp9V2Db14m6FyYXd2nGa4+ammP7DqVfM+be/l/0M
         7X9gx65mCAWIPxn9GJobZnKqEVmXtFtYd7saS75fLJif3Q8ckuajmGrUnasg5qL4Azde
         jcEhJ/GejTNobXmmouWgZm6qhIxJ3JIiIVAfUQl42b+E/888DjTn0fAzHmRSA1/ECJkV
         jJuA==
Received: by 10.60.170.179 with SMTP id an19mr10261839oec.46.1350477840121;
 Wed, 17 Oct 2012 05:44:00 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 05:44:00 -0700 (PDT)
In-Reply-To: <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207915>

Hi,

On Tue, Sep 25, 2012 at 4:15 PM, Max Horn <postbox@quendi.de> wrote:
> On 18.09.2012, at 14:40, Joachim Schmitz wrote:
>
>>> From: Andreas Ericsson [mailto:ae@op5.se]
>>> Sent: Tuesday, September 18, 2012 1:46 PM
>>> To: Joachim Schmitz
>>> Cc: git@vger.kernel.org
>>> Subject: Re: Can git pull from a mercurial repository?
>>>
>>> On 09/18/2012 01:22 PM, Joachim Schmitz wrote:
>>>> Is there an easy way to get git to clone/pull from a Mercurial repository?
>>>>
>>>
>>> Yes. Google "git remote helpers" and you'll most likely find it.
>>
>> Well, I found a few. No idea how to get them to work though (so far for the 'easy' part of my question)
>
> I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git repository. A converse to hg-git <http://hg-git.github.com/>
>
> As you discovered, there are several attempts to this. A recent overview over some of them can be found here:
>
>   https://github.com/dubiousjim/yagh/blob/master/README.md

And here's a new one:
https://github.com/felipec/git/blob/fc-remote-hd/contrib/remote-hd/git-remote-hg

I took a look at several of them, and none satisfied me; too
complicated, depends on another tool, hard to install, etc. This one
is simple, and works fine. Only for local repositories, and only for
fetching at the moment, but it's easy to use, and doesn't require much
to install.

I think it has good chances of getting into git mainline, and
hopefully other people will help adding the rest of the features. The
code is not hard at all :)

Cheers.

-- 
Felipe Contreras

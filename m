From: Sebastian Staudt <koraktor@gmail.com>
Subject: Re: Anybody know a website with up-to-date git documentation?
Date: Wed, 30 Jan 2013 14:48:47 +0100
Message-ID: <CA+xP2SYNATf+UZ0MFucLUw7BZFg1G4J6XqYwJQ5f4fkanzGcHg@mail.gmail.com>
References: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de>
 <20130130115439.GH1342@serenity.lan> <CA+xP2SbWKucCCPq3sS8Y2DQQM129urrM7-QzeDYju4+wA_-aUg@mail.gmail.com>
 <72077344-E4EF-43E1-A9E0-A907C423616F@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 30 14:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Y2y-0006hH-4a
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 14:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab3A3Nta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 08:49:30 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:65039 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab3A3Nt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2013 08:49:29 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so1634838wib.13
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=n1F3cwH4/kNsKnkJdco7NdaurjCwFHdaM4W/5OBJjbg=;
        b=GcX5G27KxG4zqtDh5v1QUjllDGq1X5EvcOwYYt7p01S0cxItfpLTXNUgIxUFROeIPB
         JImoyKHZmPE2lm8gbv3YRhsmlU0sVrqLPwJN7ikDkYzkkyga6TP71H5kpswmec0Sw6AX
         iyQxxJoUOkxjr2Otuvz1ufsdl5eO89pjaXHxg7TtbnJLuUArtAVSiUMrUh/SK3es5Gpp
         aqVEB/2UVfKl4x4y8bfhv0uQcD0n+17gdyRQUm08QG1OnvcLtNflShKP9xkUgfBGjUi1
         xDQqg9ZT8sWuSMHglcUajmO0TCkGo+HrLoCuqUUnVUAoJPoxJqTB6qiTHxED1VMrB04b
         XdlQ==
X-Received: by 10.194.238.226 with SMTP id vn2mr9089586wjc.23.1359553767844;
 Wed, 30 Jan 2013 05:49:27 -0800 (PST)
Received: by 10.216.113.196 with HTTP; Wed, 30 Jan 2013 05:48:47 -0800 (PST)
In-Reply-To: <72077344-E4EF-43E1-A9E0-A907C423616F@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215016>

Hi Max,

it seems that this is some sort of caching problem on git-scm.com.

I saw you've already opened an issue at
https://github.com/github/gitscm-next/issues/232.
So there's probably not much you can do right now.

And I don't know any better source for documentation right now, apart
from the locally installed HTML version.

Best regards,
    Sebastian

2013/1/30 Max Horn <max@quendi.de>:
> Hi Sebastian,
>
> On 30.01.2013, at 12:56, Sebastian Staudt wrote:
>
>> Hello Max,
>>
>> git-scm.com is the best source and it's not outdated.
>
> Then it seems you are using the word "outdated" in a different way than me which I don't understand :-). Sure, it strives to be up-to-date, but fact is that it fails to do that, due to a bug (I guess). The end result (failure to update at all, vs. failure in an attempted update) sadly amount to the same.
>
>> It gets an
>> update after every single release of Git.
>> See e.g. http://git-scm.com/docs/git-config which was updated in the
>> current stable version.
>> It seems that git-remote-helper's documentation was just not updated
>> since version 1.7.12.3.
>
> Yes, and it is not alone in that, which makes the site somewhat unreliable, sadly. Some more examples of pages tuck at version 1.7.12.3 and showing outdated content:
>
> http://git-scm.com/docs/git-log
> http://git-scm.com/docs/git-merge
> http://git-scm.com/docs/git-merge-base
> http://git-scm.com/docs/git-mergetool
> http://git-scm.com/docs/git-reset
> http://git-scm.com/docs/git-rm
> http://git-scm.com/docs/git-status
> http://git-scm.com/docs/git-symbolic-ref
>
> I did not bother to check every single page, though, and I am pretty sure there are plenty more. Because there definitely is a plethora of other pages that are stuck at 1.7.12.3. Several of them still show the latest version due to not having had updates since the 1.7.12.3, but that is not always easy to tell due to included files (e.g. git-log.txt was not changed v1.7.12.2, but it includes rev-list-options.txt which was last changed in 1.8.1).
>
>
> So, yeah, I do think git-scm.com is outdated -- in the sense that for many pages, it does not show the latest officially released version of the page.
>
>
> Best regards,
> Max

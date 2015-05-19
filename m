From: Junio C Hamano <gitster@pobox.com>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Tue, 19 May 2015 15:12:31 -0700
Message-ID: <xmqqiobop67k.fsf@gitster.dls.corp.google.com>
References: <20150519132958.GA21130@frolo.macqel>
	<xmqq617oa75l.fsf@gitster.dls.corp.google.com>
	<20150519214719.GA12732@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Wed May 20 00:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupkc-0001uU-Vx
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbbESWMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:12:35 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33788 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbESWMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:12:34 -0400
Received: by igbpi8 with SMTP id pi8so118924419igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=G20IhueRhu/Zm73odvbEO+JAFxzt35NHWNDiT36G9sI=;
        b=fgoAk0LfKZ2j5fUgJO13Mg48z1gxHg8W6hs89QRvWV45YTcCNppOLg8+be6ocVefm3
         RICF/uTHD9G782wujNMbI9KB5/x1QujMN29zzsWPsn4+KdUEZ1rGTcHddLF4LagV8NGz
         eE7maH5M6qGFYoOZmlBWtPo64CqMBvz0FXdp9iXAlLl9Yy59TIT8eoiAibm842WEj74Z
         XePn792Kowj84xiYpZOmikwU9quknSVp7ojCsL/1+xACOR3Sm/NSLxE4SVi2n4lz75qH
         PIPw3pG8OTTkNwGKncM+X/hKfBbXbfc53C3fqp99njz2LpBfqfTQtWm1TXQY1Qhczpw2
         dJDA==
X-Received: by 10.42.129.73 with SMTP id p9mr6995392ics.48.1432073553538;
        Tue, 19 May 2015 15:12:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id cy11sm183933igc.14.2015.05.19.15.12.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 15:12:32 -0700 (PDT)
In-Reply-To: <20150519214719.GA12732@frolo.macqel> (Philippe De Muyter's
	message of "Tue, 19 May 2015 23:47:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269417>

Philippe De Muyter <phdm@macq.eu> writes:

> On Tue, May 19, 2015 at 09:01:10AM -0700, Junio C Hamano wrote:
>> Philippe De Muyter <phdm@macq.eu> writes:
>> 
>> > Trying to understand, I have eventually done "git log" on my branch and
>> > on v3.15 with the following commands :
>> >
>> > git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
>> > git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits
>> 
>> Either
>> 
>>     git log --oneline v3.15..HEAD ;# show what I have not in theirs
>> 
>> or
>> 
>>     gitk v3.15...HEAD ;# show our differences graphically
>
> This shows the commits in my branch starting from the most recent common point,
> thus my commits, but I see differences in the files not explained by my commits,
> but by the fact that many older commits (between v3.13 and v3.14) are missing on
> my branch, but still in both branches I have a commit called v3.14 with the
> same hash.  Is that normal ?

Sorry, cannot parse.  Neither of the above would show files, so just
about the place where you start talking about "I see differences in
the files", you lost me.

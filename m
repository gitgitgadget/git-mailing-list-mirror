From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Tue, 3 Nov 2015 08:09:53 +0100
Message-ID: <CAP8UFD04C-Amt2vGQKrJmA=DYVXrR7+hhkk9e49NsT-F0wiV1Q@mail.gmail.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
	<1445990089.8302.27.camel@twopensource.com>
	<CAP8UFD3rkacENsnthdhqTPczbZP+J_iV6xr8sTXj2MFgZRx8DQ@mail.gmail.com>
	<1446497776.4131.6.camel@twopensource.com>
	<CACsJy8AC1B+b_KBBcob07LkAkjjiwFQCLnMcgX0iUdQeNdeLfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Luciano Rocha <luciano.rocha@booking.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtVl7-0006sj-5u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbbKCHJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:09:56 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32781 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbbKCHJz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 02:09:55 -0500
Received: by lfbf136 with SMTP id f136so7366673lfb.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 23:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4imJPfyZmQDoW5sQn2dpN+zrd9D84pwHYMJ8vXESxhc=;
        b=IqdAyXFW9/Dl0FpKa0afPBzxTk3PKnxAzVI4d6hg4zAVMNW6FltA5w/CqySM1nz4oE
         75+dWNrrFwwPEeB14C/N2E3vWRdXPWSebBzFI6XHv8vxpqzhRiLikLfNEvjl1aNsUo+p
         FxJ0GAboizqTEdJkRvS4sLclsVFjoD0J6Mag+UcTI4CzZhRA0y4xhqQwxS4aEMnzNL4o
         nghZ94FWpJQh6dZecA5MrgdckJkU73toOB17OshsmJdgQci2lIv1LQd9GLng90fC15nv
         0gna8pvojFT9i9Gb/gVn6VnN4pkwQ7rqb9UIXa31t73Fec2uZf7OE9EPAtlGReJSfZxh
         4IXg==
X-Received: by 10.25.166.140 with SMTP id p134mr7981578lfe.114.1446534593785;
 Mon, 02 Nov 2015 23:09:53 -0800 (PST)
Received: by 10.25.42.18 with HTTP; Mon, 2 Nov 2015 23:09:53 -0800 (PST)
In-Reply-To: <CACsJy8AC1B+b_KBBcob07LkAkjjiwFQCLnMcgX0iUdQeNdeLfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280752>

On Tue, Nov 3, 2015 at 6:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Nov 2, 2015 at 9:56 PM, David Turner <dturner@twopensource.com> wrote:
>> On Thu, 2015-10-29 at 09:10 +0100, Christian Couder wrote:
>>> > We're using Watchman at Twitter.  A week or two ago posted a dump of our
>>> > code to github, but I would advise waiting a day or two to use it, as
>>> > I'm about to pull a large number of bugfixes into it (I'll update this
>>> > thread and provide a link once I do so).
>>>
>>> Great, I will have a look at it then!
>>
>> Here's the most recent version:
>>
>> https://github.com/dturner-tw/git/tree/dturner/watchman
>
> Christian, the index-helper/watchman series are posted because you
> showed interest in this area. I'm not rerolling to address David's
> comments on the series for now.

Ok no problem. Thanks a lot to you and David for posting your rebased series!

> Take your time evaluate the two
> approaches, then you can pick one (and let me know if you want me to
> hand my series over, very glad to do so).

Yeah, I will do that, thanks again!

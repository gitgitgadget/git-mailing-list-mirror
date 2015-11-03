From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Tue, 3 Nov 2015 06:45:22 +0100
Message-ID: <CACsJy8AC1B+b_KBBcob07LkAkjjiwFQCLnMcgX0iUdQeNdeLfQ@mail.gmail.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
 <1445990089.8302.27.camel@twopensource.com> <CAP8UFD3rkacENsnthdhqTPczbZP+J_iV6xr8sTXj2MFgZRx8DQ@mail.gmail.com>
 <1446497776.4131.6.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Luciano Rocha <luciano.rocha@booking.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: David Turner <dturner@twopensource.com>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 06:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtUQQ-0005xe-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 06:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbKCFpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 00:45:54 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33405 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbKCFpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 00:45:53 -0500
Received: by lfbf136 with SMTP id f136so5829270lfb.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 21:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5bsKzjGwlyIjL5TPgKnT2aOhXKaAuLk1dhBa2VRtNZ4=;
        b=ity+Zzp0EUkTu59wLdgtbGhc1KFT/iZ60gCVZKw8+iUFKjEdu0301fb2t5GJvyoXcL
         9XUVv3oCgonEvVO5JlWddw7f5iQytop04zKqRYuEEOWqi8SUucE/hQx3jyRAjFGA3PIj
         1+G1/zp1Rs9fVSUQyaDBnpMmXeiTHYlCdGx8ZLt99dEKbf6gQ/mKlbKFvpBk35GNBJxN
         hABfF5RKp/G2L8EbsfwqXjmwMyGdiqWlFEKfz3fMWwtR2Gf1Ph9t7fTYN6lbBJHyWKsK
         /vB9FgVlfOnSoTI1qsIKi+A4hLmnRLMfKmQFncZ6pDZaH1wdf6Keas2oyQEZygecf+19
         kLFA==
X-Received: by 10.112.202.194 with SMTP id kk2mr11456574lbc.71.1446529552262;
 Mon, 02 Nov 2015 21:45:52 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Mon, 2 Nov 2015 21:45:22 -0800 (PST)
In-Reply-To: <1446497776.4131.6.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280748>

On Mon, Nov 2, 2015 at 9:56 PM, David Turner <dturner@twopensource.com> wrote:
> On Thu, 2015-10-29 at 09:10 +0100, Christian Couder wrote:
>> > We're using Watchman at Twitter.  A week or two ago posted a dump of our
>> > code to github, but I would advise waiting a day or two to use it, as
>> > I'm about to pull a large number of bugfixes into it (I'll update this
>> > thread and provide a link once I do so).
>>
>> Great, I will have a look at it then!
>
> Here's the most recent version:
>
> https://github.com/dturner-tw/git/tree/dturner/watchman

Christian, the index-helper/watchman series are posted because you
showed interest in this area. I'm not rerolling to address David's
comments on the series for now. Take your time evaluate the two
approaches, then you can pick one (and let me know if you want me to
hand my series over, very glad to do so).
-- 
Duy

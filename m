From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sat, 7 Sep 2013 19:58:15 -0500
Message-ID: <CAMP44s3OyhHYv7JXf6UH1DnTWPTnD+15EZTnAmSvGb6BE1OdzQ@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<522a754cee731_382e8cde804656@nysa.mail>
	<CAJDDKr4JBeccwuD4PVq0ryO27Eyfz+yUAHT7xm0Dkh19SZpV4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 02:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITKb-0000W7-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab3IHA6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:58:20 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57605 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3IHA6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:58:20 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so4008878lbd.12
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 17:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/mVU81iyLi0OGKc+LjlwjU2p7MvBSrzfHCslA5FvMj8=;
        b=Gufll0JLIwuGgu+6XovCyWo2lEqQn1xjg4/BFba67WqhWo8U6DdGjh/PejHMog2dyf
         V5l5wvjN1lfAEwAqdE9TfFHTzXS5GEg0OwBXcukJViGQTkmhd1qwDpQTO2v2cJNvBrxw
         XIIKxvaGa+y64VLgvynP/DwXCkAmJipqZI0s5qguWBhFmPs0edlXTwFSeGdpyvYE0uWl
         i4UWLPd+N9xUExL/k4LmDDIimiSAaoV2ttE6UfjNJeDYSVWg+RGV1tQaPtwGsl03fqU4
         Lp8fXW3CQnFrQIrXz9Wtz1TiwlNV8E0LqLWqARm4EC27KUeVfCS8UZPW0jh3BFX/UruX
         GTLQ==
X-Received: by 10.112.42.103 with SMTP id n7mr9624419lbl.6.1378601895964; Sat,
 07 Sep 2013 17:58:15 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 17:58:15 -0700 (PDT)
In-Reply-To: <CAJDDKr4JBeccwuD4PVq0ryO27Eyfz+yUAHT7xm0Dkh19SZpV4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234155>

On Fri, Sep 6, 2013 at 11:30 PM, David Aguilar <davvid@gmail.com> wrote:
>
> On Sep 6, 2013 7:51 PM, "Felipe Contreras" <felipe.contreras@gmail.com>
> wrote:
>>
>> Junio C Hamano wrote:
>> > Sebastian Schuberth <sschuberth@gmail.com> writes:
>> >
>> > > For custom builds of Git it sometimes is inconvenient to annotate tags
>> > > because there simply is nothing to say, so do not require an
>> > > annotation.
>> > >
>> > > Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>> > > ---
>> >
>> > Hmmmm, personally I'd actually want this to stay the way it is, or
>> > even require a valid signed tag, in order to make sure I won't
>> > mistakenly creating a lightweight tag.
>>
>> So the only user Git should care about is you? If Git can make _you_ more
>> confortable not making certain mistakes, then that's the way it should be?
>
> Yes, certainly. Why would you think otherwise?

The whole purpose of a public software project is that it's useful to others.

>> What's the point of lightweight tags anyway? 'git describe' doesn't use
>> them,
>> GIT-VERSION-GEN neither, just remove them already.
>
> RTFM

I don't see anything in the manual explaining why lightweight tags are
useful, if all the Git tools just ignore them, and why the do that.

>> For the vast majority of the people out there, a tag is a tag. Period.
>
> Not for me. You are wrong.

You are not the vast majority, you are a single person.

-- 
Felipe Contreras

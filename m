From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v12 5/5] commit: add a commit.verbose config variable
Date: Tue, 5 Apr 2016 21:28:40 +0530
Message-ID: <CAFZEwPNQE82_A39sO7z--3sR74GwF-HEgHTePmN_DbFgFmgKgQ@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be81-1859e6e4-81e4-473f-a2fa-7e27305b4e3e-000000@eu-west-1.amazonses.com>
	<CAPig+cTYHFyDXJ2ZECtje2OG-ObT04gnQw+0+LbMMVO51bx2fg@mail.gmail.com>
	<CAPig+cQdAbweFF7NWJhNjALXN5cdpE-gtvZ_LB0tVmLJ2XGLiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 18:02:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTNT-0001MU-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 17:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759439AbcDEP6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 11:58:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34811 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759434AbcDEP6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 11:58:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id f6so2483286ywa.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8dihlT9PjINB3wl78ZCG9XfnuATd0k8OEiPWDXAAn6o=;
        b=Rbt5On54SrbZ075Eiqc2c99vGZPVsvy4SbRU8Si69BdDl4PW6PqXCAx+TinlnwLDMs
         2dL2dYio3xp1uSDI3SApaMy+EtcxJtsatQlyjs4IRkJkrmRXt52MIutV65IJt1aRFHEF
         yP/lv8gtPD6tE41tSbmta2ViI9Y//S2NXNz6akHL7MNriXHIIuOQNyxXtkLPTjCAvPCi
         Tcw6qXDdIS6eWB+nEaxF4D2RfZxE1Sei/WQMCqbNgyrQaqCwzui1v0agcxiPxU+k8WyP
         NK30QlruTXpzL7M45qWSJe7xkMuEG2FFkt3VoVSLaMHQ5FfrYou+C+5FgP/6hBL+tQwQ
         OHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8dihlT9PjINB3wl78ZCG9XfnuATd0k8OEiPWDXAAn6o=;
        b=KtKhVvrzGVrcNRxyA5Z1trse6XV7xdTO7WEFQrlUwhgf7ITeDk8AvOQI6OQnenYsTe
         bWrvhq0cqSqHKbf93wroRvIlEfdALj7Y8U8WKsxzM1pkSO5A4xVY8C/HMjq2BFbcW2Tt
         PW0jsNOIDbeoJmF/nVZfSO8wwCAaYqtmBmQaKDQRszwFDm/AIVaVavsIJhKFfMERZW1E
         V8wet2oocgo1Gr+h04i7FT6H90MiqkZn8mfjo7ULbG6IH5VtInJqx9wwp2DWaLpLmQAl
         CViFRr1AFktF0gOYOIoC1vDA3/irB55STgSrRBcti3s04+H5AuP5YZwkMEkT47p5yRgn
         gUqw==
X-Gm-Message-State: AD7BkJI63sW+1akIzWQLuRrNT/wymRsTBk41MFsjdFYr7EpbwSLdgfN3fa8knB0Zo6r38D7haYK9mxoCYEY7zA==
X-Received: by 10.13.252.67 with SMTP id m64mr24489330ywf.67.1459871920447;
 Tue, 05 Apr 2016 08:58:40 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 5 Apr 2016 08:58:40 -0700 (PDT)
In-Reply-To: <CAPig+cQdAbweFF7NWJhNjALXN5cdpE-gtvZ_LB0tVmLJ2XGLiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290789>

On Tue, Apr 5, 2016 at 4:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 3, 2016 at 8:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The fact that the 32 new tests are nearly identical suggests strongly
>> that the testing should instead either be table-driven or be done via
>> for-loops to systematically cover all cases. Not only would either of
>> these approaches be easier to digest, but they would make it easy to
>> tell at a glance if any cases were missing. See [2] for an example of
>> how the tests can be table-driven, and see the bottom of [3] for an
>> example of using for-loops to test systematically (though you'd need
>> to use nested for-loops rather than just the one in the example).
>>
>> I'm leaning toward systematic testing via nested for-loops as the more
>> suitable of the two approach for this particular application.
>
I hadn't thought of this before. I also believe using for-loops will
make it more clear, crisp and will avoid the effort of going through
the whole patch to find out if some test is missing.

> By the way, while this would be a nice change, it doesn't necessarily
> have to be part of this series, and could be done as a follow-up by
> you or someone else.
>
> (The other changes suggested in the same review, however, ought to be
> fixed in this series; in particular, simplifying the "setup" test and
> making the first test after "setup" consistent with the remaining
> tests.)

I will include it this series only as it will be a bit easier for me
to keep a track of the previous reviews.

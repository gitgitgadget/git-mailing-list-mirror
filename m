From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Working towards a common review format for git
Date: Fri, 8 Jan 2016 09:53:53 -0500
Message-ID: <CAD0k6qQBcfq0++d=-uyGpakmd+bsxuWYUWcn8auYJPy_HLddTg@mail.gmail.com>
References: <20160108140831.GA10200@salo> <CAD0k6qRFPMZxLh4MtwkXwrk4GCjf64vWEd=9NPn-t_-uVHWz9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Edwin Kempin <ekempin@google.com>
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 08 15:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHYQj-0000nB-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 15:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbcAHOyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 09:54:14 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37034 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbcAHOyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 09:54:13 -0500
Received: by mail-ig0-f170.google.com with SMTP id h5so35924626igh.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RZ/k4I8XsOBGC0BrX1u9yWEl94pWJxWKUlZbzsLYlXI=;
        b=L0K+i1Yf+hDmFyc3l1nH/GrjUQhuVg7rypkh3UwtjDJA7aYJolSXW02zPcoYfEhHGj
         3K5mbI/lYbAB5b9PHQNJ/MCC/l37B6Fc9C3yzHoGkPZ2pqPZBuVYjiAhqtk5xdTZaKss
         x4KU3gOzB/enbviztTQ9jLt0CuglewIgvOumixBIWF4FSdHCA88POImJr8oiCPn9RsXt
         3i+EaHTPcv3lpPLLw7V6FbH4Ic96TYHotjJAas+b+fj15CnJ0h2WpYSiMXCwx0LNCpI+
         mN3qbTZu7J2WcaAq73H37f8Ya5L5EJ/GjJubapBUCOZTDqCuaeMndy/rVti5/+wT3kVA
         GTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=RZ/k4I8XsOBGC0BrX1u9yWEl94pWJxWKUlZbzsLYlXI=;
        b=b8QV6MIjDD9Yvjt/CjQx/wVDaH7Evn/7ol0WPYe6S3cv65IthQc0rEMqk0oeQ3FWJV
         EKjuAX/nHTjHkZoHHN60LucUULjugNr5S0WcgMP8ocie4GEgBYr/eUooJJoVHApRUqmB
         22gaWNlbRkv99Hp8pHOwlhTEci7XtA37/C773IPSRw6ShrjWJWqRyTbroKumUOiNM+uX
         oPxtJJcVGdTcE3txApZAukGM80oTyhB0MyF7JdI2f7ZcrRsE/pKGqpGd9EwF/la+QTZI
         UH0FPbJTFU+bAyk38GHLc832OuX2pPTpkayE7E9neBcmSIqTu7gPb8TKMGc1Kk9Xn0KK
         ve0Q==
X-Gm-Message-State: ALoCoQkHFYnqhvWCdpz2DEJHbB3+nDPez6sqPVlLMPVoRr9GFVQnefx8Futlx6NOQttgnKYFuazrQb+pV3P+P3BL4ocQfXmBaHTO3nfvTDFhPrXfLj97TdY=
X-Received: by 10.50.79.202 with SMTP id l10mr22854286igx.46.1452264852777;
 Fri, 08 Jan 2016 06:54:12 -0800 (PST)
Received: by 10.36.122.193 with HTTP; Fri, 8 Jan 2016 06:53:53 -0800 (PST)
In-Reply-To: <CAD0k6qRFPMZxLh4MtwkXwrk4GCjf64vWEd=9NPn-t_-uVHWz9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283555>

On Fri, Jan 8, 2016 at 9:24 AM, Dave Borowitz <dborowitz@google.com> wrote:
> On Fri, Jan 8, 2016 at 9:08 AM, Richard Ipsum
> <richard.ipsum@codethink.co.uk> wrote:
>> Hi,
>>
>> In a prior email I mentioned in passing a library I've been working
>> on to try to reach a common format for storing review content in git:
>> perl-notedb.[1]
>>
>> I'm making reasonable progress with this but my work has uncovered
>> necessary (and trivial) modifications to Notedb, the first[2] is a
>> trivial modification to ensure the 'Status' trailer gets written
>> to the commit when a change's status changes.
>
> I would consider this a bugfix, and will respond on that review.
>
>> The second[3] is an RFC
>> where I suggest adding a 'Commit' trailer so that it is always
>> possible to reference the commit under review by its sha.
>
> I think this is probably fine but I'll have to think about it some more.
>
>> With these patches applied to gerrit it's possible for perl-notedb to parse
>> all meta content from notedb and map it to the actual git content
>> under review. However, my concern at present is that I'm already
>> operating under a fork of notedb which defeats the objective of
>> collaborating to produce a standard format, let's try to avoid[4]
>
> I hope I can assuage some of your concerns by saying that since Gerrit
> notedb is such a work in progress, literally nobody is running it in
> the wild, so even if the formats diverge temporarily I don't see it as
> being a long-term issue. But thank you for caring about it, I do
> appreciate your proactive considerations.

You know what would probably also be a good idea would be to spec out
the entire format in a standalone document. That way when Gerrit
doesn't have something implemented, it's clear that Gerrit is wrong,
not that it's trying to fork the format.

>> If the gerrit folks could let me know what I need to do to get
>> these modifications merged, or else what we need to do to achieve
>> equivalent functionality I'd really appreciate it.
>>
>> Thanks again,
>> Richard Ipsum
>>
>> [1]: https://bitbucket.org/richardipsum/perl-notedb
>> [2]: https://gerrit-review.googlesource.com/#/c/73436/
>> [3]: https://gerrit-review.googlesource.com/#/c/73602/
>> [4]: https://xkcd.com/927/

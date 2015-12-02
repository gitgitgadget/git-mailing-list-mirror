From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v8] Add Travis CI support
Date: Tue, 1 Dec 2015 16:56:58 -0800
Message-ID: <CAGZ79kYD4XU94pG+K_SR07oP1knukpkvPWZANp_t1tWxYuTEOQ@mail.gmail.com>
References: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
	<20151128171223.GD27264@sigill.intra.peff.net>
	<A529A168-CC08-4F8F-B46D-3DF5EAA8EBB9@gmail.com>
	<20151202004524.GB28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:57:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vjE-0001NA-QD
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 01:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbbLBA5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 19:57:00 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35550 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbbLBA47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 19:56:59 -0500
Received: by ykba77 with SMTP id a77so29308768ykb.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 16:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AC3amTRvQ2zpcpMagfMVym2w2tZGaI+iXCLdZKCoifc=;
        b=ABmockYuywn3sM7cc5d/9D75+Kjvfl4C7ko/9+wFPicK9aQD1BhbA+wfXYaYsWiMIU
         5b9CJ6F8v5oFh53QlZKvS1LEoIphWM4k2NVvn0g3+C28zzYo+undaFXUHTLdNYe0QUzx
         yEEip95Dfg4PmJlHXbDqIEK+mHeGV9QMnHQSlihaxUHAci1xu8bn+f+FPVvlPkYolide
         BiAWA4dplRrya5/eK5/8DbbucBBiWAqb65/uti5QUa8KdMChGR2/9p72ZYhXcM/68kti
         JIZhVp77w2bKrVaHELAYrWQJyP2q+i52FekHu2fOwS83ORd5XBfjtR6PGuRojRCedc+O
         Q5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AC3amTRvQ2zpcpMagfMVym2w2tZGaI+iXCLdZKCoifc=;
        b=RqVVNNhis3sLgWtYjAadwqOItIgRZO8dM8+OwMKHxzsxI0plABqmaNylVJpmMJfC61
         snRO6x0wyX6yRYLgo3vgdLSZsBrRpQg9co5QJxitZ3iLquWvRoPvwXsFQ5m2KZ7jE7P7
         Gw0kSN28KC54RRsQuSs3MpZulhXtibgRTGtGdpRSQnpU/w6O5hd/6gu46pOsV60gOA2q
         rs0i/dwnx8ArjoYCuj2EeTB6v4ef00mWzxgLiULC27Ssj3hRO+ZZkAWFQW2KkUdQDrNe
         1fxLrFDgPDeryJyN/tvIaBGSfKnrnvG2tISVR0JjFe10Q8bgOgqoKzob4JT9ftDVFq8s
         j7HQ==
X-Gm-Message-State: ALoCoQnsjoczprSfnWcEgQPbjgFy9LqwYtdce5aZ4gb5Rs2afFAq9FHOMHOWQSqXbQcHgQNvXoB0
X-Received: by 10.13.221.21 with SMTP id g21mr307327ywe.320.1449017818639;
 Tue, 01 Dec 2015 16:56:58 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Tue, 1 Dec 2015 16:56:58 -0800 (PST)
In-Reply-To: <20151202004524.GB28197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281871>

On Tue, Dec 1, 2015 at 4:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 01, 2015 at 09:43:45AM +0100, Lars Schneider wrote:
>
>> > Thanks. I don't have any other comments on this one. I guess the next
>> > step is for me to get git/git signed up for Travis, and then merging
>> > this to 'master' will have the desired effect.
>>
>> Thanks! You're right, signing up git/git for Travis should do it.
>> Right now it is configured to build all branches on git/git that
>> contain a travis.yml. That means if you merge it to pu or next then we
>> should see builds already.
>
> I merged to 'pu', and signed up peff/git, and got a build. Incidentally,
> something in pu causes a bunch of tests to fail on OS X (but not Linux).
> :)
>

:)

As I currently maintain a the regular coverity scan and just
remembered that it integrates with travis[1], we may want to look
into that further, too.

[1] https://scan.coverity.com/travis_ci


> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

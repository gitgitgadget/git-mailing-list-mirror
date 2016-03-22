From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/16] git bisect improvements
Date: Tue, 22 Mar 2016 08:35:33 +0100
Message-ID: <CAP8UFD1wneDoLcQp0R-8Y17V0Tzo6d_hxY=k8v5dKOgP10ecRA@mail.gmail.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<CAFZEwPPon1q_iW_xNfmVxiQhyaQh_pZpk2jzoyzi3RjJd998pg@mail.gmail.com>
	<56F07434.8090005@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 08:36:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiGrH-0000i2-F8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 08:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbcCVHfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 03:35:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36472 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013AbcCVHff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 03:35:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so27378711wml.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=p5KDDQj34dZ7HLMDiF1Tfg/RF6kFVHJb2Ph8+xBy1tI=;
        b=Jdn4M8Pyn0f67US39cksWqSnhyKYtHsKi4rc9+iY2MQ5ho3QIs4zXUo0RljPmghHjF
         fS2cl/KlYynWf8HS90mcHOnMCDsAmNQ7oolP8IwGz8YzmwHeEfm8wv85dI6+5cP6JrBM
         vs3wdopBKma/TyfLHwrsJ7bslflC+vc8idR/TrmyL39naliZoNVfwHWQxeIc2Bx2oJNO
         Oj7y+qHZmNPwTlk9LA6hTNLbykJ4AFKrwTryBcbIvAFDm0YQ9qGXcZCXXUwc3Li6Ajwt
         QyF9e/55MAZOKZrVR2Vp6lvqKyWtZJWgDWYGWoCVOc7hQrUsAFB1UPRivhOleEdFmpEe
         4Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=p5KDDQj34dZ7HLMDiF1Tfg/RF6kFVHJb2Ph8+xBy1tI=;
        b=UI3QfKgM5pqXDv6cIUiMWvnBpUHAJZ7BWZ7ALbjS7nzPJ3KIOpzbR/GYEXJFI9Avtk
         Lvu19bgAhI9C7MyKa5cV5eEOMYTBbg1W/tEq934RLgjRi2n7etJ3e0nAs8CASsl0S/xh
         ePHmJpcczo3a41siWN+ps2+6dkhcbypwkJb9c9xZS6cGWlEvSakAyP82a4gji5yqA9QQ
         4WlLn4YahuW4b9q8beziYOtk5Xfkn70pmip0MhGqjcKb6jAgtIqnVZjAI5cg4uLitCV6
         BLuzdGoH7Qd6dqEa2RFVSzxnXAnECYLXwwK962SVtDovpZN/L9MIDA/f281NcPDqyhxM
         HKgA==
X-Gm-Message-State: AD7BkJK/9N+ryUv9EH55D8HOpANMWixkXXjCcDs8t7OHqSwzXvFPfqJynAKklcXuk3uT9qp8aPpkYZxApTsZHQ==
X-Received: by 10.194.60.200 with SMTP id j8mr34084341wjr.124.1458632133573;
 Tue, 22 Mar 2016 00:35:33 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Tue, 22 Mar 2016 00:35:33 -0700 (PDT)
In-Reply-To: <56F07434.8090005@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289490>

On Mon, Mar 21, 2016 at 11:22 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> Also sorry, I am not following the list so I didn't know there was a
> GSoC project for bisect.
>
>> If it is okay with you then can I work more upon these
>> patches in my GSoC project.
>
> I'm totally fine with that, of course. :)

You are the Stephan Beyer who did a GSoC project on the sequencer
around 2009, right?

It's nice to see you back on the list :-)

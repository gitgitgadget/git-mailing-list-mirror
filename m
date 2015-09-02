From: Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2015 is over
Date: Wed, 2 Sep 2015 11:01:31 -0700
Message-ID: <CAGZ79kaYRZyaK6FhcChd3MtxXL7L0E7XYJ8mqoXTUntK-_O+fA@mail.gmail.com>
References: <vpq8u8qw047.fsf@anie.imag.fr>
	<xmqqy4gon1ow.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 20:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXCLo-0007zs-Vy
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 20:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbbIBSBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 14:01:33 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34566 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbIBSBc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 14:01:32 -0400
Received: by ykdg206 with SMTP id g206so18328892ykd.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DRkD9zWVYPf6sQ/4+WUdSrV8qFOgvX4EPqbkengucjg=;
        b=kfXj5DVNIOz2ro/3vXUuIcxjEAvhwhxPxSqeD5BDYVpkY8uerxwr8jgnk95/DUZeLG
         sN5f8pWzYQd/wjC4Lj2eOuA6fDdOnTLeIeh1tjmrCU6RRFJ7My0G8e7UNlmdvEhCHh+P
         pYuLrnHcMfkJ9uSAgG7wY8qaaj7F9c7+lcGZ3F+iMFczdtGGuxlmOkeo4j6B+ZM1NP0S
         lhVhI39vp9ofvgjgXgiSk/8Mc2DKuoIWg/fJwLYvbH9LEl1G1fXnCu2U0bzjxagQs8aC
         k4xxWj6WR1jj+q3Lb2sPHyDiccx8eju2qqtSDmFEyF8L1aHXlI+ElePG9UHScJMY/bDW
         MgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DRkD9zWVYPf6sQ/4+WUdSrV8qFOgvX4EPqbkengucjg=;
        b=Cc5+idJgCbi1wZQ+ZhSV9Yf1oFZvoFZuCeO4Eqz39g2iQwYK3amG/e2Lj0w0wIrmfR
         cu27dxNb93lMTkMRidoFjlpSKlx+ll6Q13R39ebg2oO0HhWBTW+INk2KI13iBovN6rmy
         VFegD3wIu+p8jsaupv6DhrrSr93FARc4izDRkQ/FA44rkUyY+EccXJeQpQzk8sfBH3rs
         ZMlhH+RXmbyiZAlZ1ydlnKG4RH7bidJnlig1Y9Cn6z1BMQgMPSjFa/0t8UFAXsSIRSj1
         ad/FvZ528oXhzzBBI/5UNN7gbD4ukEFE8z8vsxVEHjPPjv9RBpP0D5Byf4xb+3qxuviL
         mhHA==
X-Gm-Message-State: ALoCoQkAMgpGsoRp6gmkd+Z7lyVuKv40olD6SHOdIXe06J7EF9D112QatUMxmMA/pkURsNKD0V6l
X-Received: by 10.13.254.4 with SMTP id o4mr28598702ywf.88.1441216891601; Wed,
 02 Sep 2015 11:01:31 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Wed, 2 Sep 2015 11:01:31 -0700 (PDT)
In-Reply-To: <xmqqy4gon1ow.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277113>

On Wed, Sep 2, 2015 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I consider this GSoC as a great success and a pleasant experience.
>> Congratulation to Paul and Karthik, and a warm "thank you" to everybody
>> who contributed: administrators, mentors, reviewers, and obviously
>> Junio! (not to mention Google, who made all this possible)
>>
>> Thanks all!
>

Congratulations Paul and Karthik!

>
> I do not know what made it different this year from years past.  We
> may want to ask ourselves what made it a successful year, so that we
> can repeat the success factors the next year:
>
>  * The individual qualities of the students we got this year must
>    have been a major factor.  This we can indirectly influence by
>    having a very engaging microproject period, I think, and we did
>    so this year.
>
>  * I cannot say anything about mentor-student interactions, which
>    are largely private.  Mentors may want to share tips to get
>    students more engaged, or perhaps the level of engagement was
>    primarily affected by who the students were.  I dunno.

As a first time mentor, I sometimes had the feeling of not doing enough
mentoring. Though maybe just because of less private student-mentor
interaction the reviews came to the list earlier exposing the patches to
a wider audience?

>
>  * The topics chosen this year were well-sized, not overly nebulous.
>
>  * The reviewers were helpful and probably more active than past
>    years.
>
> Thanks.

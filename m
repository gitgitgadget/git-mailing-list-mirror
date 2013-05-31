From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Fri, 31 May 2013 13:33:14 +0530
Message-ID: <CALkWK0nVDBv9bfFpAJ+pzON-uD_4HQ0Bcg=CN32fgFvNJnnjgA@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
 <CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com> <CAMP44s0peXDtFB31pEqF49xM8z5OtDKAWaOR65aZSkCndL2bhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:04:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKJe-0004mV-JN
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3EaID6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 04:03:58 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:65204 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3EaIDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:03:55 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so3167147iea.37
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V2HRjgWvb/yXsn8cc5iqwODmZl57A1lIJIMm9gL5//g=;
        b=TU0OyMVEHJaLuSTgSjl1b/2FpMxLhI/wH8DB+XJVCTKa/OQ5qr6DRBrmGioBNNRaZ/
         dqVSFJ4Il1MyW5KrJcyjJeQKXcQmfTlo+glZfm+MqA9g/ys6X1ve35qufmRMwjZ1D29i
         XjG0pzsrvRDNP8weCimU8SVZUYSgEYLsSjA337vlwdmMWNWlOYYEJh3Xtq0nOGF4L8ap
         WDo9ZbQc0HiGZcIoUhsRaNapF0E1ZgDJQeSOk7jE6uad8YgvfOd+UjivBNkw+Ly83w3m
         6SbCDntz4qhvBQXvqpjqz6v7jsjLwxIdste9kGd8PQupXhVVWOE/6+Tu3hTnUI6z35Az
         5zQA==
X-Received: by 10.50.153.6 with SMTP id vc6mr1133603igb.57.1369987435122; Fri,
 31 May 2013 01:03:55 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Fri, 31 May 2013 01:03:14 -0700 (PDT)
In-Reply-To: <CAMP44s0peXDtFB31pEqF49xM8z5OtDKAWaOR65aZSkCndL2bhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226072>

Felipe Contreras wrote:
> I was going to make these stylistic changes to make you happy, but
> then I realized the only that does really make sense is to change msg
> = nil to msg = false, and it's not even worth to waste a thought on
> changes like that.

We don't have existing Ruby code in git.git to follow, so what I say
can obviously not have more weightage than "personal opinion".  Don't
do things to "make me happy"; I am nobody.  Have a good sense of style
and defend it instead of flaming me because you thought I was stalling
work.

"Some of these style changes seem to make sense, and I'll fix them
after this patch gets merged."

or

"I have a different opinion on these issues, and here's why: "

would have both been appropriate responses.

> So I'll move on to the next patches, hopefully Duy or Junio would have
> some comments of actual significance, or maybe you would too, but for
> the moment it seems pretty clear you are only stating opinions about
> what Ruby code-style you like best.

I've done reviews of several iterations of this patch, and stylistic
comments were all that I had left: I might not be adequately
intelligent to come up with "comments of actual significance", but
that's a limitation you're going to have to deal with.

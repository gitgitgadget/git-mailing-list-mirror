From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 22:26:32 +0200
Message-ID: <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Jvb-0002RR-4U
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbFQU1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:27:15 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34594 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbFQU1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:27:13 -0400
Received: by obbsn1 with SMTP id sn1so40858326obb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p8+aUT1snjvKJLi1KmMBQ9wuNlLkWALs0bFELzSpg8A=;
        b=AGBsZe7vX6wKc6qsEfKlWBbV17xIZPkjx6Q6P4bLEj9AMPv05RndfQKwB9JPkeEnAx
         yLsOnEAUHhDFVQRROz7r+6QvFJNTlCeCeZTjyDPF5VlCc5Af3gE4EVenvPSVOOEXdWvZ
         VGQrDLBDKKsOZqZ+YLWgKMvMnwQ8kCAlPg7r3ixGcYcVLdcbgfdI7czB9e9S46lzPO04
         VylBipkM8cZqKJ3nT+zeUqAr14DGmAiPsZ9FpprQxrtOJp4RqxtaDKNNzWADgOc2k2O0
         +PFbU9ZeS/E6va8bQHrtUd/aGeXzaxZQCTDJrWZjQa27qFQOfR9S/aKQ7WQkjQ8YgGzV
         kjPw==
X-Received: by 10.202.80.10 with SMTP id e10mr5925800oib.76.1434572833110;
 Wed, 17 Jun 2015 13:27:13 -0700 (PDT)
Received: by 10.76.158.202 with HTTP; Wed, 17 Jun 2015 13:26:32 -0700 (PDT)
In-Reply-To: <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271908>

On Wed, Jun 17, 2015 at 9:58 PM, Junio C Hamano wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>
> > Is this something that breaks the design and would never be
> > implemented,
>
> Yes.

Junio, thanks for the quick response.

I suppose things have changed since Jonathan Nieder's response in [1]
(2010), or I've read too much into the mini-thread between Jonathan
and Josh. I was under the impression that this is generally possible
without shaking up all underpinnings.

For what it's worth, here's why I would use the feature:

By allowing multiple authors, you don't have to decide who's the
primary author, as in such situations usually there is no primary at
all. I sometimes deliberately override the author when committing and
add myself just as another co-author in the commit message, but as
others have noted it would be really great if we can just specify
multiple authors.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=451880

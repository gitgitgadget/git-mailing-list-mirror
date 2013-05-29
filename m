From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 08:34:37 -0500
Message-ID: <CAMP44s0cpAkAUzo0nS55yv+6=cCBsBhgNiYxpEd8Hzk=3mfNhw@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DTKZgVM7TSBUKJq2pspkR1jH-fyG6BHr1YYz3N+Ov3XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:34:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgWa-0001sJ-V2
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966110Ab3E2Nek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:34:40 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:62584 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965980Ab3E2Nej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:34:39 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so9060887lbf.28
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bzSLI+T8VUwNwRK0Pdz8kHviKQnQCzqPkjxbeAg65/w=;
        b=CsKF8vaQhEIv7VtlgjrI4560eYT1oCYJHImWYg7hgI5/hbayNBuZXu0HyhpTCutuoi
         tknI4WLXEbkxeozEQL4Pfo6FqzXBfqmyYXwdNxAC19k2ie/R50RJmqYldlIEnoADVkIT
         d/BBGYi6w28yLXgETfaCE6dv0QzVbWPmrJND9ttbDT0Z7HoKrwLr7mZKUa1ORAxugVgo
         6715qTaIKTXAXOTVtuNLKNl7xXtF6txGm5pClfN6oZC4p3QYL/B+mdCGFEYneZElTyV/
         qY9JENLV1etEBrx99v19JjZHH35qYzCqpOuQufLE8mxixZXzj8cka7u5ofv6hjGvRMgi
         /ZRg==
X-Received: by 10.152.2.233 with SMTP id 9mr1384044lax.34.1369834477949; Wed,
 29 May 2013 06:34:37 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:34:37 -0700 (PDT)
In-Reply-To: <CACsJy8DTKZgVM7TSBUKJq2pspkR1jH-fyG6BHr1YYz3N+Ov3XA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225819>

On Wed, May 29, 2013 at 8:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, May 27, 2013 at 11:52 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> We should free objects before leaving.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Micronit: perhaps you should move the "free obejcts before leaving"
> (in do_pick_commit) to the subject instead of "trivial fix", which
> adds no value to the patch.

Perhaps. I prefer it this way because it's really a trivial fix not
really worth much time thinking about it. So when somebody is browsing
the history they can happily skip this one. The time save by not
reading I think adds more value than any succinct description that
would force each and every patch-reviewer/history-reader to read it.

-- 
Felipe Contreras

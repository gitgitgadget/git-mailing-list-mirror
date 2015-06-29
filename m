From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Mon, 29 Jun 2015 14:33:10 -0700
Message-ID: <CAKDoJU4Wjx1XJ383qgikpPXr7bP3eHObR3Cu5nCjVuO-1omCag@mail.gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
	<CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
	<xmqqvbe6bg3z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9gg3-0006Zf-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 23:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbbF2VdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 17:33:14 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33711 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbbF2VdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 17:33:12 -0400
Received: by oiyy130 with SMTP id y130so127698789oiy.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uSLIap7WFvz53d1ak5CMymR7dhJVetOQRBgtJ/P8kU0=;
        b=x8RyZtXZGTNbg1qHJ5uZMq1S3G7aeBfhlhm44sl1IYBbjsQtTq1KzxVK90xvHMq1M+
         nrhKwrP0bHQLrmQu9ABSHeZbhTKQ8UN7CaE0S7rN/IIlirnVdgqbfqNh6aBjAwJMuMJN
         rmqnu2GdvcBCPYbACOWuHyDUbAESnEKYbkvsrDoQT6T9KoY/pQUV13kKcA2puDkTuAA8
         Wrf0NlHEb4pifTNb2ENWc6j0U7aBMdz4Pi6q3hab8AS2f/cunMq9YSmWN71/xGBF0yLk
         /xNB3GuGKGOrsOlG9L3M3+m5UPpDBlGhsImipL6G3TuXq36xOpiuImfC+pje3fMym50L
         wi9A==
X-Received: by 10.182.165.71 with SMTP id yw7mr5158027obb.16.1435613590599;
 Mon, 29 Jun 2015 14:33:10 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Mon, 29 Jun 2015 14:33:10 -0700 (PDT)
In-Reply-To: <xmqqvbe6bg3z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273022>

My apologies, I misunderstood and thought rev-list didn't take filenames.

Lawrence Siebert

On Mon, Jun 29, 2015 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lawrence Siebert <lawrencesiebert@gmail.com> writes:
>
>> I was using it to sort files
>> by commit count when provided a list of files, which git rev-list
>> doesn't really work for.
>
> What makes you say rev-list does not work (perhaps 'really' is the
> key word there?)
>
>     git rev-list --no-merges maint..master -- Makefile
>     git shortlog --no-merges maint..master -- Makefile
>     git log --oneline --no-merges maint..master -- Makefile
>
> all gives me results that are consistent among them.
>



-- 
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com

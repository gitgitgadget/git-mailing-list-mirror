From: John Szakmeister <john@szakmeister.net>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 05:48:38 -0400
Message-ID: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 23 11:48:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfS8a-0004wV-CH
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 11:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab3EWJsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 05:48:40 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:44185 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494Ab3EWJsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 05:48:39 -0400
Received: by mail-wi0-f177.google.com with SMTP id hr14so1941425wib.4
        for <git@vger.kernel.org>; Thu, 23 May 2013 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ooeLQJv/NIP5z/BCu2tgkAR2r/+he66KAgWhmudwC3Y=;
        b=ksMDAbV0n3C9DCBygLVyIMnudghGW7Frm/k01OnhBPjHmrsRwxYKpLwYt4BsJ1dQ9y
         bF4biF+pBGpYViwXX1X8Aguh3cvFiMHgL/FGgExZlci+/GPiKjj3U3FOcctXsllebgS+
         AS6ZrdAherdP9CAoSvu97hWeRDFJ26p8jlBDU56lwOlILJS+XmSl5JBwfgyLhg21Ifx4
         +KYo21d+faW1GYHALGrR1ZvQn6krMUS/IQ4ZvcVV+c9HYaF6pO7CpYCuFmQT5QtdFV0H
         xsrZ+SyEuH1oG59GZINL59SJDauPgUAhJigTWwbSzulPeEpQ/xm9EUeKTkh8wENZbz7+
         hdzg==
X-Received: by 10.180.37.229 with SMTP id b5mr42082019wik.29.1369302518239;
 Thu, 23 May 2013 02:48:38 -0700 (PDT)
Received: by 10.180.5.33 with HTTP; Thu, 23 May 2013 02:48:38 -0700 (PDT)
In-Reply-To: <20130523090657.GB23933@inner.h.apk.li>
X-Google-Sender-Auth: nMnuzGSjiAM0WWEnHM-7ES3_yxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225227>

On Thu, May 23, 2013 at 5:06 AM, Andreas Krey <a.krey@gmx.de> wrote:
[snip]
> ...
>> Don't do that, then.
>
> :-) Problem is, in this case 'I' expands to about
>     1<<7 people I need to educate on this.

This is a feature of `git pull` that I really despise.  I really wish
`git pull` treated the remote as the first parent in its merge
operation.

-John

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 00:18:15 -0700
Message-ID: <20121025071815.GA15790@elie.Belkin>
References: <20121024180807.GA3338@elie.Belkin>
 <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin>
 <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin>
 <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin>
 <CAMP44s3Xwt5+J_yGte_HC3hG+MhMkWnJQ7mtuB_Y+sOLB1b1+A@mail.gmail.com>
 <20121025055343.GA13729@elie.Belkin>
 <CAMP44s2bNZLiyinu3wgmw4gaRM9XUvA857-8fOGebhKYFmDesw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRHi9-0008IF-7P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481Ab2JYHSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:18:25 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:58573 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805Ab2JYHSX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:18:23 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so646440dak.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lPHmR+NZCsmxXCXsAitOd/iA/8iezuUOpvwzvDl7Dco=;
        b=XTOJ6hjlTOS1JXexb53GsM/uOVewsL5/HAbmL65DuHB0SR1QmEYRZVhy3iWydJvfEr
         rJ5lq4351IB88XANojaLoM8xvcf6O2Vjd1i5Y3CKCjCzYMti0kVlw28ssCmaay0kEz+s
         tyLKu9k3vfuYnXGa9a9FF7xLKA3X4/sP+7vZIJ6gG1O4WWhRlHO5kH9u3gDNi9jHj19T
         iZxwODSEOHIDuWIN34Vf38/7A9foJ+B0N7JSzwV06lgsUVWkKz0uk5fNrQtrxCVHM/zJ
         YIcUO1+DsXLDF6ZaKNbZ6o898GIPAhbY+RSLW7raYZDH6degXhukw2B4HkiacxRIBqrU
         Lpgg==
Received: by 10.66.86.165 with SMTP id q5mr50702216paz.18.1351149502993;
        Thu, 25 Oct 2012 00:18:22 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ox7sm4733334pbb.14.2012.10.25.00.18.21
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 00:18:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2bNZLiyinu3wgmw4gaRM9XUvA857-8fOGebhKYFmDesw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208356>

Felipe Contreras wrote:

> Show me a single remote helper that manually stores SHA-1's and I
> might believe you, but I doubt that, marks are too convenient.

Oh dear lord.  Why are you arguing?  Explain how coming to a consensus
on this will help accomplish something useful, and then I can explain
my point of view.  In the meantime, this seems like a waste of time.

Let's agree to disagree.

Regards,
Jonathan

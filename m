From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 20:52:32 +0200
Message-ID: <4FD63E70.4000309@lyx.org>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: =?ISO-8859-1?Q?Cl=E1udio_Louren=E7o?= <pt.smooke@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9jE-00072l-35
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab2FKSwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:52:36 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44337 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2FKSwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:52:36 -0400
Received: by eeit10 with SMTP id t10so1959663eei.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 11:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=rs5375XOwLfaf+VvvoyoKApnGwYpSx+aCRy52wopKpY=;
        b=orIvz61HX0hqBOGlcDn/pXTZSlfctEYf/BNg+B6dswGYOPnWMQS7mb+bV6RP7/leOC
         wN2zE0IzZU2iSvUU4kqlYntvUaHmYbfMrpbvHbzXV4vor488ztFQLCs1LUyxuMQWg/7l
         ahLu0YwHhz6zi1fao1WU8eXN8MTzPQ8zzgHwf7o2EQYG7R5QdcHBlpX/8gkxV4SMmuHR
         Y7bzgX+GoNIkh6uK2XfZop4YTuGf5LiXxMmCE6KqtmeW/YSGO37PjtYryEldaOA9SXQt
         rIjfJkj8tUnjGi54ihl4bXaiRaqxAJrlKHwyJJkggwRd5pEZgrNjW38Jv1FLvH9JvxBy
         iDrA==
Received: by 10.14.99.206 with SMTP id x54mr6290033eef.94.1339440754422;
        Mon, 11 Jun 2012 11:52:34 -0700 (PDT)
Received: from [192.168.1.6] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id t3sm55747846eeb.15.2012.06.11.11.52.32
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 11:52:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmNIkqyFvK6ADqGXg6MTWBAdhgsLwnvfo1GDbnsrTnILRqgW8tlazag7h9OJYXvkRXHv9MH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199696>

Op 11-6-2012 18:52, Cl=E1udio Louren=E7o schreef:
> We are not sure if this behavior has an explanation of if it is just =
a bug.
>
> We are hoping that you could clarify us about this operation or
> recommend us some place where we can find some useful information
> about this...

I think it is a bug. The file "something/f1" should be retained when=20
switching branches. So, checkout should fail because "something" would=20
get overwritten by checkout, but it doesn't.

Vincent

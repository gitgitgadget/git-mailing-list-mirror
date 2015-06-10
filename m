From: Stefan Beller <sbeller@google.com>
Subject: Re: git lock files (Was: GIT for Microsoft Access projects)
Date: Wed, 10 Jun 2015 08:22:14 -0700
Message-ID: <CAGZ79kYhgBaY5UpmfK=amfM56c61vcUu8=ofagG=nPwqkPt2rg@mail.gmail.com>
References: <5576F02B.4040002@gmail.com>
	<1433870383-7631-1-git-send-email-sbeller@google.com>
	<20150610074733.GM30511@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, kostix+git@007spb.ru,
	Deaf Smith <hackerp@suddenlink.net>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hph-0003zC-Vy
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbbFJPWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:22:16 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35830 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbbFJPWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:22:15 -0400
Received: by yhak3 with SMTP id k3so21994347yha.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Aq/8+D3Db/pHZfsMk4d004H9LrUbUOdvJL5K0QNdNR8=;
        b=XITlSP/OPG9KW38Wk55HhcqLqX0yXQCsYJiINQTShUBqq9NFE9wTEnrzetl8sgA8vy
         7QYq1pluxLgCuGY91va0QhaVBegBhnHfbnnwE40WbEQ+8ptBVL3O88/3J8CvcocNb4xl
         3QkPQz9m1H04HK+Sw6UjBlVGFMFyKgxohh1Fc04lqZ4WcqN33Yuedxh3Gk+LxX9kQuUz
         gxl07eqELbVICNYHGyl3ldvqb00f4T1Za/Cys91pqoqLrfqqmyKtGT7/cC2sqovt50x5
         dwF9UADvHesRVN6B5YXJkzA3Xq48gtbvnT9JVH+fsYs6CYsFeXlJC1/J4rwBf9BmbLSZ
         yvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Aq/8+D3Db/pHZfsMk4d004H9LrUbUOdvJL5K0QNdNR8=;
        b=iuBquegPxk1IkEkoICytWG6PSeuukncv4mcplQBJ8xkUaRWP91T9WN5P0DfReMLBcC
         TleuVhGYUqV6s/8uJVLFeemgJhjZiY7nAB1df3DHajjxP50xrZlIykos5ZUqrPEY/FY0
         qJ9va7P2q/UBPxrBO2a5CzIGIQaCMfBNHXk6VUMk1Tg9IsZWu5dZ6biagGY1bAYuTG+Y
         5Jo7WMA7HFQDsBMYAvVJhJUCUIOe1GjbAEQtIxI51xXu1uG+xM2RngGkYHLPq86bTaRn
         d2JU1r5P3TAmbI38IC+xMxPFUqdqCKFpfbGORk0joHAJEWxV1zln1t3OmqajpVkj2Z2B
         fwqg==
X-Gm-Message-State: ALoCoQnBwCT2+sE4iKCeBgS1O6IFISohBYD31q6UCZYk+zltEF4MELLeYLgsRlujKUkcGIBl84vC
X-Received: by 10.170.59.213 with SMTP id b204mr4691389ykb.10.1433949735041;
 Wed, 10 Jun 2015 08:22:15 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Wed, 10 Jun 2015 08:22:14 -0700 (PDT)
In-Reply-To: <20150610074733.GM30511@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271302>

On Wed, Jun 10, 2015 at 12:47 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Tue, Jun 09, 2015 at 10:19:43AM -0700, Stefan Beller wrote:
>> Just because Git allows distributed workflows, doesn't mean we
>> should only focus on being distributed IMHO.
>>
>> The question for content not being mergable easily pops up all
>> the time. (Game/Graphics designers, documents, all this binary
>> stuff, where there is no good merge driver).
>>
>> I could imagine a "git lock" command which looks like this:
>
> You do know that gitolite has locking functionality?
>

Yes, and it's cooking its own thing, it's not upstream (in git core I mean)

Locking is useful not just when using gitolite, but any hosting
solution I believe.

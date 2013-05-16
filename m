From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] branch: show me the hot branches
Date: Thu, 16 May 2013 19:28:43 +0530
Message-ID: <CALkWK0=LJk_xQA3tLkmSC=-mrk0S+iXW=medvakB7mQ2QorgAg@mail.gmail.com>
References: <1368475365-18680-1-git-send-email-artagnon@gmail.com> <CACsJy8BQ=+rEfnBj3hqOdWNJXuONB4tPTwY=h1UDM0t++ds9HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 15:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcyiO-0003hn-PV
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab3EPN7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:59:24 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:52619 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3EPN7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:59:24 -0400
Received: by mail-ia0-f175.google.com with SMTP id m10so3486946iam.20
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=82AdiaSQOcHx3f3pXs5VHGFoHnsD6sVgQS2+XD7OE30=;
        b=ufBswFi7pQn4721YrqxsEhvi78EsWsDfeUdsFE+QbL5ZP6Cqk1SjcjChlikuebLdUs
         xezoXHoSaVNtXQ/C3imQJuUlXS/finiQNdv6o4vH7LMuRVkf8cWg2rCGUQyogAX/aqNL
         b+xFnE0oIqGgT9UEfm4DLWb8BPg1mMFUaEPsmSwK7SYpFz6zKzfasENrGxB8PUtHhWAR
         dwersY1BPLXSS6xbEyjFWPt457s+m7ibzNeQZrzVQ1Q++c6//yki0sqqxOaP4cjEgHAH
         wcP/X6CoKmO3qqlv+eO7SNP7vKbgQJEl3hhBNcXLJNPe5tPKMwt0v/YT32BLOW8WKuMu
         kQUA==
X-Received: by 10.50.73.65 with SMTP id j1mr9486916igv.49.1368712763698; Thu,
 16 May 2013 06:59:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 06:58:43 -0700 (PDT)
In-Reply-To: <CACsJy8BQ=+rEfnBj3hqOdWNJXuONB4tPTwY=h1UDM0t++ds9HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224569>

Duy Nguyen wrote:
> I tried a more generic approach a while ago.
>
> http://thread.gmane.org/gmane.comp.version-control.git/188705

Looks good.  Why didn't you polish it for inclusion?

It's a very useful feature in my opinion: the default git branch
output is quite horrible.  I want to make sort, count, and verbosity
(poorly chosen name?) configuration variables.

From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Tue, 31 May 2016 17:06:50 -0500
Message-ID: <20160531220650.GA46739@zoidberg>
References: <20160525020609.GA20123@zoidberg>
 <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
 <20160527044112.GA31742@zoidberg>
 <xmqqoa7sroru.fsf@gitster.mtv.corp.google.com>
 <xmqqmvnbqrov.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:07:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7roV-0002tF-GK
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbcEaWG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:06:59 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38338 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcEaWG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:06:58 -0400
Received: by mail-it0-f41.google.com with SMTP id i127so4434012ita.1
        for <git@vger.kernel.org>; Tue, 31 May 2016 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=arwl3cUTjktTuXSTM48YjaAIiy1/ES5lp8wnp+1IE64=;
        b=Ini0UMcl6g6nTkN7fARiGrTkGGv2/tw1KJdiVL0AzdRTDGBvtgO/SGeFXbmwB8PsHZ
         4uSp0Zl+SewyNqpHER8OhXT7t0Vl2+1BXhAQjFAJ4Vu7A+qHxsyEgwEUOOWc0GQBKMed
         HdK8FpABEhrGFyMYHcTcBMgnurBa3gQeklSX6oMwb9BUD492SlCKP2TC0ThniGHEizRb
         cWSl+9eFpPmLrh6lALj+hT45CEWtefYlOm8seZ9wRhZiciM8AKl2FSLZtUQFFUhR0jfq
         FYBcyI3P5TwCZgLKqTgOQTGk6tBQMCr7j1/S8zmZHNdCMujyPQi71XS2SPFckXTJK8On
         MP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=arwl3cUTjktTuXSTM48YjaAIiy1/ES5lp8wnp+1IE64=;
        b=Ya3W0noUtev9Ud7UBn73a/rdVOL/YI9pJeX5p9JhQVGJ3ZbvjtHXkTIlKH0WrSmuli
         m1rr786bzk2vjw6Rrr7Wqg+5ShHiGBwsy0PywDw5r33c9CvQpxN2BriRkhLSqqjMd+31
         uXAVzvQfxminEa72qQ2k6a26uWX+mA6WQue3nbb1JbLKiYWWKZlMxM6RjhvcLhHlRHUI
         3AJID/JkmUScsEvOF/1Txlm84LcWNQLY/MY1A6iRatN1uFXGiIhEwmX/8WFvB4LeE3xu
         DRXqmJ8BL+wZfqrSntK7o2nWsOVrWQahVZYQCdyZkE/VYEA0JAOrNJgO7KIS16YekFiN
         TROA==
X-Gm-Message-State: ALyK8tIllGpcq9CofoapvCNm40bSD+JzTqZdwZ5TRkwx8IDZEdpuq/v9pGYN397xFxQyFg==
X-Received: by 10.36.81.79 with SMTP id s76mr982947ita.71.1464732417113;
        Tue, 31 May 2016 15:06:57 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:f5c8:2af2:b531:a3f6])
        by smtp.gmail.com with ESMTPSA id r143sm10449602ita.15.2016.05.31.15.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 May 2016 15:06:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmvnbqrov.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296018>

On Fri, May 27, 2016 at 11:30:40AM -0700, Junio C Hamano wrote:
> 
> Oh, having said all of that, the comments on the implementation
> still stand.

Certainly; sorry for the delay.  I've squashed in your tests and applied
your recommendations.  Resending the patch momentarily.

Thanks-

-ed

From: David Aguilar <davvid@gmail.com>
Subject: Re: --trust-exit-code not working
Date: Fri, 14 Nov 2014 13:07:12 -0800
Message-ID: <20141114210711.GA55473@gmail.com>
References: <20141114161235.GA30086@vimeitor>
 <xmqq389l347n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Adria Farres <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpO5Q-0001nD-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161796AbaKNVHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 16:07:14 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51376 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbaKNVHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 16:07:12 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so4662808pab.7
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=muuLb9UTAldMEWTk6uBIdD9mZZx0/IDSpssCOiyRnDA=;
        b=YoEDsHEGg0Oh6eAEJXXpTPHCvqx2+nq7ARFtH6mrhy5X89OwxRX/pdf+t9e4rGUccZ
         tOnwJA2X3wuv5/KdQ/T45sA8dwIIhFyTQ73Nz/9EP/L5fmQO1jXkCewWVxMFQicbuJ89
         p5NveGKdgEnMO+fnFeK5jQWzCZawzYAaeca64N1E4x1iJJ58LA4bqwZyO8tsdictT3lN
         dQZj4S13jiEIu0M3bce3fi1xsP9zzjwA7aLqBi3PpavU7A6dryU4qSSoqZzMsWGrKSnn
         tQM2c92PHFqjrGue6HjhLllkVeAZSJm5QEtqhv747+8/tMq4wJRn/b2mutEvIfzrAkQj
         nrpw==
X-Received: by 10.66.191.135 with SMTP id gy7mr12704302pac.95.1415999231888;
        Fri, 14 Nov 2014 13:07:11 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id gn11sm21445367pbd.32.2014.11.14.13.07.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 13:07:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq389l347n.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 12:41:16PM -0800, Junio C Hamano wrote:
> David, I think this is about your 2b52123f (difftool: add support
> for --trust-exit-code, 2014-10-26).  If you have time can you help
> Adria?
> 
> Thanks.


Yup, I'll take a look when I have a chance.
My first guess would be that the vim scriptlet is not passing
down the status, but I'll have to take a closer look.

FWIW, I thought I had actually tested using vim,
but I'll re-test and verify.


> Adria Farres <14farresa@gmail.com> writes:
> 
> > Hello!,
> >
> > I sent an email last week, but I'm not sure if I sent it incorrectly, or the
> > formatting was very bad, or it went unnoticed. A few days ago a great soul was
> > kind enough to create the --trust-exit-code option that made git respect the
> > exit code of the difftool. Unfortunately, I haven't been able to make it work.
> > Exiting vimdiff with :cq doesn't seem to make git quit, as it keeps pushing new
> > files to be diffed. I tried meld and the exact same thing. I'm confident that
> > exiting with :cq gives an error, as I have checked it, and I'm using git
> > 2.2.0.rc1.
> >
> > Am I missing something important? Has anyone managed to make it work with
> > vimdiff and meld? Sorry for bringing that up so late and for being a
> > disturbance.
> >
> > Thank you,
> >
> > Adria

-- 
David

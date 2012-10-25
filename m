From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 22:53:43 -0700
Message-ID: <20121025055343.GA13729@elie.Belkin>
References: <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
 <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin>
 <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin>
 <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin>
 <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin>
 <CAMP44s3Xwt5+J_yGte_HC3hG+MhMkWnJQ7mtuB_Y+sOLB1b1+A@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 25 07:54:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGOL-0007P8-GJ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab2JYFxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:53:52 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:53861 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab2JYFxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:53:51 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so612776dak.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZVgDns/TkxDmZMtsnfVdtXXwiKPj8hAPSW9ULR9mmhI=;
        b=ZiEAgy760yTfxNVKBKlcXo4JaLiAGcr/QjtRVbEUrST4lQvhNoB4x9OdRMZPueNkJI
         +nMH68PrAqpcEtvkj6R/DbjoHqHe5M0ebvRc0zDpYh4SJT9NE7RUl0VAF1fuS4t0d8qG
         FRSd7rhykmboXn4ken0xaArasDFVWkgaIZd2Omd8UgbIRZ6WvqWWbkfJBdwEwZ+3kFBC
         Xg4N9DUWrHSnW/AalK7HRZ1Z4bUU5wW/9XpTF2oGY4Xbs0JmRp58IivUPoyvd5itH3Fh
         FA+vMTGQGupiOIXVLQOqwaZP3xM+fEzxAH1IQmaXbsSNkAEw6JAYdfEyNv09ihg5w4YK
         b1tw==
Received: by 10.68.233.196 with SMTP id ty4mr57396858pbc.23.1351144430780;
        Wed, 24 Oct 2012 22:53:50 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id bf6sm10730718pab.3.2012.10.24.22.53.49
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 22:53:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3Xwt5+J_yGte_HC3hG+MhMkWnJQ7mtuB_Y+sOLB1b1+A@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208348>

Felipe Contreras wrote:

> All right, so I run this and get this:
>
> % git fast-export master..master
> reset refs/heads/master
> from 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0
>
> As an user of fast-export, what do I do with that now?

You passed "master.." on the command line, indicating that your
repository already has commit 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0.
Now you can update the "master" branch to point to that commit,
as the fast-export output indicates.

Jonathan

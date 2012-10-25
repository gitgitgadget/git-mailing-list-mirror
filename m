From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 22:28:23 -0700
Message-ID: <20121025052823.GB11243@elie.Belkin>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
 <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin>
 <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin>
 <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin>
 <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 25 07:28:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRFzl-0008CD-UX
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab2JYF22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:28:28 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:64462 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab2JYF22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:28:28 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so603235dak.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zbN8j1j2WkX8x77SUyVe7tBVTtBkWhQZ1ej43iTHClI=;
        b=WrEtlIh9cHfJMCCa9koSDg0PTjgYkB/Nk+vPBGTJ7aJbFG2yJlvBvCDPJkzx2yjmcR
         zpmlrtH/+qpXilyDyrmDHTt8rGBSAW3R09iQt5OBp6wRSpVhV8xe9ksE5c8QkDmJqZpY
         xCsInYRxn9L3oYrVs9W58SnwCsZe9+kz8fRX1KZ3t9He2oXQnRM2jp9SGzSarPh3mriG
         jSSuzAX61Nr4JV196ZPGwUMvK9gctdULT3mab5mjLNij21fXsluLWqCO4BkTcOsfomxG
         mmoTJ6lo3WCnVHlUqRa+z4Z84ZnFA9DaA1GPWbufa9cVF3uRdQYk94XWPcgalGNo5em9
         yrtA==
Received: by 10.68.213.138 with SMTP id ns10mr56257039pbc.157.1351142907419;
        Wed, 24 Oct 2012 22:28:27 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ko10sm9799561pbc.1.2012.10.24.22.28.25
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 22:28:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208344>

Felipe Contreras wrote:

> I don't need help, I am helping you, I was asked to take a look at
> this patch series. If you don't want my help, then by all means, keep
> this series rotting, it has being doing so for the past year without
> anybody complaining.

Ah, so _that_ (namely getting Sverre's remote helper to work) is the
work you were trying to do.  Thanks for explaining.

If I understand correctly, it is possible to get Sverre's remote
helper to work without affecting this particular testcase.  From that
point of view I think you were on the right track.

The testcase is imho correct and does not need changing.  So yes, I
don't want your help changing it.  I don't suspect you will be using
"git fast-export $(git rev-parse master)..master".  It is safe and
good to add additional testcases documenting the syntax that you do
use, as an independent topic.

Thanks,
Jonathan

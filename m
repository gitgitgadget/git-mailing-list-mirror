From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011 v2] Git Sequencer
Date: Wed, 6 Apr 2011 14:31:19 +0530
Message-ID: <20110406090115.GA9210@kytes>
References: <20110403172054.GA10220@kytes>
 <20110405200008.GC25644@kytes>
 <BANLkTim5B1PGHr+TKGFaekywUh9r6K_Htg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Od7-0006Wi-30
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab1DFJCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 05:02:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42884 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab1DFJCS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 05:02:18 -0400
Received: by iyb14 with SMTP id 14so1232257iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Cd8Sg/LCjFus4zExKTm2nEwrsKSiWZvljcnYWqAnpLw=;
        b=bXyC0OcM+xHElCDSxTFCxghuAhWcHULpZQ69C6XJmA2Koj0YXQ7BXZ2147xvJoYlio
         lYw2zx+KkiFhZ2C0jPKSg5H25Vb6QDeEhNez7O+QrBi7es2asq1UNkWNzPeTBqHZj6HJ
         lAvEf1vf40tBC/uAIX7PWCaiCYYg16UGpjgsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tuD7LY9N7Lvc7tv4lHNbwfmKD3krW2O/iCpDhxTTMpLKIXg9ytQeFRzXe4uO+ApXPV
         m6D1qKhc+LRiCrxf7flbwSr+IGFtfuqbqmTDT2zWxI3LBRykiMsZjVP0rNWMD68Py0zC
         AhQXcb/ebwfKB/fiVzKU45zead755Dd48ROUs=
Received: by 10.42.138.4 with SMTP id a4mr1173082icu.258.1302080538200;
        Wed, 06 Apr 2011 02:02:18 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id gx2sm290318ibb.26.2011.04.06.02.02.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 02:02:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim5B1PGHr+TKGFaekywUh9r6K_Htg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170955>

Hi Christian,

Christian Couder writes:
> On Tue, Apr 5, 2011 at 10:00 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> >
> > 2. Build a sequencer so that just has cherry-picking functionality.
> > This mostly involves moving code written in (1) around, and crafting a
> > general API for handling conflicts.
> >
> > 2.1. Factor out the 'cherry-pick' code from 'revert.c' into a new
> > 'builtin/sequencer.c'.
> >
> > 2.2. Write an API for handling conflicts, so that the sequencer is
> > ultimate entry/ exit point for all user intervention in a multi-step
> > process [4].
> 
> This one may be more difficult than we can guess right now, and it is
> linked with 2.4 that is optional too. And I wouldn't like you to spend
> too much time on it if it appears to be quite difficult. So I'd
> suggest that you switch 2.2 and 2.3 and make the new 2.3 optional.
> 
> [...]

Okay.  Fixed other nits as well.

Thanks.

-- Ram

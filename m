From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Thu, 27 Apr 2006 08:24:06 +1200
Message-ID: <46a038f90604261324w76f272edp93941d7e8645be8@mail.gmail.com>
References: <20060325235859.GO26071@mythryan2.michonline.com>
	 <1143336048205-git-send-email-normalperson@yhbt.net>
	 <46a038f90604251745u1b15ad99ka1aeff1cd8d8c344@mail.gmail.com>
	 <7vy7xsm6qa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Eric Wong" <normalperson@yhbt.net>, git <git@vger.kernel.org>,
	"Ryan Anderson" <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Wed Apr 26 22:24:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYqYW-0002wB-4h
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 22:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWDZUYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWDZUYI
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 16:24:08 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:44740 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964862AbWDZUYH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 16:24:07 -0400
Received: by wproxy.gmail.com with SMTP id i2so550828wra
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 13:24:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=miR+MmD+0B8ZDmI919WXD8hJzYTSzIF4Q+csZvUpnT8/QiN0A/V3y1h1GdaZHIodr+vhwzqFTGEVUTbwj0sWrUmqWa1BEyXhmmaXFQLLQDZo4JukNh/5O08yReNXqSLJhflSplkQ6SbGYiPjwlSnJR7jtUW53K5/5l09UchHF8Y=
Received: by 10.54.66.15 with SMTP id o15mr2821376wra;
        Wed, 26 Apr 2006 13:24:06 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 26 Apr 2006 13:24:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vy7xsm6qa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19219>

On 4/27/06, Junio C Hamano <junkio@cox.net> wrote:
> > system that we don't need an smtp daemon. Net::SMTP doesn't know how
> > to use /usr/bin/sendmail


> Wouldn't --smtp-server=that.smtp.server work for you?  Ah, that
> would not work if your use is to send a local mail.  Hmph...

Well, the machine knows that the smtp server is (I mean, files in /etc
have the right values in them), but I don't think often about it. Only
when I am installing OSs or MTAs...

I know... I'm a whiner! ;-) I'll probably do something that does an
eval and tries Mail::Sendmail and post it.



martin

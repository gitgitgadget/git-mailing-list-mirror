From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Wed, 11 Oct 2006 10:31:04 +0800
Message-ID: <4b3406f0610101931v7c479a9esfc3f2bccb28c2d25@mail.gmail.com>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	 <4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	 <7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	 <7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
	 <7viris9a6g.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610092336v5ab58134i280f64223a272b0b@mail.gmail.com>
	 <7vy7ro64pq.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610100346v16f1f2f6i305963bc1b398dac@mail.gmail.com>
	 <7viris2hkh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 04:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXTsL-0002Tz-04
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 04:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWJKCbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 22:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWJKCbH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 22:31:07 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:27008 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932385AbWJKCbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 22:31:06 -0400
Received: by py-out-1112.google.com with SMTP id n25so92405pyg
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 19:31:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IUiSDfynrVbGU9MSnZV6YT+5PFJsPMuH+AYT1UpTxV/8KH8KEwy/4zxjUUkx6K9LFW1bGiCWJcn8VF4Z7GDletS5L6GL/zoWXipZtBdI5i1t0c7Z8UZb0pOih83v8dUcq2pr1l3uG07bYQxRYT1/TiEqjtEUTKX7gUblrry/xBY=
Received: by 10.35.76.9 with SMTP id d9mr537070pyl;
        Tue, 10 Oct 2006 19:31:04 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Tue, 10 Oct 2006 19:31:04 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7viris2hkh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28691>

Yes, it was /tmp/gitweb permission problem.

I think it's a good idea for add a "common pitfals" section to gitweb/README.

2006/10/11, Junio C Hamano <junkio@cox.net>:
>
> Care to share your experience to help others?
>
> If it was /tmp/gitweb permission problem then the newer gitweb
> shouldn't have that issue so it would be a moot point, but if
> the pitfall still applies to the current software we might want
> to add a "common pitfals" section to gitweb/README.
>

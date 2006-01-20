From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support precise tracking of file modes
Date: Fri, 20 Jan 2006 16:27:21 +0100
Message-ID: <81b0412b0601200727r516059f1n1d3fc7b33473ed66@mail.gmail.com>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
	 <7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>
	 <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
	 <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
	 <43CF3061.2030504@michonline.com>
	 <7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
	 <20060119094156.GY28365@pasky.or.cz>
	 <7vacdsdqio.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Ryan Anderson <ryan@michonline.com>,
	Adam Hunt <kinema@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 16:28:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzyAl-0006wZ-IB
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 16:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWATP1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 10:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWATP1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 10:27:24 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:25112 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbWATP1X convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 10:27:23 -0500
Received: by uproxy.gmail.com with SMTP id s2so39798uge
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 07:27:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SNTnKrZYFfRpFKtWBoM7eucU5J3tkiGv8JykqifrA4FhvkjITrH2st0hPd/m9tLz9TpKGhbVyQvqvAN0Z7kb4iosY0mTEH6Uu4ijquE1xp64lbHeWPdnRmcJTHoxndO/yTAfFcsx05LvQq7IFzIMlGDDjOvm156ryfP7Ps8kRsI=
Received: by 10.49.39.19 with SMTP id r19mr149680nfj;
        Fri, 20 Jan 2006 07:27:21 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Fri, 20 Jan 2006 07:27:21 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacdsdqio.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14965>

On 1/19/06, Junio C Hamano <junkio@cox.net> wrote:
> Petr Baudis <pasky@suse.cz> writes:
>
> > Taking "quick'n'dirty" to the extreme _and_ combining it with Linus'
> > attitude to testing and documentation... ;-)
>
> It is premature for us mere mortals to imitate Linus in that
> aspect by at least ten years ;-).  Please don't.
>
> About the content of the change, if we were to do this, we need
> to also record owner and group. recording full permissions
> without recording owner and group does not make much sense.
>

Maybe implement tracking of a generic file attribute would be a better idea?
So that porcellans can implement permissions/ownership/EA themselves,
if they really want to...

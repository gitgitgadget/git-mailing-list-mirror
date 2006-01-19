From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 16:01:19 +0100
Message-ID: <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	 <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
	 <20060118185229.GA3001@steel.home>
	 <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:01:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzbHw-0003Y1-20
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 16:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWASPBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 10:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWASPBV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 10:01:21 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:23625 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161205AbWASPBU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 10:01:20 -0500
Received: by uproxy.gmail.com with SMTP id s2so254240uge
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 07:01:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R5HDUeDZPsmqbiG9db/KDJzIOpR+jSAJ4lHKAmAYnChruNA1aFgQmYT7iNbIsTEXkwJOad0rmoE+iPFo0U8INrGdiaHbMG5BVvm2lbzmaxfBVicg+gUk953KaZ0T+kQC72jI1CcwN8B4qvZb8x975XsL6fdvzFq4+H0QpZh+nI4=
Received: by 10.48.43.4 with SMTP id q4mr47980nfq;
        Thu, 19 Jan 2006 07:01:19 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Thu, 19 Jan 2006 07:01:19 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14910>

On 1/19/06, Junio C Hamano <junkio@cox.net> wrote:
> By the way, if you have an access to git on cygwin with FAT,
> could you test your patch ($SECONDS) and then i-num patch (the
> machine with cygwin I can borrow has only NTFS) please?

Works if sleep is for 2 secs (I completely forgot about that stupid
FAT granularity!)
st_ino is always the same (it is a hash of pathname).
Christopher, how is that supposed to work with hardlinks? (NTFS has
hardlinks, BTW)

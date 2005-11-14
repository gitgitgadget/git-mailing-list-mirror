From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 1/1] git-cvsexportcommit.perl: Fix usage() output.
Date: Tue, 15 Nov 2005 11:20:59 +1300
Message-ID: <46a038f90511141420u11e396d3q9a6710c79abe0ca3@mail.gmail.com>
References: <20051114164047.GB9131@raven.localdomain>
	 <20051114164505.GF9131@raven.localdomain>
	 <7vbr0mx4fj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kevin Geiss <kevin@desertsol.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 23:23:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbmhO-0007P8-4r
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVKNWVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 17:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVKNWVA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 17:21:00 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:7649 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932206AbVKNWVA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 17:21:00 -0500
Received: by wproxy.gmail.com with SMTP id 67so1721226wri
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 14:20:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AoRMQNdvibAkWgMFvUEdFoJDHtFYrAPZW9XQFHYUlHEai/V/GicSzRfSQiq8JUX1G924dXUF2osagsUSqqJNXROccpWOE1ruxgc54MmCmOsUn5XqKurNdLA4CgyAcJZsbp+rtTvQRI2HEourw589HNuDjrYvAil5+1wjhyWSSiU=
Received: by 10.65.218.2 with SMTP id v2mr6193256qbq;
        Mon, 14 Nov 2005 14:20:59 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Mon, 14 Nov 2005 14:20:59 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr0mx4fj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11857>

On 11/15/05, Junio C Hamano <junkio@cox.net> wrote:
> I hate to be nitpicky, but this slurps in File::Basename
> (9Kbytes) only to shorten the displayed command name.

Fair enough -- I'll leave that one up to you. I'm happy with Kevin's
patches -- what's the ideal workflow for this? Is the sign-off line
important enough that I should setup a public repo for you to pull
from?

BTW, File::Basename is a standard library usually installed w perl -- 
it shouldn't add any painful dependencies. Not sure if that matters.


martin

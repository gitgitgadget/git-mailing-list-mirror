From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Introducing GIT_DIR environment variable.
Date: Wed, 11 May 2005 01:39:12 +0200
Message-ID: <81b0412b0505101639120788a5@mail.gmail.com>
References: <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org>
	 <7voebjr5vd.fsf@assigned-by-dhcp.cox.net>
	 <7v8y2nr411.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 01:33:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVeDT-0004vB-Np
	for gcvg-git@gmane.org; Wed, 11 May 2005 01:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEJXjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 19:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVEJXjX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 19:39:23 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:51276 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261808AbVEJXjM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 19:39:12 -0400
Received: by wproxy.gmail.com with SMTP id 68so2759981wra
        for <git@vger.kernel.org>; Tue, 10 May 2005 16:39:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qAQMj+X/Ez1CnQR2xuTXsJWqifn5Ik0GMBXeY6nT8r5ycUEwAn8auzRCYPyh7wTGIQlmqRIkS4/7FvKqSvfG8slOS15hwBHHl5DIUzZHlI9fnF5JdWTKa+8d9Or6M4Di532gmg+lAf5jxal39q50lJoufOIYmn7bcfI4SRnFkq0=
Received: by 10.54.47.40 with SMTP id u40mr819963wru;
        Tue, 10 May 2005 16:39:12 -0700 (PDT)
Received: by 10.54.79.20 with HTTP; Tue, 10 May 2005 16:39:12 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y2nr411.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/10/05, Junio C Hamano <junkio@cox.net> wrote:
> Ok, following the mailing list discussion, I've done GIT_DIR and
> pushed it out to the usual git-jc repository, at:
> 
>     http://members.cox.net/junkio/git-jc.git/
> 
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Mon May 9 22:57:58 2005 -0700
> 
>     Introduce GIT_DIR environment variable.
> 

Just in case I missed it: was it already considered to use
the extended attributes (EAs) for saving pointer to GIT cache?
So I don't have to exclude anything from "grep -rn <pattern> ."

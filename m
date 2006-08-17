From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Thu, 17 Aug 2006 11:18:57 +0200
Message-ID: <81b0412b0608170218o16253515mbc9846847dfbbee6@mail.gmail.com>
References: <7vac67g5t5.fsf@assigned-by-dhcp.cox.net>
	 <20060814075305.GH21963@mellanox.co.il>
	 <7v1wrfu3tl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:19:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe1n-0001lP-Gk
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWHQJS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWHQJS7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:18:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:1712 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932381AbWHQJS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:18:58 -0400
Received: by nf-out-0910.google.com with SMTP id o25so914159nfa
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 02:18:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ICNbR7uzEi1vKzy4GqbVOgW7mkRJP7ZJWKSV+iI2VUvVsYDXAUn4I7TRmNkLthGldk/xQz774x7JFc1IVuiJG9QIFPvJe2FGXH81246mc2YQehatbW3sIGfudUptOOf+t87FOZs2P4+7dsq2wMP3e5pdB/ci6VkzHdhBJwnhv1U=
Received: by 10.48.162.15 with SMTP id k15mr1978877nfe;
        Thu, 17 Aug 2006 02:18:57 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 17 Aug 2006 02:18:56 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wrfu3tl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25562>

On 8/17/06, Junio C Hamano <junkio@cox.net> wrote:
> >> Are you by any chance running a version of git that has some
> >> unofficial patches that affect the generation of not-for-merge
> >> markers?
> >
> > No, I just reproduced this on plain 1.4.2.
>
> Doesn't reproduce for me and I am getting worried.
> Has anybody else seen this?
>

I haven't. Michael, could you retry with "GIT_TRACE=1 sh -x -v git-pull" ?
I suspect invisible (like \r) character in your remotes. Missing last \n could
be interesting too.

From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Mon, 8 May 2006 11:44:37 +1200
Message-ID: <46a038f90605071644g7c7628celc097f69b310c2db5@mail.gmail.com>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	 <e3fqb9$hed$1@sea.gmane.org>
	 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
	 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
	 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
	 <20060507120149.40e9f749.vsu@altlinux.ru>
	 <46a038f90605071627i6a335f61lf5e35291bfbe340c@mail.gmail.com>
	 <7vveshif1i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 01:44:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcsvg-0003tY-I7
	for gcvg-git@gmane.org; Mon, 08 May 2006 01:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWEGXoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 19:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWEGXoi
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 19:44:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:48909 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750967AbWEGXoh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 19:44:37 -0400
Received: by wr-out-0506.google.com with SMTP id 68so851307wri
        for <git@vger.kernel.org>; Sun, 07 May 2006 16:44:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l9a3StiWOY7/jJEzbNjiOrsr+rq84PmHha2sIMvu9dov3zPisVk5DvBTu2iu2WwzYF/ngGsuIpS6AOxzVnXxvPHVrofXzcSxi3w/mE4dTOFLXt/N7ma6vlY9YbVJ2mw+M0oxSqFqHGFmeHOepx83hGooZVoziR8sAw7qPZIQAWM=
Received: by 10.54.86.16 with SMTP id j16mr1625169wrb;
        Sun, 07 May 2006 16:44:37 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Sun, 7 May 2006 16:44:37 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vveshif1i.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19725>

On 5/8/06, Junio C Hamano <junkio@cox.net> wrote:
> It shouldn't.  The existing packfile is designed to make "git
> log" very efficient, by making it cheap to look only at the
> commit message and ancestry information.
>
> The objects are sorted first by type in the pack with the
> existing code already, and commits come first.  Try this.

Thanks for the explanation! My ignorance in the pre-coffee stage of
Monday is... exemplary. I should know better than assume that there
are trivial optimizations for git that I can come up with ;-)

I guess I should get more into the pack stuff and educate myself --
everyone's having fun with it... grumble, will have to brush up my C
to get to play.

cheers,


martin

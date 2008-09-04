From: Joshua Roys <roysjosh@gmail.com>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final evaluation
Date: Thu, 04 Sep 2008 18:22:45 -0400
Message-ID: <48C05FB5.3010901@gmail.com>
References: <200809042315.58898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 00:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbNFG-0005be-Ph
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbYIDWW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbYIDWW7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 18:22:59 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:56694 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbYIDWW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 18:22:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so33942and.103
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=E6AXEiqge6N5cNOMTKtuKzH1SpPXSXlEaSw0WwE1KWo=;
        b=tr8BF176neXhgXbRWyr+1Wa3eXEVZnnUzD0rSZsTVVjzwfxLQztQMNmGV2i+KpMHUl
         sMW3U7VrOAkl3tWTAxBku5P7yvLtXlVrmtHJCDbJqgOBDNy8Nk1dgKBTIXFQSSz4PEBR
         MEbzJ7lIz2H6jiObf4BnRQ6ln2yHNBX8aNQsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rD3YnN2EF5XQ5Qzf6TFDhyPVYvR8d/GtAQAZjPxZUZ5CO7fpUmFhBZ558EBSFOtCvy
         2GifNC2RiBLQ+TCkW3QOVJ1MQA3KA5Lhw6TrgOCA3+jY5FCT9jlok8y6gcTRl6QOSfy9
         0rtoFyrfv3ghBSEGj19ApiJUu01gWuhGrt4T8=
Received: by 10.100.140.10 with SMTP id n10mr11708332and.115.1220566976828;
        Thu, 04 Sep 2008 15:22:56 -0700 (PDT)
Received: from ?192.168.1.4? ( [67.167.142.145])
        by mx.google.com with ESMTPS id d22sm684437and.2.2008.09.04.15.22.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Sep 2008 15:22:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200809042315.58898.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94966>

Jakub Narebski wrote:
> 
> So students and mentors, please write what do you think current status 
> of project is: is it done, is it ready, is it perhaps already merged 
> in, or can be merged in at any time.  Please write also what wasn't 
> done, or what should be done different way (hindsight and all that).
> 
> Students, could you please tell us if you plan to work on git further, 
> and in what range (how much time can you get to work on git). What do 
> you think about git development community? What have you learned from 
> participating in GSoC?
> 
> 1. GitTorrent
>  
> Student: Joshua Roys
> Mentor: Sam Vilain
> 


Hello all,

VCS::Git::Torrent can only transfer data under limited circumstances at 
the moment, and doesn't do peering.  Part of that is actually due to 
work done after the deadline, unfortunately for me :-)  Anyway, I am 
definitely interested in continuing to work on git (and GitTorrent) as 
it is the VCS I use personally.  It is, however, the start of the 
semester here and I am currently focusing on that and job searching as 
this is my last semester.

I had a really good experience working with the git community over the 
past few months.  It was really cool to see very talented people working 
together.  It was a little intimidating too.  Another thing I learned 
about was the 'O' in OSS, or being 'Open' about development.  This is a 
completely different paradigm for me, as all of my previous experience 
is personal development or 'corporate' development (things done at 
work), neither of which required telling anybody about anything until 
completion.  Regular status updates that were requested during the 
second half made that much more clear and, in fact, facilitated my 
understanding in this area.

So, thank you all again, and I hope to continue to work with you in the 
future.

Joshua Roys

From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 10:24:43 -0500
Message-ID: <9e4733910702120724y2a0ba6b0h3f571aa2306872a5@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	 <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112155m3f5da9abgbeb2b6783005296f@mail.gmail.com>
	 <7vr6svaowm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 16:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGd2w-0004dF-CU
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 16:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbXBLPYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 10:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbXBLPYq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 10:24:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:47806 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964969AbXBLPYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 10:24:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so615326uga
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 07:24:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RwUexLTxNwUaWews4++lagfkWO7NS0FpXCki/vfylew2qvKlklpymunEEj7xJlMXqq7Jv8HLaiW8xTrMb/9yQndztgD58RQ5e+u6AdBfOIF5YehDF7lDqeKNIv1134pQhsKHLeRrxaYzxoCyl2/hiWnSIZcBAhGLhPrsiZtolVs=
Received: by 10.114.152.17 with SMTP id z17mr6944451wad.1171293883437;
        Mon, 12 Feb 2007 07:24:43 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Mon, 12 Feb 2007 07:24:43 -0800 (PST)
In-Reply-To: <7vr6svaowm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39409>

On 2/12/07, Junio C Hamano <junkio@cox.net> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > I am guilty of doing initial clones for different kernel trees from
> > kernel.org when I could be doing a local clone of linus' tree and then
> > pulling the deltas from kernel.org. But I'm lazy, I just kick the
> > clone off in the background and it finishes in three or four minutes.
> > I also do the clones when I have messed my local trees up so much that
> > I don't know what is in them anymore.
>
> Time to learn to use --reference perhaps?
>
>         git clone --reference linux-2.6 git://.../linville/wireless-dev.git
>
> where "linux-2.6" is local repository which is my personal copy
> of Linus's repo.

I knew you smart guys would have a command to do this. This is in the
category of a command that I use infrequently enough that I forget
about it.

Something like Cogito could be smart so that when you did a clone
command it could prompt you if you wanted a new repo or to share an
existing one.

-- 
Jon Smirl
jonsmirl@gmail.com

From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: git-unpack-objects
Date: Wed, 3 May 2006 19:31:12 -0500
Message-ID: <625fc13d0605031731v7b65a738r6fc0169958235928@mail.gmail.com>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
	 <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
	 <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org>
	 <625fc13d0605031044y2ff03ed2h261db5455b234254@mail.gmail.com>
	 <Pine.LNX.4.64.0605031054300.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 02:31:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbRkT-00070P-0K
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWEDAbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWEDAbO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:31:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:25053 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750783AbWEDAbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 20:31:13 -0400
Received: by ug-out-1314.google.com with SMTP id m3so191253ugc
        for <git@vger.kernel.org>; Wed, 03 May 2006 17:31:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9zlkDD4i190Dn2Qi4twtS6pP+Xg8CNsRF2DZMXkaT0YoBfOm2RPvTEgNLKOwAVAE/SXpV0KUEkoAPL90iqGkXxb/oorGzgfTfO2jCb9LOr4q4L/5xXS0l+nLHb2iMzgTiB7umVueDRvrv4uczknK6aOKeM9Fin7sayChaFjrek=
Received: by 10.78.31.18 with SMTP id e18mr16734hue;
        Wed, 03 May 2006 17:31:12 -0700 (PDT)
Received: by 10.78.29.19 with HTTP; Wed, 3 May 2006 17:31:12 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605031054300.4086@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19536>

On 5/3/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 3 May 2006, Josh Boyer wrote:
> > >
> > > That's what you just do "git repack -a -d" for.
> >
> > But that doesn't roll exsisting packs into a new pack, does it?
>
> It does. That's what the "-a" (for "all") does.

Odd.  On one of my repos, I was seeing the correct behavior.  On
another, there were multiple packs left after doing the 'git repack -a
-d'.  Were there ever some packing bugs in older versions of git that
would have maybe produced some packs that wouldn't get deleted or
something?

At any rate, the above command does seem to do exactly what I want. 
Thanks for the help.

josh

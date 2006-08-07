From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 17:10:10 +1200
Message-ID: <46a038f90608062210h1c13ccf9p77e19072b68d49d6@mail.gmail.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
	 <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
	 <20060806180323.GA19120@spearce.org>
	 <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 07 07:10:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9xNa-0006P7-13
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 07:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWHGFKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 01:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWHGFKN
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 01:10:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:34674 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751044AbWHGFKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 01:10:12 -0400
Received: by nf-out-0910.google.com with SMTP id p46so329327nfa
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 22:10:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E7C0uM9hhcjZJeCX4nJ9dZ8rWVUL23ILbHtqNzF2gcCc98GhVg+f4VuYoNAtFSU0KcC6wZ4MQ4PDEUqGzuhPA/HuPvtn2M4Ml13dFoGL3AC8FdADX/uHkQsK0xRXrSfdEjlodc6LI0ZXGBWhrosbiHqdJobhoaxZQovLLxxy6Zs=
Received: by 10.78.170.6 with SMTP id s6mr2280622hue;
        Sun, 06 Aug 2006 22:10:10 -0700 (PDT)
Received: by 10.78.97.17 with HTTP; Sun, 6 Aug 2006 22:10:10 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24998>

On 8/7/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> > So the new version should take about 20 MB of memory and should
> > produce a valid pack and index in the same time as it does only
> > the pack now.  Plus it won't generate duplicates.
>
> I did a run with this and it works great.

Great.

> I'm staring at the cvs2svn code now trying to figure out how to modify
> it without rewriting everything. I may just leave it all alone and
> build a table with cvs_file:rev to sha-1 mappings. It would be much
> more efficient to carry sha-1 throughout the stages but that may
> require significant rework.

Probably a good thing. If the patch isn't intrusive it has a better
chance of merging well over time and of being merged upstream -- ;-)


m

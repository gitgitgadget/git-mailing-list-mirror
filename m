From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 14:00:20 +0530
Message-ID: <cc723f590602160030n498b18edla328f7c64d44c04a@mail.gmail.com>
References: <20060216073826.GA12055@hand.yhbt.net>
	 <7v4q2zg2an.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590602160008v5fcc0e35h6d9296bd0572fac2@mail.gmail.com>
	 <7vr763emwx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 09:30:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9eX1-0003CA-5s
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 09:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWBPIaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 03:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBPIaY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 03:30:24 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:57117 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932518AbWBPIaY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 03:30:24 -0500
Received: by uproxy.gmail.com with SMTP id k40so88927ugc
        for <git@vger.kernel.org>; Thu, 16 Feb 2006 00:30:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ETj7B4nfBu8T8jOKJZsKs7O0d5vBqtUdDKQgbsShgBD6PbtcouZXulhltoFV43d5hbr6O4A66tMOHqL0Jtnmihu/yQwpmEOyFCjdUM5YhyyLt60UZbtuTZRvMZ0XwouePvZuTfQh5xnqGSPvlSUeDhM2g5kVnvQ7JocUmsGEnsw=
Received: by 10.67.23.6 with SMTP id a6mr490681ugj;
        Thu, 16 Feb 2006 00:30:20 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Thu, 16 Feb 2006 00:30:20 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr763emwx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16283>

On 2/16/06, Junio C Hamano <junkio@cox.net> wrote:
> Aneesh Kumar <aneesh.kumar@gmail.com> writes:
>
> > On 2/16/06, Junio C Hamano <junkio@cox.net> wrote:
> >>
> >> How about first adding a contrib/ directory and see how it goes?
> >
> > I am all for it. Attaching the latest gitview. This include branch and
> > tag display support and also the  option to save diffs in file.
>
> Now how do you want to proceed?  I could just dump the thing in
> say contrib/gitview subdirectory, and then afterwards you could
> either keep feeding me patches or sending me pull requests.
>
> There are two downsides doing things that way:
>
>  (1) you would lose the development history so far;
>
>  (2) if gitview script is the only thing you care about, I
>      suspect you would want to have that at the project
>      toplevel, like the "coolest merge ever" gitk merge did, but
>      that is not what you will be getting.
>
> Ideally, if we had a proper "subproject" support, I would merge
> your project with full development history so far as a
> subproject, with your toplevel grafted at contrib/gitview
> subdirectory.  That would not have neither of the above two
> downsides.  But that hasn't happened yet (and that was one of
> the reasons that I was reluctant initially -- I was hoping that
> subproject stuff would materialize sooner).
>
> For now, I'd do the easy approach (easy for me, that is) with
> both of the two downsides.  If we end up doing "subproject"
> thing, we could rectify things later, if this is OK with you.
>


It would be fine with me if you just  drop the script to
contrib/gitview directory.

-aneesh

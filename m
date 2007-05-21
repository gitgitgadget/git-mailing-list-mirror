From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Mon, 21 May 2007 10:31:09 +0100
Message-ID: <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070520211103.17468.21373.stgit@lathund.dewire.com>
	 <20070521074838.GA32510@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 21 11:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq4Eb-0004CF-By
	for gcvg-git@gmane.org; Mon, 21 May 2007 11:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbXEUJbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 05:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbXEUJbM
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 05:31:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:30119 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbXEUJbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2007 05:31:11 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1139677uga
        for <git@vger.kernel.org>; Mon, 21 May 2007 02:31:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5UCXUJTMJ1oYtvXLu0+7No+MTeBZWNQC/XQNhJd5mUAlMgrET4aHZUL6M6rWcPu36r1khe7A/sE0iI64pzMUzHWnSw4b2YOJcsuD+uwpQwHGbLo89P4QC8WKKjyiKqs95AbZYA5eFmLDl2Zl1xjqXNi2+ZQwCv2i2YdiznvjgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lWFtI1wuRmFvsP3LjyOWphsDEVbSVm0pYpGW2VFFP7ni6lgDgNtyLOkVLYp7L1SMLwiOEMr65clieq1Y3iSVO3jEpvzLvDtyiM/k3bgXJASoIBWBtxXb1nZ7MrJtitH+xKGItOFPbEPu8UvE3d8rHnjlrKkWa61DS4dTM3IEE6k=
Received: by 10.66.239.16 with SMTP id m16mr3293110ugh.1179739869571;
        Mon, 21 May 2007 02:31:09 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Mon, 21 May 2007 02:31:09 -0700 (PDT)
In-Reply-To: <20070521074838.GA32510@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48001>

On 21/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-20 23:22:00 +0200, Robin Rosenberg wrote:
> > Calling stg is too slow to be be used here. I that command in my
> > first draft for this function and people complained (see the thread
> > named "Bash snippet to show branch and patch in bash prompt"). It
> > takes ~ 0.15s on here which is very noticable, barely below my pain
> > threshold.
> >
> > We'll update the prompt when and if Karl breaks this.
>
> Yes, I can confirm that I'm hard at work breaking this. :-) I'm tryin=
g
> out a way to get around the performance bug Catalin found, but I
> didn't have time to finish it yesterday.

My plan is to release a 0.13 version pretty soon but without the DAG
patches as we might have to test them a bit more. The release after
0.13 I'd like to be a 1.0-rc1 (including the DAG patches) unless we
have some other major changes pending.

> But it sucks that stg starts so slowly. It has gotten better, I
> believe (I think Catalin did some work here?), but 150 ms doesn't
> really qualify as "instantaneous".

I don't think we can get much slower than this. I modified stg to only
load the modules needed for a given command but it still takes around
150ms for a command like 'top'. I don't know any other python tricks
to make it start faster.

BTW, any of you would like to get added as a member to
gna.org/projects/stgit (there are no advantages, only e-mail updates
for filed bug reports)?

Regards.

--=20
Catalin

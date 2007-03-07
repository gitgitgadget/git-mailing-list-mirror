From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git's is_inside_git_dir too strict?
Date: Wed, 7 Mar 2007 23:12:57 +0700
Message-ID: <fcaeb9bf0703070812y27425b07pf78fbdf14898b360@mail.gmail.com>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
	 <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
	 <20070307155307.GC27596@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 17:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOylG-0007pz-9y
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 17:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbXCGQND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 11:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbXCGQNC
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 11:13:02 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbXCGQNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 11:13:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so598320uga
        for <git@vger.kernel.org>; Wed, 07 Mar 2007 08:12:59 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JhdUwP2U1atzsUStwpsW+HGUHX6qSDWf+cRAfWEP6mFkIJekV6jZ2uTMk83dD/AUsnt2BVS6uw4cBibL0pZB1ouFp5exs26mxt6OVJQs5S39Y53ZJ6p/0tur+O8oovMeIztr/bZWU8c9g8d+DwYSWamNm0ot/2tBRI3jF21GnAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hg6cWA+Jb4Hriw5MsZpLO56xarmshSJTo5s6YJxMvw21ehkXXSfLWk47QbG9wZpQ5S3/wj2Q9ig3CSpCgzABvKRDSovST6XyPbzE5hiIEXiag2xy4cJx0m+W1gfCwGwO5JXviFoJ5PncdwutUuUAmnP4lI7kCtBP8Wa84oiUUcE=
Received: by 10.115.106.7 with SMTP id i7mr2243266wam.1173283978228;
        Wed, 07 Mar 2007 08:12:58 -0800 (PST)
Received: by 10.115.19.15 with HTTP; Wed, 7 Mar 2007 08:12:57 -0800 (PST)
In-Reply-To: <20070307155307.GC27596@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41671>

On 3/7/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > It was run in /home/pclouds/blog/data, which is the working directory
> > of data.git.
>
> Why not just symlink it?
>
>         cd /home/pclouds/blog/data
>         ln -s ../data.git .git

It's currently my workaround.

> But really, why is your Git repository for the working directory
> outside of the working directory?  Why not just move data.git to
> data/.git ?

The directory "data" is  automatically manipulated by scripts. I feel
it safer for data.git being outside of data so if I make any mistake,
data.git _might_ remain intact. You see, if I link data/.git to
data.git, my scripts' bugs might affect data.git too.

> --
> Shawn.
>


-- 
Duy

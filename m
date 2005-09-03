From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Moved files and merges
Date: Sat, 3 Sep 2005 12:20:41 +1200
Message-ID: <46a038f90509021720417a9b59@mail.gmail.com>
References: <4318E754.9000703@zytor.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 03 02:21:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBLm4-0001bv-P6
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 02:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVICAUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 20:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVICAUm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 20:20:42 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:34644 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161074AbVICAUm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 20:20:42 -0400
Received: by rproxy.gmail.com with SMTP id i8so438303rne
        for <git@vger.kernel.org>; Fri, 02 Sep 2005 17:20:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HOscGduDctDIT+TN6jXybnjii3GLdKxPrxnNM1ii1vh3cgCO20FBAvD0SjU+FywFXY0WGbayRsONj2GbJWqOEAkj/mh1PIklz2XXZE1pCUNtD910f4VQdPVz7n4OZkG91SLGHe8o9UoO3zvNLGS8RGx4qONbWj5p0jF2u32tSow=
Received: by 10.39.2.26 with SMTP id e26mr23733rni;
        Fri, 02 Sep 2005 17:20:41 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 2 Sep 2005 17:20:41 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4318E754.9000703@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8029>

On 9/3/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Is there any way I can record in the repository that these files are
> actually moved files, and that the merge should apply the patch elsewhere?

Well, if you run pickaxe at merge-time on the file-paths that weren't
found, you can probably walk the pickaxe output until you find the
file move, and then reapply the patches.

Probably should be hacked into cg-merge. When the merge reports a file
is missing, what happens? Does it leave a .rej file or anything?

cheers


martin

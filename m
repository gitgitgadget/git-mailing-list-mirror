From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: merge smart enough to adapt to renames?
Date: Sat, 21 Feb 2009 20:00:06 -0500
Message-ID: <81bfc67a0902211700m7a0d0ae8jd17a871ba102fd9f@mail.gmail.com>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
	 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>
	 <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>
	 <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>
	 <499E5A9C.6090900@dawes.za.net>
	 <e51f4f550902202048g9a210f0t8fefaee4d8376f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Sun Feb 22 02:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb2lY-0005BH-E6
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 02:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbZBVBAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 20:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbZBVBAK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 20:00:10 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:60751 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbZBVBAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 20:00:09 -0500
Received: by qyk4 with SMTP id 4so2241487qyk.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Od/R5CL9Ve1trx0LxxNgSOksF5LA6jzEY1gtBd6jBao=;
        b=X6BkA2u9RGQv+vlhmxzmd6zagdgm1Lvi2m0eyjKNrpYPz5KDDlTLrnJ74q/AXz1cwg
         BJYDnqlKStwGJNaWjgyiCYOl6ye7ceXafXyH30FTQ20WimuEOQYhg+tien7CL8QYAp2c
         epMOAu4ygdE6p2a7Pzg5siLuTDKijq7ZayMJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xagoPuqNXoA3tgx9PBAoxX18AlH7/zo2HIC72tXoRIWeRMCojR1ykipRg/mFaWjx6z
         BxeuH4v8YPQA33acj9LSE6UgUURWlk3JbHZHQBF3fEAkP4N6MHFWseJZ7xywnKwd3rjx
         QLWv0GTm/xvEFLHZgCIJAJpk3TSagU7iN7taY=
Received: by 10.229.109.194 with SMTP id k2mr1055963qcp.6.1235264406960; Sat, 
	21 Feb 2009 17:00:06 -0800 (PST)
In-Reply-To: <e51f4f550902202048g9a210f0t8fefaee4d8376f6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110987>

On Fri, Feb 20, 2009 at 11:48 PM, Kris Shannon <kris@shannon.id.au> wrote:
> Rogan Dawes wrote:
>> It seems to me that git is smart enough to figure out where contents get
>> moved to, once. Of course, if you have conflicting moves in the same
>> repo, git's automation falls down. So, if you need to move the "same"
>> file in different repositories to different places, you need to do it
>> via an intermediate repo that will be able to "remember" which movement
>> you chose.
>
> You don't need a whole different repo,  branches are good enough.
>
> git checkout gentoo-integration
> git pull gentoo
>
> git checkout sunrise-integration
> git pull sunrise
>
> git checkout master
> git merge gentoo
> git merge sunrise
>
> The integration branches can remember your local changes to
> the remotes (like the move of packages.mask)
>

it sounds like a decent plan on paper... but when you realize each
checkout is 100,000+ files...to where as if I create a repo just for
it... it ends up being like 5 files... and I'm not entirely sure that
has much of a negative side effect... other than... yet another
remote...

-- 
Caleb Cushing

http://xenoterracide.blogspot.com

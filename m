From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 01:12:32 -0500
Message-ID: <AANLkTiktuQV+jEOy+Shm13-LVc0W-d8qsGS6XuxyTW44@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com> 
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com> 
	<AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com> 
	<AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com> 
	<AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 08:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odzsw-0001Pv-EH
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 08:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab0G1GMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 02:12:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53229 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0G1GMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 02:12:53 -0400
Received: by ywh1 with SMTP id 1so708260ywh.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KEbl5N0JIpAc/7lFBJ8GNA77cMq2Idxd74MUZ/B39c8=;
        b=R9GWc5t3z08aNZeMfyzNTPIg0xAXz5soY2JF6hvhbjkQXclANsbE/AMJXa+VH4DhDo
         OGS3SAhvWrOadv9C6HiU/mvvkvAuta47R9JK9cy8GxLDRO8V3FkXxHuNktokKUAbqsGK
         /wPsECIGDqFDp8M3/rJr65uwqtePDZtzvCblw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wSwclx5na1fM5Rl482MLVibE8gwS3GHOhgE+/cyrU+k05VPykXZHfq7sYcqqLsaOo8
         1d9MI8Y2JSevErJx05vwSyDDRYWiJxvs8tRhUBJ/NDKyB593V2+y8WE45O6QRGWFTK6S
         L/cKpydezOcg7dZViMKctxr9iwwOxV6BVd/Ss=
Received: by 10.150.166.21 with SMTP id o21mr3829510ybe.70.1280297572240; Tue, 
	27 Jul 2010 23:12:52 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Tue, 27 Jul 2010 23:12:32 -0700 (PDT)
In-Reply-To: <AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152040>

Heya,

On Tue, Jul 27, 2010 at 22:58, Avery Pennarun <apenwarr@gmail.com> wrot=
e:
> Hmm, that's very interesting - more than half the repo is just tree
> and commit objects? =C2=A0Maybe that's not so shocking after all, giv=
en the
> tendency in the git project to use long commit messages and relativel=
y
> short patches.

Note that in the case of the ginormous-tree this holds as well. Many
small files, but in insanely deeply nested directories with insane
fan-out. If you need to download all the trees you don't save that
much bandwith. OTOH, I'm not only concerned about bandwidth, just
being able to run 'git status' without it taking half a minute would
be sweet.

--=20
Cheers,

Sverre Rabbelier

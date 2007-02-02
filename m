From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Fri, 2 Feb 2007 23:25:28 +0000
Message-ID: <b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	 <20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
	 <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
	 <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 00:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD7mj-0004sy-3h
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 00:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946160AbXBBXZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 18:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946163AbXBBXZd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 18:25:33 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:54300 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946160AbXBBXZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 18:25:32 -0500
Received: by an-out-0708.google.com with SMTP id b33so746647ana
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 15:25:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tj7zDmrXoCknKvaOyiHvT4ui1OENEBSjsBovdeICWUDeRULQEfmaSLkKpz4SyDQ7aNr1kt6KaL8EHSWVRqQVQc/gwTDQZTfqQhKZrD/PLpp3Odq+Q7p6g3i/+e682jmSuZ2M4coXzNhALMakX3LivDGjfGxISRjFy9DPF4Blgqw=
Received: by 10.114.151.13 with SMTP id y13mr432157wad.1170458728796;
        Fri, 02 Feb 2007 15:25:28 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Fri, 2 Feb 2007 15:25:28 -0800 (PST)
In-Reply-To: <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38540>

On 02/02/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> I tried the latest GIT and it only fails at t1200. I think I got a
> t1001 failure but I fixed it. Do you want me to push the snapshot I
> have and you can see whether it fails on your system? I tried it with
> both Python 2.4 and 2.3 but what's strange is that 'pull' run manually
> (not from the test script) seems to work.

OK, tried again and 'stg pull' doesn't update the base with the last
patch in the series ('stg rebase origin' updates it). I don't have
anything set up in my gitconfig in this area.

I already committed the patches I have (and pushed them to the public
repo) so that we know whether you have additional changes.

Thanks.

-- 
Catalin

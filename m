From: Schneelocke <schneelocke@gmail.com>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 23:19:13 +0200
Message-ID: <d4dc44d505052714193e2c1d1@mail.gmail.com>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
	 <20050527135124.0d98c33e.akpm@osdl.org>
Reply-To: Schneelocke <schneelocke@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, perex@suse.cz,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 23:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbmDn-0000Vz-VT
	for gcvg-git@gmane.org; Fri, 27 May 2005 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVE0VTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVE0VTj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 17:19:39 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:23932 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262597AbVE0VTT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 17:19:19 -0400
Received: by wproxy.gmail.com with SMTP id 69so1223253wra
        for <git@vger.kernel.org>; Fri, 27 May 2005 14:19:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MYUzfs75T0wmUhuE7vc2CkglFSAMn/X8JeLseqdtURX/3/IuhwNQgFEAgV5Rw+qVwwZUxWCQRxl1XQ8RFSzgRsf4peKN84KNI4GIXz+xrq1+RYS13OyqfxI2EYNtPBw3Du61flz1Tkk5jmNCB2+nT0wyDy0Pm7g2gXHeGD1HPAc=
Received: by 10.54.51.17 with SMTP id y17mr1810740wry;
        Fri, 27 May 2005 14:19:13 -0700 (PDT)
Received: by 10.54.5.74 with HTTP; Fri, 27 May 2005 14:19:13 -0700 (PDT)
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 27/05/05, Andrew Morton <akpm@osdl.org> wrote:
> Yes, I'll occasionally do patches which were written by "A" as:
> 
> From: A
> ...
> Signed-off-by: B
> 
> And that comes through email as:
> 
> ...
> From: <akpm@osdl.org>
> ...
> From: A
> ...
> Signed-off-by: B
> 
> which means that the algorithm for identifying the author is "the final
> From:".
> 
> I guess the bug here is the use of From: to identify the primary author,
> because transporting the patch via email adds ambiguity.
> 
> Maybe we should introduce "^Author:"?

How about "^Written-by:"? That seems to fit in much more nicely with
"Signed-off-by:".
 
-- 
schnee

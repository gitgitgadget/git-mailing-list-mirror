From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sat, 03 May 2014 14:22:48 -0500
Message-ID: <5365420874947_27397d32f016@nysa.notmuch>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com>
 <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com>
 <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com>
 <20140426072520.GB7558@sigill.intra.peff.net>
 <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
 <20140430032045.GA4613@comcast.net>
 <CAHYYfeGNO5QknoKkZfYy3XLNRZsVmf0WjeNGkDxH3QwPF-RsUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sat May 03 21:33:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgfgl-0000Tm-RP
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 21:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbaECTd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 15:33:29 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38580 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaECTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 15:33:28 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so3536007obc.9
        for <git@vger.kernel.org>; Sat, 03 May 2014 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=OdFbz5qTToUnkzYIDIXbAd5oqld/s2WheY/i/xq0ics=;
        b=Jrkb1ajsZLBd+Lmj74fl5nP5DJy+ibflRzm2x7IbgfFo+loDIgxCqZJ3iEvCq0UYE1
         vNjAlvnVbOQasogc8wFULoHjIOQOcqPSCqLG6f57OBbZproQyOVkSWFtpV5qb9f3/DJ0
         zhDtGOQ02iw1HBGebVpZ/t+IcaLW4hwB+79WpgRyhU+TWu/I5PmZOp7bNwUJ+yxeCNGa
         akGr9Mm8Ikl3rl6kSY25Lt2WMdxCw97MDmGT/zyv42o3stuTYFW55M8YqPUR5+cT+6SN
         /i0MBpB6PK2dbGlaRibB0N+JKr7F5cOlYTJC/zEO6CuNB2VGLZQGEWJLc3E1Np7LqYIi
         6gNw==
X-Received: by 10.60.54.38 with SMTP id g6mr2007191oep.79.1399145607924;
        Sat, 03 May 2014 12:33:27 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm13530169oeb.3.2014.05.03.12.33.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 12:33:26 -0700 (PDT)
In-Reply-To: <CAHYYfeGNO5QknoKkZfYy3XLNRZsVmf0WjeNGkDxH3QwPF-RsUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248046>

James Denholm wrote:
> Matthew Ogilvie <mmogilvi_git@miniinfo.net> wrote:
> > On Sun, Apr 27, 2014 at 12:35:13PM +1000, James Denholm wrote:
> >> Jeff King <peff@peff.net> wrote:
> > Agreed.  It also doesn't help that when subtree patches are proposed
> > (especially new features instead of obvious bugs), there often seems
> > to be little or no feedback from anyone.
> >
> > --------
> > Depending on how much time you have:
> >
> > This may be outside the scope of work you were planning on,
> 
> While current, immediate focus is really just getting the makefile fixed
> up and hopefully then have more people package subtree by default,
> overall I'll very likely extend that to general work on subtree and such.

I think you should take a look at the Makefile of
contrib/remote-helpers. I bet something simple like that would work just
fine for subtree.

-- 
Felipe Contreras

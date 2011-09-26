From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 20:56:04 +0200
Message-ID: <201109262056.04279.chriscool@tuxfamily.org>
References: <4DF6A8B6.9030301@op5.se> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com> <201109261147.56607.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 20:56:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8GLj-000360-3c
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab1IZS4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:56:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44480 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab1IZS4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 14:56:14 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BFD25A62A3;
	Mon, 26 Sep 2011 20:56:05 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <201109261147.56607.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182150>

On Monday 26 September 2011 19:47:56 Martin Fick wrote:
> On Monday, September 26, 2011 06:41:04 am Christian Couder
> wrote:
> > 
> > Are all these refs packed?
> 
> I think so, is there a way to find out for sure?

After "git pack-refs --all" I get:

$ find .git/refs/ -type f
.git/refs/remotes/origin/HEAD
.git/refs/stash

So I suppose that if such a find gives you only a few files all (or most of) 
your refs are packed.

Best regards,
Christian.

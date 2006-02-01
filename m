From: linux@horizon.com
Subject: Re: [Census] So who uses git?
Date: 1 Feb 2006 16:27:35 -0500
Message-ID: <20060201212735.18283.qmail@science.horizon.com>
References: <81b0412b0602010810m3577263csed57ba75e0d6bb64@mail.gmail.com>
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:29:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4PW1-0003sb-Qm
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422937AbWBAV1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBAV1r
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:27:47 -0500
Received: from science.horizon.com ([192.35.100.1]:49215 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932467AbWBAV1q
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 16:27:46 -0500
Received: (qmail 18284 invoked by uid 1000); 1 Feb 2006 16:27:35 -0500
To: linux@horizon.com, raa.lkml@gmail.com
In-Reply-To: <81b0412b0602010810m3577263csed57ba75e0d6bb64@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15449>

> Inodes are either uselessor dangerous  in cygwin (hash of an
> absolute pathname on FAT). They may not even change after rm+touch.

Yes, I just looked it up and found that out.  I was hoping they used
first block number like many Linux FSes have tried, in which case it
would have worked, but if it's a hash of the path name, it's
guaranteed not to change.

And Linus' point is excellent, too: this feature is also useful
for automated systems (like git-applypatch) that can be assumed to
never forget to warn git ahead of time.

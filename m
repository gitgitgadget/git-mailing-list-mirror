From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 23:06:06 +0200
Message-ID: <87r7gw3p6p.fsf@deneb.enyo.de>
References: <aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
	<20050426135606.7b21a2e2.akpm@osdl.org>
	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
	<20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com>
	<871x8wb6w4.fsf@deneb.enyo.de>
	<20050427151357.GH1087@cip.informatik.uni-erlangen.de>
	<426FDFCD.6000309@zytor.com>
	<20050427190144.GA28848@cip.informatik.uni-erlangen.de>
	<874qds5489.fsf@deneb.enyo.de> <426FFE58.4050901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:01:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtee-0001uT-8O
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 23:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVD0VGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD0VGY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 17:06:24 -0400
Received: from mail.enyo.de ([212.9.189.167]:21654 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262009AbVD0VGS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 17:06:18 -0400
Received: from deneb.enyo.de ([212.9.189.171])
	by albireo.enyo.de with esmtp id 1DQtjU-0001ON-C4; Wed, 27 Apr 2005 23:06:08 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.50)
	id 1DQtjS-00059v-EN; Wed, 27 Apr 2005 23:06:06 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FFE58.4050901@zytor.com> (H. Peter Anvin's message of "Wed,
	27 Apr 2005 14:04:24 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* H. Peter Anvin:

> Florian Weimer wrote:
>> Benchmarks are actually a bit tricky because as far as I can tell,
>> once you hash the directories, they are tainted even if you mount your
>> file system with ext2.
>
> That's what fsck -D is for.

Ah, cool, I didn't know that it works the other way, too.  Thanks.

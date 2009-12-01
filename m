From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: "git merge" merges too much!
Date: Tue, 1 Dec 2009 08:47:34 +0300
Message-ID: <20091201054734.GB11235@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com> <20091130211744.GA27278@dpotapov.dyndns.org> <m1NFGXS-000kn2C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 06:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFLan-0005aj-9p
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 06:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbZLAFrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 00:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZLAFrv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 00:47:51 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:49008 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZLAFrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 00:47:51 -0500
Received: by bwz27 with SMTP id 27so3159016bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rLkFMnt34yU/6ZlGvru3vWMc3+GQo5luIC/CPeWIj3M=;
        b=XXKtnjz4pgBQXWUzktidJr6zZj+l/jBPP98vXPSzapSnOUjkp/acwHwoSK+KL5L/SF
         ea3IvFpyKayDJRU9kB3gqeH0LeO6lOXFTgsPcOzkGyQCaEEMu8VqzB+whS8buSzKRFUW
         cddtl+gHoVQSj0Raerp0jxxRBc8bdjO1lm7cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L3b/3Ar+qgmDh/KjvYYQpgT8qcLZSJW8tAVd/Y4/SxN9miuODlWj9MpVfnk+8HiCJM
         Wa3JfmVQgdc5uQ8Yi4i4/w4jpKACemq3w6YmdsP7GkDJ92q/X8gIjOcrk8HewxudVDhL
         ywOUS6oItAJHnuho7HYWYRzGu65HDs2DhNO0s=
Received: by 10.204.25.19 with SMTP id x19mr5013997bkb.189.1259646476107;
        Mon, 30 Nov 2009 21:47:56 -0800 (PST)
Received: from localhost (ppp85-140-126-192.pppoe.mtu-net.ru [85.140.126.192])
        by mx.google.com with ESMTPS id 16sm1737883fxm.12.2009.11.30.21.47.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 21:47:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFGXS-000kn2C@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134165>

On Mon, Nov 30, 2009 at 07:24:14PM -0500, Greg A. Woods wrote:
> 
> Things get even weirder if you happen to be playing with older branches
> too -- most build tools don't have ability to follow files that go back
> in time as they assume any product files newer than the sources are
> already up-to-date, no matter how much older the sources might become on
> a second build.

No, files do not go back in time when you switch between branches. The
timestamp on files is the time when they are written to your working
tree (and it is so with other VCSes that I worked with, so I do not
know where you get idea of file timestamps going back in time). Thus any
building tool such as 'make' should work fine provided you have correct
dependencies. I have switched between widely diversed branches, and I
have never had any problem with that.


Dmitry

From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 00:01:41 -0500
Message-ID: <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGTK0-00016t-Cc
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbXBLFBn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbXBLFBn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:01:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:35094 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbXBLFBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:01:42 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1532450wri
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 21:01:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RSk7GptU3vjRhx5YlZbX9GRN35rzzbqX2HMPQv2loFToDCmkL2TTegULNn3/2n0uezRLmgkWBLT0mUZrFiHYQCXXubwsJrFndvKKXCs/WUeMsUv3+w++NK+6vOA8TBPNUL3xyVbCJIAiatJgBReTIhYYzzgRf97zofnuZNYSOUo=
Received: by 10.114.171.1 with SMTP id t1mr5544385wae.1171256501784;
        Sun, 11 Feb 2007 21:01:41 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 21:01:41 -0800 (PST)
In-Reply-To: <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39364>

On 2/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Same thing with cg clone, it's what is broken.
> cg update is broken in the same way.
> I'm using the current git version of cogitio.
> I'll switch to the git commands, git clone is about 10x faster for the
> clone anyway.

Don't read anything into the 10x speed diff, my last git clone was
really slow. I'm probably fighting other people at kernel.org to keep
the tree in RAM.

But pack to the original point, can't the server check and see if it
has write access so that it can keep the fully packed tree? I've just
caused kernel.org to needlessly repack the wireless-dev tree a dozen
times playing with this clone command. If it didn't have to keep
repacking for the clone, clone would be a lot faster.

-- 
Jon Smirl
jonsmirl@gmail.com

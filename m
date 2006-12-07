X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 7 Dec 2006 22:26:30 +0100
Message-ID: <46d6db660612071326m4817165l992e8d6e7bd673c5@mail.gmail.com>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	 <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	 <20061207192632.GC12143@spearce.org>
	 <20061207193555.GD12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 21:26:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A/MZ/77wGN8RHpSmcwzTROyrYShBxdADLLDHiSXDz+aNzO4JIpDjaYBtolqOdcZTN/QXollCwmhzFiCuQe+byQmCuKCkoJRKjYrmZaaPBg3mLF5errvUaWL9moHlSV4+rIk6wbWv5+5J9m10Togr32JL7X0C/pce3oNpH09OCY4=
In-Reply-To: <20061207193555.GD12143@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33635>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsQlJ-00072Q-7F for gcvg-git@gmane.org; Thu, 07 Dec
 2006 22:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163402AbWLGV0e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 16:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163403AbWLGV0e
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 16:26:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:20814 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1163402AbWLGV0d (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 16:26:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so582171uga for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 13:26:31 -0800 (PST)
Received: by 10.78.127.3 with SMTP id z3mr1688810huc.1165526791222; Thu, 07
 Dec 2006 13:26:31 -0800 (PST)
Received: by 10.78.138.1 with HTTP; Thu, 7 Dec 2006 13:26:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 12/7/06, Shawn Pearce <spearce@spearce.org> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
> > Its Cygwin/NTFS.  lstat() is slow.  readdir() is slow.  I have the
> > same problem on my Cygwin systems.
>
> Just to be clear, I'm not trying to blame Cygwin here.
>
> Windows' dir command is slow.  Windows Explorer is slow while
> browsing directories.  Eclipse chugs hard while doing any directory
> scans (it normally runs very fast if its not rescanning the entire
> directory structure).  The drive is just plain slow.
> (...)

before buying any new hardware, you could easily imagine the
following scenario (I'm also "stuck" with windows, so it's an idea
I've been toying around for a week or so).

There're virtualizers around, on which networking capabilities can
be activated. And we could easily create a vm with linux+git
inside, using ext2/ext3/ext4 fs virtual disks (you'd benefit from
windows cache actually...)

example: YTech_Subversion_Appliance_v1.1 (ubuntu + subversion).

I've no prototype yet, but I've 2 scenario possible:
1) use vmplayer and a minimal uclibc initramfs with git onboard
2) use qemu+kqemu and a similar mini-distro (but right now networking
is an issue on windows hosts: I'm exploring tunneling)

The 1st scenario is "easy". And I start to prefer this idea over
even mingw porting of git (I tried and it's hard, really).

But again, maybe jgit would be a better universal solution.

-- 

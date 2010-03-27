From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 12:32:22 -0700
Message-ID: <20100327193222.GI10910@spearce.org>
References: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> <alpine.LFD.2.00.1003262142121.694@xanadu.home> <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com> <alpine.LFD.2.00.1003270959110.694@xanadu.home> <20100327191405.GF10910@spearce.org> <4BAE5CB9.6020905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvbkG-000737-MI
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab0C0Tc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:32:27 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:46010 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab0C0Tc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:32:26 -0400
Received: by ywh2 with SMTP id 2so4178649ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:32:25 -0700 (PDT)
Received: by 10.101.159.2 with SMTP id l2mr4736843ano.142.1269718345803;
        Sat, 27 Mar 2010 12:32:25 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm2098762iwn.12.2010.03.27.12.32.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:32:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BAE5CB9.6020905@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143349>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Shawn O. Pearce wrote:
>>
>> IMHO, this leading '0' thing is a similar breakage.  We shouldn't
>> relax CGit or JGit to accept it just because the Ruby implementation
>> of Git got the tree encoding wrong.  If anything, we should teach
>> these implementations to catch these sorts of problems earlier.
>
> Just add an additional data point, it looks like up to 16 of these trees  
> with zero-padded file modes are reachable from Linus' kernel master ref.

Frell.

We can't ask Linus to rewrite his history to repair this breakage.
The fact that its made it into the kernel history means we have
to accept this.  The kernel project is simply too large and move
too fast for us to ask them to fix their repository history.
Smaller projects of 1-2 people, we could have gotten away with
asking them to fix their history.

I guess that answers the questions then.  CGit permits this with
a warning, and must always continue to do that.  And JGit needs to
fix itself to do the same.

-- 
Shawn.

From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 15:39:24 -0400
Message-ID: <4BAE5EEC.5090804@gmail.com>
References: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> <alpine.LFD.2.00.1003262142121.694@xanadu.home> <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com> <alpine.LFD.2.00.1003270959110.694@xanadu.home> <20100327191405.GF10910@spearce.org> <4BAE5CB9.6020905@gmail.com> <20100327193222.GI10910@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:39:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvbr5-0001xZ-E4
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab0C0Tj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:39:29 -0400
Received: from mail-iw0-f196.google.com ([209.85.223.196]:59436 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0C0Tj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:39:28 -0400
Received: by iwn34 with SMTP id 34so9029136iwn.15
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=SSo+irmAeJK3+dB9RdgKC/CXdwQgcIFCpj6cbYyJzqw=;
        b=u9gLBN1f5sqnPx/c9/qxHICZotK5z7WaGy5mZVV8GP+CpU3Ov0w1JDsYsrFB598IlZ
         BbOXxneu2hpuvXpDg0T2F5qBD4GR7//OyM6/g3aULNfLEpc0OKX5+cq3HjAzDQI7f9WO
         1HlhjyRKoMPRNzqiMhDdcBlcGacKTYbPgJH7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=PHt5Y2r64aB0zH6kbAjQeDw6DFyC0PyxdI6snoPb4ZKAxUlbWfYPi7f15AMyn5EgTw
         Ty3LOErJRozPbtn4BBgsMuddy9vb5tK9AvHMEK1YrxblgSmwR4aQBAaK+IW8YPKWRKYJ
         sb6Mj96U8imfsnz2kH+3mYDK1FOvcMP3VAsDw=
Received: by 10.231.148.1 with SMTP id n1mr1360593ibv.96.1269718767969;
        Sat, 27 Mar 2010 12:39:27 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id a1sm1984844ibs.6.2010.03.27.12.39.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:39:26 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20100327193222.GI10910@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143350>

Shawn O. Pearce wrote:
> A Large Angry SCM <gitzilla@gmail.com> wrote:
>> Shawn O. Pearce wrote:
>>> IMHO, this leading '0' thing is a similar breakage.  We shouldn't
>>> relax CGit or JGit to accept it just because the Ruby implementation
>>> of Git got the tree encoding wrong.  If anything, we should teach
>>> these implementations to catch these sorts of problems earlier.
>> Just add an additional data point, it looks like up to 16 of these trees  
>> with zero-padded file modes are reachable from Linus' kernel master ref.
> 
> Frell.
> 
> We can't ask Linus to rewrite his history to repair this breakage.
> The fact that its made it into the kernel history means we have
> to accept this.  The kernel project is simply too large and move
> too fast for us to ask them to fix their repository history.
> Smaller projects of 1-2 people, we could have gotten away with
> asking them to fix their history.
> 
> I guess that answers the questions then.  CGit permits this with
> a warning, and must always continue to do that.  And JGit needs to
> fix itself to do the same.
> 

Wait a minute, something strange is going on here.

My combined kernel repository has 16 of these things according to 
git-fsck. And when I do 'git-fsck torvalds/linux-2.6/master' I get the 
same 16 BUT when I 'git-rev-list --objects torvalds/linux-2.6/master' 
they do not appear in the output.

From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 21:30:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003262125120.694@xanadu.home>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org>
 <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org>
 <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 02:30:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvKrC-0002jO-4u
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 02:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab0C0BaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 21:30:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57090 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0C0BaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 21:30:14 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZX00JL32UD3UB0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Mar 2010 21:30:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100327012211.GD10910@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143310>

On Fri, 26 Mar 2010, Shawn O. Pearce wrote:

> "Mike.lifeguard" <mike.lifeguard@gmail.com> wrote:
> > On 10-03-26 08:56 PM, Avery Pennarun wrote:
> > > The problem is that everything in git works perfectly with these
> > > invalid file modes *except* fsck, and there's rarely a need to run
> > > fsck, so this problem can hide for a long time.
> > 
> > So, does the error matter or not? If it doesn't matter, then shouldn't
> > Jgit stop whining? If it does, then whatever-it-is needs to be fixed.
> 
> Its less harmful than other types of corruption.  But its quite
> wrong from a format perspective. The hash of the tree differs even
> though there is no semantic difference in the tree content.
> 
> Given that GitHub has blessed the world with this corruption,
> we may need to modify JGit to accept it.

Should we?

This is going to screw up pack v4 (yes, someday I'll have the time to 
make it real).


Nicolas

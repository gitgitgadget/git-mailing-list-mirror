From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 15:28:28 -0500
Message-ID: <FyEIt68YHr11lsX_CGcHmYfITTgX-iSs9tVNIBMG7FQ_WhGc4ttvXw@cipher.nrlssc.navy.mil>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <20100902155810.GB14508@sigill.intra.peff.net> <alpine.LFD.2.00.1009021233190.19366@xanadu.home> <4C7FDA32.5050009@gmail.com> <alpine.LFD.2.00.1009021326290.19366@xanadu.home> <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com> <20100902192910.GJ32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGP0-0001aR-F3
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab0IBU2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 16:28:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37518 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab0IBU2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 16:28:37 -0400
Received: by mail.nrlssc.navy.mil id o82KSTbn027910; Thu, 2 Sep 2010 15:28:29 -0500
In-Reply-To: <20100902192910.GJ32601@spearce.org>
X-OriginalArrivalTime: 02 Sep 2010 20:28:29.0323 (UTC) FILETIME=[67671DB0:01CB4ADD]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155196>

On 09/02/2010 02:29 PM, Shawn O. Pearce wrote:
> Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
>>
>>  * based on what you kindly mentioned about "git repack -f", would a
>> (well-written!) patch to git pack-objects to add a
>> "--single-thread-only" option be acceptable?
> 
> Probably not.  I can't think of a good reason to limit the number
> of threads that get used.  We already have pack.threads as a
> configuration variable to support controlling this for the system,
> but that's about the only thing that really makes sense.

I think pack-objects already has a --threads option allowing to
specify the number of threads to use.

   --threads=1

should do it.

-Brandon

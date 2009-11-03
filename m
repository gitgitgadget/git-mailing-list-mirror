From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git hang with corrupted .pack
Date: Tue, 3 Nov 2009 14:28:35 -0800
Message-ID: <20091103222834.GC10505@spearce.org>
References: <20091014042249.GA5250@hexapodia.org> <20091014142351.GI9261@spearce.org> <alpine.LFD.2.00.0910141208170.20122@xanadu.home> <20091014161259.GK9261@spearce.org> <alpine.LFD.2.00.0910141234540.20122@xanadu.home> <20091014180302.GL9261@spearce.org> <alpine.LFD.2.00.0910141435040.20122@xanadu.home> <7vbpk985t1.fsf@alter.siamese.dyndns.org> <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com> <4AF0A132.1060103@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Rru-0004BZ-SU
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 23:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbZKCW2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbZKCW2c
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 17:28:32 -0500
Received: from george.spearce.org ([209.20.77.23]:60542 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbZKCW2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 17:28:30 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2893F381FE; Tue,  3 Nov 2009 22:28:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AF0A132.1060103@obry.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132004>

Pascal Obry <pascal@obry.net> wrote:
> Le 20/10/2009 17:14, Alex Riesen a ??crit :
>> I seem to have problems with this change (on Cygwin). Sometimes
>> accessing an object in a pack fails in unpack_compressed_entry.
>> When it happens, both avail_in and avail_out of the stream are 0,
>> and the reported status is Z_BUF_ERROR.
>> Output with the second attached patch:
>>
>> error: *** inflate error: 0x862380 size=1256, avail_in=0 (was 697),
>> avail_out=0 (was 1256)
>> error: *** unpack_compressed_entry failed
>> error: failed to read object 3296766eb5531ef051ae392114de5d75556f5613
>> at offset 2620741 from
>> .git/objects/pack/pack-996206790aaefbf4d34c86b3ff546bb924546b7c.pack
>> fatal: object 3296766eb5531ef051ae392114de5d75556f5613 is corrupted
>
> I have this problem on some repository on Cygwin too. For now I have  
> reverted to Git 1.6.4 which seems to be working fine.

It was fixed in 1.6.5.2 by Junio.

-- 
Shawn.

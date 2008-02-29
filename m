From: Jon Loeliger <jdl@freescale.com>
Subject: Re: warning: no common commits - slow pull
Date: Fri, 29 Feb 2008 08:44:59 -0600
Message-ID: <47C81A6B.1060905@freescale.com>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271605540.19665@iabervon.org> <20080228004313.GQ8410@spearce.org> <20080228085038.GS8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 15:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV6Wv-0001Sl-5j
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 15:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759187AbYB2OrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 09:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758871AbYB2OrH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 09:47:07 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:56951 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759228AbYB2OrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 09:47:06 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m1TEj8fg014886;
	Fri, 29 Feb 2008 07:45:08 -0700 (MST)
Received: from [10.213.161.2] (vpn-10-213-161-2.am.freescale.net [10.213.161.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m1TEj69R019307;
	Fri, 29 Feb 2008 08:45:07 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080228085038.GS8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75540>

Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> Daniel Barkalow <barkalow@iabervon.org> wrote:

>> I agree its outside of 1.5.5, as we'd all like to see 1.5.5 happen
>> soon, but it could be 1.5.6 material, especially if someone starts
>> working on it sooner rather than later.
>>
>> Its actually probably not that difficult to implement.
> 
> OK, so I posted a fairly short series tonight (4 patches) that
> handles some of the common cases in a fairly small amount of
> code churn.  It might just be 1.5.5-ish.
> 
> Doing anything better is going to require a new protocol extension,
> which is already 1.5.6 material.  In the mean time maybe Junio's
> earlier patch to try and drop the ref_map when we do open the new
> connection is the way to deal with the round-robin DNS issues.


Hmmm... Might the any protocol extensions require a 1.6 release
rather than a 1.5.x release?  Or is this extension compatible
enough that it can be transparent?

Thanks,
jdl

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:28:53 -0700
Message-ID: <20080828172853.GE21072@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Aug 28 19:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlJn-00005h-EL
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYH1R2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYH1R2y
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:28:54 -0400
Received: from george.spearce.org ([209.20.77.23]:60252 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbYH1R2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:28:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B08E638375; Thu, 28 Aug 2008 17:28:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94097>

david@lang.hm wrote:
> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
>>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>> Yes, I really did mean for this part of the protocol to be in binary.
>
> except that HTTP cannot transport binary data, if you feed it binary data 
> it then encodes it into 7-bit safe forms for transport.

So then how does it transport a GIF file to my browser?  uuencoded?
Last time I read the RFCs I was pretty certain HTTP is 8-bit clean
in both directions.

Of course this may all be moot.  I think we're moving in a direction
of matching the git native protocol more exactly.

-- 
Shawn.

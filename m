From: david@lang.hm
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 11:12:13 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808281111310.2713@asgard.lang.hm>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <48B6E3C0.4010608@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlzc-0006p8-5h
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYH1SMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbYH1SMF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:12:05 -0400
Received: from mail.lang.hm ([64.81.33.126]:60567 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbYH1SME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:12:04 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7SIBlZE017363;
	Thu, 28 Aug 2008 11:11:47 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <48B6E3C0.4010608@zytor.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94107>

On Thu, 28 Aug 2008, H. Peter Anvin wrote:

> david@lang.hm wrote:
>> except that HTTP cannot transport binary data, if you feed it binary data 
>> it then encodes it into 7-bit safe forms for transport.
>
> Total utter bunk.  You're thinking of email and news, which had to deal with 
> broken legacy code.
>
> HTTP has *always* been binary clean.  It does not encode anything into 7-bit 
> safe anything.  The only "encoding" that it ever does is HTTP/1.1's chunked 
> encoding, which is a way to deal with the fact that it might not always know 
> the total length of the data before it starts the transfer; it sends the data 
> in arbitrary-sized "chunks" prefixed by a byte count.  It does this to 
> support connection caching in HTTP/1.1; HTTP/1.0 would simply close the 
> connection to indicate end of (binary) data.

Ok, I was wrong, thanks to everyone for correcting me. I now know this.

David Lang

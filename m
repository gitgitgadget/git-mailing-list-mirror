From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 11:47:35 -0700
Message-ID: <48B6F2C7.1010801@zytor.com>
References: <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com> <20080828171052.GC21072@spearce.org> <48B6DE7A.1020207@zytor.com> <20080828172623.GD21072@spearce.org> <alpine.LFD.1.10.0808281432240.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmYr-0001Ml-VA
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYH1Ssd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYH1Ssd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:48:33 -0400
Received: from terminus.zytor.com ([198.137.202.10]:35439 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYH1Ssc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:48:32 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7SIlhmv013567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 11:47:43 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7SIlhAC026735;
	Thu, 28 Aug 2008 11:47:43 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7SIlZE9030518;
	Thu, 28 Aug 2008 11:47:37 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.LFD.1.10.0808281432240.1624@xanadu.home>
X-Virus-Scanned: ClamAV 0.93.3/8110/Thu Aug 28 10:43:02 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94112>

Nicolas Pitre wrote:
>> Should I change the HTTP protocol then to use the same format,
>> so they have a better chance at sharing code between them?
> 
> Given that the ref exchange happens on multiple lines (one ref per line) 
> in the native protocol, and that your proposal is using one line for 
> multiple refs, I don't see this as a big factor wrt code reuse.  Since 
> you'll have separate "output" code anyway, why not simply going with 
> refs in straight binary for the HTTP protocol?  Even the debugability of 
> refs exchange in plain text is dubious especially with all refs on the 
> same line (that'll be a pain to split refs out of a long stream of hex 
> by hand).

Well, I think the real question was to go to multiple lines, 
native-protocol style, or go to binary.

	-hpa

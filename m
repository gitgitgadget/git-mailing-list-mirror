From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 11:14:13 -0700
Message-ID: <48B6EAF5.4030704@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <48B6E3C0.4010608@zytor.com> <alpine.DEB.1.10.0808281111310.2713@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Aug 28 20:16:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYm2L-0007lB-T5
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbYH1SOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYH1SOv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:14:51 -0400
Received: from terminus.zytor.com ([198.137.202.10]:58101 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbYH1SOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:14:51 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7SIEKv8010427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 11:14:20 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7SIEKJM026498;
	Thu, 28 Aug 2008 11:14:20 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7SIED6r030230;
	Thu, 28 Aug 2008 11:14:14 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.10.0808281111310.2713@asgard.lang.hm>
X-Virus-Scanned: ClamAV 0.93.3/8109/Thu Aug 28 07:33:58 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94108>

david@lang.hm wrote:
> 
> Ok, I was wrong, thanks to everyone for correcting me. I now know this.
> 

It's an easy mistake to make given HTTP's apparent connections with 
MIME.  However, all it uses from MIME is the type tags, it doesn't use 
MIME encapsulation format at all.

	-hpa

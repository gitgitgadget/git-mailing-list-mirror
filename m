From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 21:15:51 -0700
Message-ID: <48B38377.3050901@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826034544.GA32334@spearce.org> <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Aug 26 06:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXpzV-0001uT-Kw
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 06:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYHZEQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 00:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbYHZEQG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 00:16:06 -0400
Received: from terminus.zytor.com ([198.137.202.10]:37786 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYHZEQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 00:16:05 -0400
Received: from [172.27.2.85] (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7Q4FpMM024114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 21:15:52 -0700
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm>
X-Virus-Scanned: ClamAV 0.93.3/8089/Mon Aug 25 17:28:51 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93707>

david@lang.hm wrote:
> 
> on the other hand, it would be a good thing if pack files could be cached.
> 
> in a peer-peer git environment the cache would not be used very much, 
> but when you have a large number of people tracking a central repository 
> (or even a pseudo-central one like the kernel) you have a lot of people 
> upgrading from one point to the next point.
> 

Worth noting that this also applies to the raw git protocol.

	-hpa

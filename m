From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 21:42:37 -0700
Message-ID: <48B389BD.9050606@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826034544.GA32334@spearce.org> <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm> <48B38377.3050901@zytor.com> <alpine.DEB.1.10.0808252121510.30743@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Aug 26 06:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXqPJ-0005f7-Rx
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 06:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbYHZEmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 00:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbYHZEmq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 00:42:46 -0400
Received: from terminus.zytor.com ([198.137.202.10]:34720 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYHZEmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 00:42:46 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7Q4giwD025470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 21:42:44 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7Q4ghfn005327;
	Mon, 25 Aug 2008 21:42:43 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7Q4gbP0025532;
	Mon, 25 Aug 2008 21:42:38 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.10.0808252121510.30743@asgard.lang.hm>
X-Virus-Scanned: ClamAV 0.93.3/8089/Mon Aug 25 17:28:51 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93709>

david@lang.hm wrote:
> On Mon, 25 Aug 2008, H. Peter Anvin wrote:
> 
>> david@lang.hm wrote:
>>>
>>> on the other hand, it would be a good thing if pack files could be 
>>> cached.
>>>
>>> in a peer-peer git environment the cache would not be used very much, 
>>> but when you have a large number of people tracking a central 
>>> repository (or even a pseudo-central one like the kernel) you have a 
>>> lot of people upgrading from one point to the next point.
>>>
>>
>> Worth noting that this also applies to the raw git protocol.
> 
> IIRC the native git server will use existing packs when it can.
> 

Yes (and the smart http server should, too).  However, neither of them 
can currently generate new packfiles and save them for future use in a 
separate directory from the repository tree.

	-hpa

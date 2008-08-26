From: david@lang.hm
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 21:25:06 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808252121510.30743@asgard.lang.hm>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826034544.GA32334@spearce.org> <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm> <48B38377.3050901@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 06:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXq9W-0003SA-Nq
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 06:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbYHZEYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 00:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbYHZEYj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 00:24:39 -0400
Received: from mail.lang.hm ([64.81.33.126]:47013 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYHZEYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 00:24:39 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7Q4ObBj018433;
	Mon, 25 Aug 2008 21:24:37 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <48B38377.3050901@zytor.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93708>

On Mon, 25 Aug 2008, H. Peter Anvin wrote:

> david@lang.hm wrote:
>> 
>> on the other hand, it would be a good thing if pack files could be cached.
>> 
>> in a peer-peer git environment the cache would not be used very much, but 
>> when you have a large number of people tracking a central repository (or 
>> even a pseudo-central one like the kernel) you have a lot of people 
>> upgrading from one point to the next point.
>> 
>
> Worth noting that this also applies to the raw git protocol.

IIRC the native git server will use existing packs when it can.

it would be interesting to modify git to record what packs it generates 
and then see how much a big server (like kernel.org) would re-use a pack 
under different caching strategies.

David Lang

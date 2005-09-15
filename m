From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Thu, 15 Sep 2005 10:01:16 -0400
Organization: Network Appliance, Inc.
Message-ID: <43297EAC.6020205@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <20050912145629.28120.70337.stgit@dexter.citi.umich.edu> <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu> <Pine.LNX.4.63.0509141214490.23242@iabervon.org> <43287ECB.8090308@citi.umich.edu> <Pine.LNX.4.63.0509141622340.23242@iabervon.org> <4328A3F9.1010506@citi.umich.edu> <Pine.LNX.4.58.0509141549270.26803@g5.osdl.org> <Pine.LNX.4.63.0509141901020.23242@iabervon.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070000010501010200030508"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 16:04:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFuIy-0005WE-KY
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 16:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVIOOBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVIOOBU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 10:01:20 -0400
Received: from citi.umich.edu ([141.211.133.111]:41247 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964960AbVIOOBS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 10:01:18 -0400
Received: from [10.58.53.165] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 33D8A1BADE;
	Thu, 15 Sep 2005 10:01:17 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509141901020.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8605>

This is a multi-part message in MIME format.
--------------070000010501010200030508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Barkalow wrote:
> On Wed, 14 Sep 2005, Linus Torvalds wrote:
> 
> 
>>On Wed, 14 Sep 2005, Chuck Lever wrote:
>>
>>>oh, i see.  the hash table won't help cache_find_name find an insertion 
>>>point quickly if the name isn't already in the cache.
>>
>>Note that almost all insertion tends to happen linearly.
>>
>>In particular, read-tree always inserts things in order.
> 
> read-tree (with Chuck's latest work) should actually only append entries 
> to an initially-empty list, which is even easier. Dunno about the other 
> stuff, but I'd guess inserting into a cursor would handle a lot of it.

i'm implementing the splay tree now.

part of the insertion process is to splay the insertion point up to the 
root of the tree.  if what you and linus says is true, then the search 
for the next insertion point will be very fast most of the time.

--------------070000010501010200030508
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------070000010501010200030508--

From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Mon, 12 Sep 2005 20:02:22 -0400
Organization: Network Appliance, Inc.
Message-ID: <4326170E.5040509@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <20050912145629.28120.70337.stgit@dexter.citi.umich.edu> <Pine.LNX.4.63.0509121633480.23242@iabervon.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030607090408040607010308"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 02:02:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEyFn-0008IM-CN
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 02:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVIMACY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVIMACY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 20:02:24 -0400
Received: from citi.umich.edu ([141.211.133.111]:152 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932370AbVIMACY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 20:02:24 -0400
Received: from [10.58.52.181] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 3106F1BACF;
	Mon, 12 Sep 2005 20:02:23 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509121633480.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8456>

This is a multi-part message in MIME format.
--------------030607090408040607010308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Barkalow wrote:
> On Mon, 12 Sep 2005, Chuck Lever wrote:
>>For now, we simply replace indpos with a cache cursor.  Likely more
>>changes will be needed after we successfully replace the cache array
>>with an abstract data type.
> 
> The right order is probably to add the concept of a cache that isn't the 
> one that normal functions deal with, have read_cache_unmerged return such 
> a thing, call cc_init with that, and rip out all of the removal and 
> position adjustment code. Then read_tree won't care at all about the 
> internal structure of the cache type, and it can be replaced without any 
> problem.

yeah, i've come to the same conclusion, and started screwing with this 
idea today.

--------------030607090408040607010308
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


--------------030607090408040607010308--

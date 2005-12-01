From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 7/7] Use a separate directory for patches under each branch
 subdir
Date: Wed, 30 Nov 2005 21:53:33 -0500
Organization: Network Appliance, Inc.
Message-ID: <438E65AD.4050807@citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>	 <20051129220951.9885.59702.stgit@dexter.citi.umich.edu>	 <b0943d9e0511301423h2885d442r@mail.gmail.com>	 <438E2797.2020205@citi.umich.edu> <b0943d9e0511301432m10b25887r@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000300050103030505010503"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 03:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EheZm-0005Lt-CU
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 03:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVLACxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 21:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVLACxg
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 21:53:36 -0500
Received: from citi.umich.edu ([141.211.133.111]:59933 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751368AbVLACxf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 21:53:35 -0500
Received: from [10.58.48.198] (nat-198-95-226-230.netapp.com [198.95.226.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id 966611BBA2;
	Wed, 30 Nov 2005 21:53:34 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511301432m10b25887r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13038>

This is a multi-part message in MIME format.
--------------000300050103030505010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> A separate stg command for this would be useful. Anyway since the
> repository structure might change again in the future, I think it
> would be better to have a version string saved somewhere in
> .git/patches/version for reference.

note that we have the same problem with .git/patches that this patch 
fixes in the .git/patches/<series> directories; namely, that if we add 
files in .git/patches, we can't have branches with the same names.

i was thinking of perhaps creating a .git/stgit subdirectory that might 
contain the config file, an stgit metadata version file, and perhaps any 
locally modified copies of the template files.

--------------000300050103030505010503
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


--------------000300050103030505010503--

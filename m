From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 7/7] Use a separate directory for patches under each branch
 subdir
Date: Wed, 30 Nov 2005 17:28:39 -0500
Organization: Network Appliance, Inc.
Message-ID: <438E2797.2020205@citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>	 <20051129220951.9885.59702.stgit@dexter.citi.umich.edu> <b0943d9e0511301423h2885d442r@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080507030707090109080803"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhaRO-000773-Q7
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVK3W2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVK3W2k
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:28:40 -0500
Received: from citi.umich.edu ([141.211.133.111]:65160 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751058AbVK3W2j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 17:28:39 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id 5E7E21BB7E;
	Wed, 30 Nov 2005 17:28:39 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511301423h2885d442r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13025>

This is a multi-part message in MIME format.
--------------080507030707090109080803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 29/11/05, Chuck Lever <cel@netapp.com> wrote:
> 
>>Currently you can't specify a patch name that matches the name of one of
>>the stgit special files under .git/patches/<branch-name>.  Let's use a
>>new subdirectory under .git/patches/<branch-name> to contain just the
>>patch directories to remove this limitation.
> 
> 
> This patch doesn't fix the already created branches. It would be
> useful to upgrade the branch structure automatically if the patches
> directory is not found.

the reason i didn't do that is because i wanted to allow older versions 
of StGIT to continue to work on existing repositories.

what if i added a migration tool to allow a user to switch back and forth?

--------------080507030707090109080803
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
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------080507030707090109080803--

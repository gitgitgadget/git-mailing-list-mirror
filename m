From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Thu, 17 Nov 2005 17:50:49 -0500
Organization: Network Appliance, Inc.
Message-ID: <437D0949.3060505@citi.umich.edu>
References: <20051113194225.20447.57910.stgit@zion.home.lan>	 <b0943d9e0511150154y2d2af24ck@mail.gmail.com>	 <200511161544.13825.blaisorblade@yahoo.it> <b0943d9e0511171410y357fb0bfv@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010806000101070406070401"
Cc: Blaisorblade <blaisorblade@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 23:53:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcsbN-0007O6-HT
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 23:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVKQWuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 17:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKQWuv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 17:50:51 -0500
Received: from citi.umich.edu ([141.211.133.111]:54853 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964848AbVKQWuu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 17:50:50 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 750B71BAD1;
	Thu, 17 Nov 2005 17:50:49 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511171410y357fb0bfv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12165>

This is a multi-part message in MIME format.
--------------010806000101070406070401
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 16/11/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
>>>Another option would be to
>>>remove the file and leave both file.older and file.remote in the tree
>>>(here .remote means the version in the patch)
>>
>>I remember that at times, but .remote is very confusing... I see that's the
>>mishandling is induced by various sources, maybe including "merge" itself,
>>but that program (and possibly others) supports changing the labels, and this
>>should probably be done (using "original", "patched" and "upstream"
>>probably).
> 
> 
> I know that diff3/merge support labels. I don't exactly remember my
> reasons but I think that I chose those namings because StGIT was
> supporting another type of merge where "patched" etc. did not apply.
> 
> I agree that we should change them. I would rather use "ancestor",
> "patch" and "base" but I don't have a strong opinion.

just a data point:

i use "original" "patch" and "older" (set up in .stgitrc) because i 
found the default labels to be confusing.

but "original" "patch" and "upstream" make sense to me.

--------------010806000101070406070401
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


--------------010806000101070406070401--

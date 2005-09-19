From: Chuck Lever <cel@citi.umich.edu>
Subject: omitted test scripts?
Date: Mon, 19 Sep 2005 11:50:23 -0400
Organization: Network Appliance, Inc.
Message-ID: <432EDE3F.7070407@citi.umich.edu>
References: <200509102027.28812.blaisorblade@yahoo.it>	 <1126427087.8457.33.camel@localhost.localdomain>	 <200509142019.04667.blaisorblade@yahoo.it> <tnxslw6d4qt.fsf@arm.com>	 <7vvf10hji1.fsf@assigned-by-dhcp.cox.net> <1126949517.6941.19.camel@localhost.localdomain>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080305050500050503070209"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 17:52:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHNuZ-0005y7-DH
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVISPuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 11:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVISPuZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 11:50:25 -0400
Received: from citi.umich.edu ([141.211.133.111]:9897 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932461AbVISPuY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 11:50:24 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 156F91BB7E;
	Mon, 19 Sep 2005 11:50:24 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1126949517.6941.19.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8877>

This is a multi-part message in MIME format.
--------------080305050500050503070209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On Fri, 2005-09-16 at 12:59 -0700, Junio C Hamano wrote:
> 
>>Catalin Marinas <catalin.marinas@gmail.com> writes:
>>
>>
>>>git-read-tree -m doesn't handle the case when a file is removed from
>>>one branch and unmodified in the other, which is what happens in your
>>>test. For each of these removed files, git-merge-cache will call
>>>gitmergeonefile.py which calls 'git-update-cache --remove'.
>>>
>>>An improvement would be to make git-read-tree smarter...
>>
>>I think this was once discussed but the primary reason for the
>>behaviour is that Linus wanted to leave as much merge policy
>>decision to be scriptable without hardcoding it in read-tree.
> 
> 
> This could be OK for git-read-tree but maybe git-merge-index could have
> a --smart option to deal with trivial cases like below (or a separate
> tool). Whoever wants to write a more interactive script would not pass
> this option.

i noticed while testing the new cache API that there are no tests under 
t/ for git-merge-index.

there is also no test script that covers the prune_cache() function in 
ls-files.c.

--------------080305050500050503070209
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


--------------080305050500050503070209--

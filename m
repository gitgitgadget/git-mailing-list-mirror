From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Wed, 14 Sep 2005 10:49:44 -0400
Organization: Network Appliance, Inc.
Message-ID: <43283888.10909@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>	<4325A0D9.2000806@gmail.com> <4325AED6.8050401@citi.umich.edu>	<43272350.3060801@progeny.com> <tnxu0gocats.fsf@arm.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060108060605080909010701"
Cc: Tim Ottinger <tottinge@progeny.com>, gitzilla@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 16:52:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFYa7-0006xK-I9
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 16:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVINOtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 10:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVINOtq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 10:49:46 -0400
Received: from citi.umich.edu ([141.211.133.111]:54893 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964929AbVINOtp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 10:49:45 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 034A21BACA;
	Wed, 14 Sep 2005 10:49:45 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxu0gocats.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8526>

This is a multi-part message in MIME format.
--------------060108060605080909010701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> Tim Ottinger <tottinge@progeny.com> wrote:
> 
>>2) However unimportant, I'm an old OO guy and object_cmd looks like
>>object.command to me.
> 
> 
> Well, it depends on the language. If you only used LISP/CLOS, it would
> look more like (cmd object) :-)
> 

just a note on function naming:  i followed the pre-existing function 
naming convention.  to wit:

existing:

read_cache
write_cache
add_cache_entry
remove_cache_entry_at

new:

init_cc
next_cc
walk_cache

etc.

--------------060108060605080909010701
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


--------------060108060605080909010701--

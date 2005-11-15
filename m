From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] GIT commit statistics.
Date: Tue, 15 Nov 2005 10:29:37 -0500
Organization: Network Appliance, Inc.
Message-ID: <4379FEE1.9080407@citi.umich.edu>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>	 <20051107225807.GA10937@c165.ib.student.liu.se>	 <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>	 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>	 <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>	 <43758D21.3060107@michonline.com>	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>	 <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>	 <20051112125331.GB30496@pasky.or.cz> <b0943d9e0511150204h25417993l@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060908060407090801090804"
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 16:37:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec2lT-0007zN-CX
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 16:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVKOP3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVKOP3u
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 10:29:50 -0500
Received: from citi.umich.edu ([141.211.133.111]:35749 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932537AbVKOP3u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 10:29:50 -0500
Received: from [10.58.53.7] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 7A4B01BACA;
	Tue, 15 Nov 2005 10:29:36 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <b0943d9e0511150204h25417993l@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11907>

This is a multi-part message in MIME format.
--------------060908060407090801090804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 12/11/05, Petr Baudis <pasky@suse.cz> wrote:
> 
>>On the same note, I would like StGIT to drop functionality not really
>>belonging to patch stack manager (stg add, stg rm, stg status, ...) so
>>that its commandset gets smaller and more focused
> 
> 
> This was the case with the first StGIT implementations but I slowly
> began to want to only use StGIT and not switch to something else for
> trivial SCM operations. I eventually added 'stg commit' which stores
> the patches permanently into the base of the stack to enable some kind
> of maintainer mode for StGIT. My main use for this was to import
> patches directly into the main branch and not keep a separate one and
> pull between them.

  ...

> Anyway, while I'll try not to add more SCM functionality to StGIT, I
> don't think I should remove the existing add/rm/status functionality.
> It's just handy not to use a different command when you want a new
> file added to a patch.

petr,

currently it isn't recommended to use StGIT with other porcelains.

so either: make it completely safe to use StGIT with other porcelains, 
or add a minimal amount of SCM-like functionality so users don't miss it 
and try to use other porcelains and trash their repositories.

overall i agree with catalin-- it's just easier to use a single tool.

--------------060908060407090801090804
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


--------------060908060407090801090804--

From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: Diffs "from" working directory
Date: Tue, 22 Nov 2005 13:03:58 -0500
Organization: Network Appliance, Inc.
Message-ID: <43835D8E.60109@citi.umich.edu>
References: <200511201817.15780.blaisorblade@yahoo.it>  <20051120174359.GA24177@fieldses.org>  <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>  <20051120205855.GA30346@fieldses.org>  <4381287F.5080402@citi.umich.edu> <b0943d9e0511211328j7c062c07s@mail.gmail.com> <4382A972.1010801@citi.umich.edu> <Pine.LNX.4.64.0511212124160.13959@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050409070302080603040700"
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 19:04:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EecV2-000137-I4
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 19:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVKVSEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 13:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVKVSEG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 13:04:06 -0500
Received: from citi.umich.edu ([141.211.133.111]:10336 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965060AbVKVSEA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 13:04:00 -0500
Received: from [10.58.52.99] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id D05691C113;
	Tue, 22 Nov 2005 13:03:58 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511212124160.13959@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12562>

This is a multi-part message in MIME format.
--------------050409070302080603040700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 22 Nov 2005, Chuck Lever wrote:
> 
>>for some reason i was under the impression that it would parse the
>>Signed-off-by: fields in the patch description, and take the first one as the
>>patch author.
> 
> 
> The first sign-off really isn't necessarily the author.
> 
> It might be a company sign-off (many companies don't want any random 
> engineer to send out patches), but much more commonly it's a trivial patch 
> that somebody else signs off on, even if the original patcher didn't (see 
> case (b) in the sign-off-rules: you can sign of on somebody elses work if 
> you know it's under the GPL).

heh.  in fact that is what my company (NetApp) requires.

> So the fact that there was a sign-off procedure doesn't automatically mean 
> that the author will be the first sign-off person, although in _practice_ 
> that obviously would likely always be the most common case by far.
> 
> (Another reason is that some people actually add the sign-offs above 
> previous ones. It happens, although if I notice, I try to point it out).
> 
> So authorship really is totally separate from sign-off, and all _my_ tools 
> take the authorship from the first "From:" line at the top of the message 
> body or from the email itself.

then perhaps the problem is that the "stg mail" tool should place the 
author in the From: field automatically?  (ie change the tool, or 
permanently modify the default template that comes with StGIT to do 
this, as Catalin suggested earlier).

that seems a little twisty to me; you're overloading the SMTP header 
field instead of explicitly specifying patch authorship.  seems like a 
layering violation.

--------------050409070302080603040700
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


--------------050409070302080603040700--

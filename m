From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH/RFC] Build a shared / renamed / "stable" version of the
 library?
Date: Fri, 16 Sep 2005 15:48:02 -0400
Organization: Network Appliance, Inc.
Message-ID: <432B2172.8090803@citi.umich.edu>
References: <pan.2005.09.16.12.37.14.736570@smurf.noris.de> <7vmzmcj1eo.fsf@assigned-by-dhcp.cox.net>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060206090208040804030302"
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	David Roundy <droundy@abridgegame.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:49:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMBr-00005t-SZ
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965313AbVIPTsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965314AbVIPTsE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:48:04 -0400
Received: from citi.umich.edu ([141.211.133.111]:47625 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965313AbVIPTsD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 15:48:03 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id BEDC61BAD0;
	Fri, 16 Sep 2005 15:48:25 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzmcj1eo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8721>

This is a multi-part message in MIME format.
--------------060206090208040804030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
>  - Management of even the most basic data structures used in
>    libgit.a shares the "run once" mentality.  I can offhand
>    think of three but I am sure there are more:
> 
>    - active_cache: once you are done with the current cache, it
>      is very hard to reinitialize and use it without losing
>      memory [*2*];

> *2* Hopefully this will be fixed when Chuck is done but the work
> and the discussion has just been started and I do not know how the
> timeframe of this cache abstraction cleanup meshes with 1.0
> timeframe.

well, i kept the "run-once" mentality.  if that's something you'd like 
to go away, i can do that too, at some later point.

--------------060206090208040804030302
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


--------------060206090208040804030302--

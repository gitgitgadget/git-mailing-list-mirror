From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] specfile cleanups
Date: Fri, 11 Nov 2005 12:31:16 +0100
Message-ID: <43748104.5020707@op5.se>
References: <20051111091029.GW8041@shell0.pdx.osdl.net> <7vveyzpmi7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020906030407040303080602"
X-From: git-owner@vger.kernel.org Fri Nov 11 12:33:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaX7q-0008AM-So
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVKKLbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 06:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKKLbS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 06:31:18 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54444 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750725AbVKKLbS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 06:31:18 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id DABF16BD0D
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 12:31:16 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vveyzpmi7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11587>

This is a multi-part message in MIME format.
--------------020906030407040303080602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> 
>>Some specfile cleanups after the split.
> 
> 
> Thanks.
> 
> Does it matter some Requires use comma and others don't?
> 

Other than for consistency reasons, no. Most distributions have it in 
their conventions to use commas. Some don't.

Most also have the conventions enforced by the attached script as it 
enhances readability by removing much un-necessary clutter.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------020906030407040303080602
Content-Type: application/x-shellscript;
 name="specwash.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="specwash.sh"

IyEvYmluL2Jhc2gKIwojIHNwZWN3YXNoLnNoIC0gd2FzaCB1bm5lZWRlZCBjdXJsaWVzIGZy
b20gc2NyaXB0cyBhbmQgc3BlYy1maWxlcwojICAgICAgICAgICAgICAgdXNlIG1hY3JvcyBp
biBmYXZvciBvZiBhbnl0aGluZyBlbHNlCiMKCmlmIFsgJCMgLWx0IDEgXTsgdGhlbgoJZWNo
byAiVXNhZ2U6ICR7MCMjKi99IHNjcmlwdHMvc3BlYy1maWxlcyIKCWV4aXQgMQpmaQoKIyB2
YXJjaGFycyBpbiByZWdleCBmb3JtCiMgdXNpbmcgdGhpcyB3aGl0ZWxpc3QgYWxsb3dzIHRo
aW5ncyBsaWtlICR7MCMjKi99IHRvIHBhc3MgdW5tb2xlc3RlZAojIGl0IG1pZ2h0IGJyZWFr
IHNvbWUgb3RoZXIgdGhpbmdzIHRob3VnaCwgc28gd2Uga2VlcCB0aGUgYmFja3Vwcy4KdmM9
ImEtekEtWjAtOV8iCiMJCS1lICJzL15cKFteI10uKlteX11cKW1rZGlyL1wxJV9fbWtkaXIv
IiBcCgpmb3IgaSBpbiAiJEAiOyBkbwoJbXYgLWkgJGkgJGkuYmFrIHx8IGNvbnRpbnVlCglz
ZWQgLWUgInMvICokLy9nIiBcCgkJLWUgInMvXChbXCVcJF1cKXtcKFskdmNdKlwpXH1cKFte
JHZjXVwpL1wxXDJcMy9nIiBcCgkJLWUgInMvXChbXCVcJF1cKXtcKFskdmNdKlwpXH0kL1wx
XDIvZyIgXAoJCS1lICdzLC91c3IvYmluLywlX2JpbmRpci8sZycgLWUgJ3MsL3Vzci9zYmlu
LywlX3NiaW5kaXIvLGcnIFwKCQktZSAncywvdXNyL2xpYmV4ZWMvLCVfbGliZXhlY2Rpci8s
ZycgLWUgJ3MsL3Vzci9saWIvLCVfbGliZGlyLyxnJyBcCgkJLWUgJ3MsL3Vzci9pbmNsdWRl
LywlX2luY2x1ZGVkaXIvLGcnIFwKCQktZSAncywvdXNyL2luZm8vLCVfaW5mb2Rpci8sZycg
LWUgJ3MsL3Vzci9tYW4vLCVfbWFuZGlyLyxnJyBcCgkJLWUgJ3MsL3Vzci9zaGFyZS9pbmZv
LywlX2luZm9kaXIvLGcnIC1lICdzLC91c3Ivc2hhcmUvbWFuLywlX21hbmRpci8sZycgXAoJ
CS1lICdzLC91c3IvLCVfcHJlZml4LyxnJyBcCgkJLWUgJ3MsXCRSUE1fQlVJTERfUk9PVCwl
YnVpbGRyb290LGcnIFwKCQktZSAncyxcJFJQTV9PUFRfRkxBR1MsJW9wdGZsYWdzLGcnIFwK
CSRpLmJhayA+ICRpCmRvbmUK
--------------020906030407040303080602--

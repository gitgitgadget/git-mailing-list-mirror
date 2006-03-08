From: Rajkumar S <rajkumars@asianetindia.com>
Subject: Some more cvsimport
Date: Wed, 08 Mar 2006 14:19:44 +0530
Message-ID: <440E9AA8.2020605@asianetindia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050602060407010303010108"
X-From: git-owner@vger.kernel.org Wed Mar 08 09:50:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGuMu-0004ap-Cq
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 09:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWCHItt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 03:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWCHIts
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 03:49:48 -0500
Received: from vhs2.linuxense.com ([64.34.173.90]:34794 "EHLO
	vhs1.asianetindia.com") by vger.kernel.org with ESMTP
	id S932516AbWCHIts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 03:49:48 -0500
Received: (qmail 27820 invoked by uid 1014); 8 Mar 2006 08:49:48 -0000
Received: from rajkumars@asianetindia.com by vhs2.linuxense.com by uid 1003 with qmail-scanner-1.22 
 (clamdscan: 0.74. spamassassin: 2.63.  Clear:RC:0(61.17.42.102):SA:0(0.0/6.5):. 
 Processed in 0.716119 secs); 08 Mar 2006 08:49:48 -0000
X-Spam-Status: No, hits=0.0 required=6.5
Received: from static-61.17.42.102.ip-dsl-tvm.eth.net (HELO [192.168.3.49]) (raj@linuxense.com@[61.17.42.102])
          (envelope-sender <rajkumars@asianetindia.com>)
          by vhs1.asianetindia.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 8 Mar 2006 08:49:47 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17365>

This is a multi-part message in MIME format.
--------------050602060407010303010108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Thanks every one for replying to my previous mails and to Smurf for his helpful replies 
and patch.

The cvs project I am trying to track has 2 branchs. One head and another for releng_1. The 
upstream cvs tree gets updated on both branchs. I also make modifications to both. When I 
normally do cvsimport, the releng_1 tree gets updated automatically, but if I have checked 
out the releng_1 branch in my local git repository when cvsimport happens the files do not 
get updated.  I can fix this by checking out the master branch just before cvsimport and 
then switching back.

I am attaching a test script to simulate the problem and the fix is commented out.

raj

--------------050602060407010303010108
Content-Type: application/x-shellscript;
 name="git_branch_init.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git_branch_init.sh"

ZXhwb3J0IENWU1JPT1Q9L2hvbWUvcmFqL2N2c3Jvb3QKcm0gLXJmIGN2c3Jvb3QvIGdpdC8g
c3JjLyAvaG9tZS9yYWovLmN2c3BzCm1rZGlyIGN2c3Jvb3QgIGdpdCBzcmMKY3ZzIGluaXQg
CmNkIHNyYy8KZWNobyAiSW5pdGlhbCBJbXBvcnQiID4gZmlsZS50eHQKZWNobyAiTGluZSBv
bmUiID4gZmlsZTEudHh0CmVjaG8gIkxpbmUgb25lIiA+IGZpbGUyLnR4dApjdnMgaW1wb3J0
IC1tICJJbXBvcnRlZCBzb3VyY2VzIiBzcmMgc3RhcnQgcmVhbHN0YXJ0CmVjaG8gIkluaXRp
YWwgSW1wb3J0IgoKY2QgLi4Kcm0gLXJmIHNyYy8KY3ZzIGNvIHNyYyAKY2Qgc3JjCmVjaG8g
IkZpcnN0IGNvbW1pdCwgYmVmb3JlIGJyYW5jaGluZyIgPj4gZmlsZS50eHQKY3ZzIGNvbW1p
dCAtbSAiRmlyc3QgY29tbWl0LCBiZWZvcmUgYnJhbmNoaW5nIgplY2hvICJGaXJzdCBjb21t
aXQgb3Zlciwgbm93IGJyYW5jaCIKCmN2cyB0YWcgLWIgcmVsZW5nXzEKc2xlZXAgMQplY2hv
ICJCcmFuY2hlZCIKCmNkIC4uCnJtIC1yZiBzcmMKY3ZzIGNvIC1yIHJlbGVuZ18xIHNyYwpj
ZCBzcmMKZWNobyAiQ2hlY2tlZCBvdXQgdGFnZ2VkIHZlcnNpb24iCmVjaG8gIkNvbW1pdGVk
IGZpcnN0IHVwZGF0ZSB0byByZWxlbmdfMSIgPj4gZmlsZS50eHQKdG91Y2ggcmVsZW5nXzEK
Y3ZzIGFkZCByZWxlbmdfMQplY2hvICJMaW5lIHR3byIgPj4gZmlsZTEudHh0CmN2cyBjb21t
aXQgLW0gIkNvbW1pdGVkIGZpcnN0IHVwZGF0ZSB0byByZWxlbmdfMSIKc2xlZXAgMQplY2hv
ICJDb21taXRlZCBmaXJzdCB1cGRhdGUgdG8gcmVsZW5nXzEiCgpjZCAuLgpybSAtcmYgc3Jj
CmN2cyBjbyBzcmMKY2Qgc3JjCmVjaG8gIlNlY29uZCBjb21taXQgdG8gSEVBRCwgYmVmb3Jl
IGN2c2ltcG9ydCIgPj4gZmlsZS50eHQKdG91Y2ggdmVyMS4xCmVjaG8gIkxpbmUgdHdvIiA+
PiBmaWxlMS50eHQKY3ZzIGNvbW1pdCAtbSAiU2Vjb25kIGNvbW1pdCB0byBIRUFEIgoKI0Zp
cnN0IGdpdCBpbXBvcnQKY2QgLi4KZ2l0IGN2c2ltcG9ydCAtdiAtayAtdSAtbSAtZCAkQ1ZT
Uk9PVCAtQyBnaXQvICBzcmMKY2QgZ2l0IApnaXQgc3RhdHVzCgpjZCAuLgpybSAtcmYgc3Jj
CmN2cyBjbyBzcmMKY2Qgc3JjCmVjaG8gIlRoaXJkIGNvbW1pdCB0byBIRUFEIiA+PiBmaWxl
LnR4dAplY2hvICJ1cGRhdGVzIGluIGhlYWQiID4+IGZpbGUxLnR4dApjdnMgY29tbWl0IC1t
ICJUaGlyZCBjb21taXQgdG8gSEVBRCIKCmNkIC4uCnJtIC1yZiBzcmMKY3ZzIGNvIC1yIHJl
bGVuZ18xIHNyYwpjZCBzcmMKZWNobyAiU2Vjb25kIENvbW1pdCB0byByZWxlbmdfMSIgPj4g
ZmlsZS50eHQKZWNobyAiTGluZSB0aHJlZSBpbiByZWxlbmciID4+IGZpbGUxLnR4dApjdnMg
Y29tbWl0IC1tICJTZWNvbmQgQ29tbWl0IHRvIHJlbGVuZ18xIgoKI1NlY29uZCBnaXQgaW1w
b3J0CmNkIC4uCmdpdCBjdnNpbXBvcnQgLXYgLWsgLXUgLW0gLWQgJENWU1JPT1QgLUMgZ2l0
LyAgc3JjCmNkIGdpdApnaXQgc3RhdHVzCgoKY2QgLi4Kcm0gLXJmIHNyYwpjdnMgY28gc3Jj
CmNkIHNyYwplY2hvICJGb3VydGggQ29tbWl0IGluIGhlYWQiID4+IGZpbGUudHh0CmVjaG8g
ImV2ZW4gbW9yZSB1cGRhdGVzIGluIGhlYWQiID4+IGZpbGUxLnR4dApjdnMgY29tbWl0IC1t
ICJGb3VydGggQ29tbWl0IGluIGhlYWQiCgpjZCAuLgpybSAtcmYgc3JjCmN2cyBjbyAtciBy
ZWxlbmdfMSBzcmMKY2Qgc3JjCmVjaG8gIlRoaXJkIENvbW1pdCB0byByZWxlbmdfMSIgPj4g
ZmlsZS50eHQKZWNobyAiTGluZSBmb3VyIGluIHJlbGVuZyIgPj4gZmlsZTEudHh0CmN2cyBj
b21taXQgLW0gIlRoaXJkIENvbW1pdCB0byByZWxlbmdfMSIKCmNkIC4uCmdpdCBjdnNpbXBv
cnQgLXYgLWsgLXUgLW0gLWQgJENWU1JPT1QgLUMgZ2l0LyAgc3JjCiNybSAtcmYgZ2l0X3Jl
bGVhc2UKI2dpdCBjbG9uZSBnaXQgZ2l0X3JlbGVhc2UKY2QgZ2l0CmdpdCBjaGVja291dCBy
ZWxlbmdfMQpnaXQgc3RhdHVzCmNkIC4uCgpybSAtcmYgc3JjCmN2cyBjbyAtciByZWxlbmdf
MSBzcmMKY2Qgc3JjCmVjaG8gIkNvbW1pdCBhZnRlciBjbG9uZSB0byByZWxlbmdfMSIgPj4g
ZmlsZS50eHQKY3ZzIGNvbW1pdCAtbSAiQ29tbWl0IGFmdGVyIGNsb25lIHRvIHJlbGVuZ18x
IgoKY2QgLi4KIyBVbmNvbW1lbnQgIyMjIHRvIGZpeCB0aGUgYnVnKD8pLgojIyMgY2QgZ2l0
CiMjIyBnaXQgY2hlY2tvdXQgbWFzdGVyCiMjIyBjZCAuLgpnaXQgY3ZzaW1wb3J0IC12IC1r
IC11IC1tIC1kICRDVlNST09UIC1DIGdpdC8gIHNyYwpjZCBnaXQKIyMjIGdpdCBjaGVja291
dCByZWxlbmdfMQpnaXQgc3RhdHVzCmNkIC4uCgo=
--------------050602060407010303010108--

From: "Jason Garber" <jgarber@ionzoft.com>
Subject: git push [rejected] question
Date: Mon, 18 Feb 2008 16:15:01 -0600
Message-ID: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 01:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRG9U-0003EE-Jo
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 01:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYBSAP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 19:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYBSAP0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 19:15:26 -0500
Received: from server107mm.exghost.com ([69.20.100.20]:1618 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751116AbYBSAPZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 19:15:25 -0500
X-Greylist: delayed 3605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2008 19:15:24 EST
Received: by server107.appriver.com (CommuniGate Pro PIPE 5.2.0)
  with PIPE id 86096536; Mon, 18 Feb 2008 17:14:57 -0500
Received: from [72.32.49.6] (HELO FE2.exchange.rackspace.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.2.0)
  with ESMTP id 86096519 for git@vger.kernel.org; Mon, 18 Feb 2008 17:14:57 -0500
Received: from 34093-EVS2C1.exchange.rackspace.com ([192.168.1.18]) by FE2.exchange.rackspace.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Feb 2008 16:15:02 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git push [rejected] question
Thread-Index: Achye7RTSLD+Fu52QvmjqY+sIN47Jg==
X-OriginalArrivalTime: 18 Feb 2008 22:15:02.0709 (UTC) FILETIME=[B53A2650:01C8727B]
X-Policy: GLOBAL
X-Primary: jgarber@ionzoft.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: jgarber@ionzoft.com ALLOWED
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.49.6
X-Note-Reverse-DNS: fe2.exchange.rackspace.com
X-Note-WHTLIST: jgarber@ionzoft.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 75 76 122 
X-Note: Mail Class: ALLOWEDSENDER
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74359>

Hello,

One of our users had this come up today.  He (on a different branch) di=
d a push (successfully) earlier today.  Upon pushing some more changes =
this afternoon in the "Task/4919..." branch, the following message was =
received:

--
[caleb@neon VOS4]$ git push
Enter passphrase for key '/home/caleb/.ssh/id_rsa':
To ssh://git@code.izrm.com/~/WhiteBoot4/VOS4-NEW
 ! [rejected]        Issue/Default -> Issue/Default (non-fast forward)
 ! [rejected]        Issue/Task_4831_MUP_Survey_Layout -> Issue/Task_48=
31_MUP_Survey_Layout (non-fast forward)
 ! [rejected]        Task/4872-MUP-APlan-promotion -> Task/4872-MUP-APl=
an-promotion (non-fast forward)
 <snip>
error: failed to push to 'ssh://git@code.izrm.com/~/WhiteBoot4/VOS4-NEW=
'
--


However the branch in question was pushed successfully (despite the err=
or message).

* Task/4919-MUP-Agent-ID-promotion         7e80ca6
  origin/Task/4919-MUP-Agent-ID-promotion  7e80ca6

As far as I can tell, most (if not all) of the branches that were rejec=
ted were not changed today.


Any ideas or pointers for where I should look to resolve this?

** git version 1.5.4.1 **

--
Best Regards,
=A0
Jason Garber
Senior Systems Engineer
IonZoft, Inc.
=A0
(814) 941-2390
jgarber@ionzoft.com
=A0
=A0

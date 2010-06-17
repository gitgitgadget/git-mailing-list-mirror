From: Gavin Kistner <gkistner@nvidia.com>
Subject: Re: unpacker error on push
Date: Wed, 16 Jun 2010 21:41:12 -0700
Message-ID: <E12F86FA-233F-458B-8C53-4CBF50FA289B@nvidia.com>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
 <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 06:44:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP6xT-00050W-6z
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 06:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab0FQElQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 00:41:16 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:16437 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0FQElP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 00:41:15 -0400
Received: from hqnvupgp03.nvidia.com (Not Verified[172.17.102.18]) by hqemgate03.nvidia.com
	id <B4c19a8010000>; Wed, 16 Jun 2010 21:43:45 -0700
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp03.nvidia.com (PGP Universal service);
  Wed, 16 Jun 2010 21:41:13 -0700
X-PGP-Universal: processed;
	by hqnvupgp03.nvidia.com on Wed, 16 Jun 2010 21:41:13 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.12]) by hqemhub02.nvidia.com
 ([172.17.98.27]) with mapi; Wed, 16 Jun 2010 21:41:13 -0700
Thread-Topic: unpacker error on push
Thread-Index: AcsN11CflzL/aISJR92cRon89Miy2g==
In-Reply-To: <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149288>

On Jun 16, 2010, at 1:34 PM, Nicolas Pitre wrote:
> On Wed, 16 Jun 2010, Gavin Kistner wrote:
>> Slim2:bugbot3 phrogz$ git push
>> Counting objects: 70, done.
>> Delta compression using up to 2 threads.
>> Compressing objects: 100% (31/31), done.
>> Writing objects: 100% (40/40), 26.91 KiB, done.
>> Total 40 (delta 11), reused 37 (delta 8)
>> error: unpack failed: unpack-objects abnormal exit
>> To git://10.20.16.110/bugbot3.git
>> ! [remote rejected] planning -> planning (n/a (unpacker error))
>> error: failed to push some refs to 'git://10.20.16.110/bugbot3.git'
> 
> Could you try doing "git config receive.unpackLimit 1" on the _remote_ 
> machine in the receiving repository?
> 
> Note this is not a proper fix but rather an attempt to isolate the 
> issue.  Please make a backup of the entire repository both on the local 
> and the remote machine if you can, so the failure can be reproduced 
> again after restoring them to the current state in case this would "fix" 
> the issue.

Sorry, I'd love to help but I zipped up the repo (sans .git or a few other directories), nuked it, and re-cloned. That fixed the issue.

I'll definitely save copies of the repositories next time something funky happens.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

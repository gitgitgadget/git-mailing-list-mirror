From: Thomas Kistler <tkistler@nvidia.com>
Subject: git-p4 and git clone
Date: Mon, 22 Mar 2010 16:16:19 -0700
Message-ID: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 00:16:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtqrD-00039c-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 00:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab0CVXQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 19:16:21 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.145]:5639 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab0CVXQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 19:16:20 -0400
Received: from hqnvupgp03.nvidia.com (Not Verified[172.17.102.18]) by hqemgate03.nvidia.com
	id <B4ba7fa740001>; Mon, 22 Mar 2010 16:17:08 -0700
Received: from hqemhub03.nvidia.com ([172.17.108.22])
  by hqnvupgp03.nvidia.com (PGP Universal service);
  Mon, 22 Mar 2010 16:16:20 -0700
X-PGP-Universal: processed;
	by hqnvupgp03.nvidia.com on Mon, 22 Mar 2010 16:16:20 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.13]) by hqemhub03.nvidia.com
 ([172.20.150.15]) with mapi; Mon, 22 Mar 2010 16:16:20 -0700
Thread-Topic: git-p4 and git clone
Thread-Index: AcrKFKECu789VL0DRauoK/YXYkhLcw==
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142975>

I'm probably missing something fairly fundamental but I'm running into problems with cloning a git-p4 repository:

First, I'm setting up a git-p4 master repository:

    $ cd tmp1
    $ git-p4 clone //foo/bar

Then I'm cloning it through git:

    $ cd tmp2
    $ git clone tmp1/bar

Finally, I'm trying to submit back to p4:

    $ git-p4 submit

This now fails because the remotes/p4/master seems to get lost when doing the "git clone". Is this supposed to work?

-Thomas
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

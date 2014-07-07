From: "Finucane, Stephen" <stephen.finucane@intel.com>
Subject: Adding 'Signed-off-by' to 'subtree add --squash' commits
Date: Mon, 7 Jul 2014 09:32:47 +0000
Message-ID: <6A74A01C3512C646A9ED99AFA28AEB981358A7E8@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Gray, Mark D" <mark.d.gray@intel.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 11:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X45JM-0007s7-RB
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 11:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbaGGJeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 05:34:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:63248 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbaGGJeH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2014 05:34:07 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 07 Jul 2014 02:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,617,1400050800"; 
   d="scan'208";a="569294124"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2014 02:33:37 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.76]) by
 IRSMSX104.ger.corp.intel.com ([169.254.5.106]) with mapi id 14.03.0123.003;
 Mon, 7 Jul 2014 10:32:48 +0100
Thread-Topic: Adding 'Signed-off-by' to 'subtree add --squash' commits
Thread-Index: Ac+ZxXeWSLrYMy52SF6jR5oNefLJCA==
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252962>

Is it possible to "sign off" squashed commits created by the 'git subtree add ... --squash' command?

I ask, because the Signed-off-by tag is a requirement for a project I work on, but I've been unable to achieve this. A thorough search of Google/StackOverflow reveals nothing.

Regards,

Stephen Finucane

PS: A visualisation. The issue is the second "squash" commit

  |\  Merge: 0000000 0000000
  | | Author: Stephen Finucane <stephen.finucane@intel.com>
  | | Date:   Mon Jul 7 10:21:51 2014 +0100
  | |
  | |     Add xxx as a git subtree
  | |
  | |     - There is no problem with this commit.
  | |
  | |     Signed-off-by: Stephen Finucane <stephen.finucane@intel.com>
  | |
  | * commit 0000000000000000000000000000000000000000
  |   Author: Stephen Finucane <stephen.finucane@intel.com>
  |   Date:   Mon Jul 7 10:21:51 2014 +0100
  |
  |       Squashed 'path/' content from commit 0000000
  |
  |       git-subtree-dir: path
  |       git-subtree-split: 0000000000000000000000000000000000000000
  |
  * commit 0000000000000000000000000000000000000000
  | Author: Stephen Finucane <stephen.finucane@intel.com>
  | Date:   Mon Jul 7 10:04:38 2014 +0100
  ...
--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.

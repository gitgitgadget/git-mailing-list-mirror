From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: rebase destroys branches
Date: Mon, 4 Mar 2013 23:43:32 -0000
Organization: OPDS
Message-ID: <64FF012BC4AF45C4A5067DE93FD9FE17@PhilipOakley>
References: <C057AC9B02D06A49810E9597C11F55BF14DFE51C9F@dnzwgex2.datacom.co.nz>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 00:43:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCf2k-0003xG-5r
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 00:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584Ab3CDXnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 18:43:16 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:49151 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753742Ab3CDXnP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Mar 2013 18:43:15 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao4OABMeNVFZ8rke/2dsb2JhbABEjAy2QwEDgQsXc2gBAYEbAQERAgUBAQQBCAEBLh4BASYGAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGFOAcBgjwKwRONSjsegVOBfGEDiDaFZJkYgnsN
X-IronPort-AV: E=Sophos;i="4.84,783,1355097600"; 
   d="scan'208";a="420504953"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with SMTP; 04 Mar 2013 23:43:13 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217419>

From: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
Sent: Monday, March 04, 2013 11:06 PM
>Hello,
>I am evaluating git for use in a company. Please correct if I am wrong.
>I am concerned that an inexperienced developer could mistakenly rebase
>branches, destroying the original branch.

The original branch is not 'destroyed', rather the pointer to the 
previous tip is within the logs. All the content is still available 
until the logs expire.

>   Attached is a script (Windoze)
>that shows the 'topic' branch being moved!, after the rebase we are
>unable to see the original branch, read it's history or find it's 
>commit
>points.

>Surely no operation should remove anything from the repository.
>Operations like this irreversibly break the repository . When rebasing
>the original branch must be retained.

It's easy to misread some of Git's strengths if you have come from other 
historic corporate 'version control systems' which are often based on 
drawing office practice of old (e.g. the belief there is a single master 
to be protected is one misconception for software).

Rebase, at the personal level, is an important mechanism for staff to 
prepare better code and commit messages. Trying to hide the reality will 
just make your management 'control' less effective as staff work around 
it and delay check-ins, etc.

The broader access control and repo management issues are deliberately 
not part of Git, and there are good tools for that. e.g. Gitolite.

>Yours faithfully,


>Gene Thomas.

Philip

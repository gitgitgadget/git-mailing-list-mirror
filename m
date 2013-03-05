From: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
Subject: RE: rebase destroys branches
Date: Tue, 5 Mar 2013 14:05:32 +1300
Message-ID: <C057AC9B02D06A49810E9597C11F55BF14DFE5214F@dnzwgex2.datacom.co.nz>
References: <C057AC9B02D06A49810E9597C11F55BF14DFE51C9F@dnzwgex2.datacom.co.nz>
 <64FF012BC4AF45C4A5067DE93FD9FE17@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 02:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCgKT-0001DP-9S
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 02:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab3CEBFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 20:05:39 -0500
Received: from mx6.datacom.co.nz ([202.175.142.6]:12895 "EHLO
	mx6.datacom.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758791Ab3CEBFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Mar 2013 20:05:39 -0500
Received: from dnzwgex2.datacom.co.nz (Not Verified[172.30.0.121]) by mx6.datacom.co.nz with MailMarshal (v6,4,1,5038) (using TLS: SSLv23)
	id <B513544de0000>; Tue, 05 Mar 2013 14:05:34 +1300
Received: from DNZWGEX2.datacom.co.nz ([172.30.0.121]) by
 dnzwgex2.datacom.co.nz ([172.30.0.121]) with mapi; Tue, 5 Mar 2013 14:05:33
 +1300
Thread-Topic: rebase destroys branches
Thread-Index: Ac4ZMgwBW+lkfGjiRv62GwZzigm0KgABJDSg
In-Reply-To: <64FF012BC4AF45C4A5067DE93FD9FE17@PhilipOakley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217423>

Philip,
        Thanks for your reply.

>The original branch is not 'destroyed', rather the pointer to the previous tip is within the logs. 

Is that the 'git log' log or internal logs? Are you sure? There doesn't appear to be a way to checkout that tip of see the log back from that tip.

>All the content is still available until the logs expire.

So we will be unable to checkout content after a time?

Gene Thomas.

-----Original Message-----
From: Philip Oakley [mailto:philipoakley@iee.org] 
Sent: Tuesday, 5 March 2013 12:44
To: Gene Thomas [DATACOM]; Git List
Subject: Re: rebase destroys branches

From: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
Sent: Monday, March 04, 2013 11:06 PM
>Hello,
>I am evaluating git for use in a company. Please correct if I am wrong.
>I am concerned that an inexperienced developer could mistakenly rebase 
>branches, destroying the original branch.

The original branch is not 'destroyed', rather the pointer to the previous tip is within the logs. All the content is still available until the logs expire.

>   Attached is a script (Windoze)
>that shows the 'topic' branch being moved!, after the rebase we are 
>unable to see the original branch, read it's history or find it's 
>commit points.

>Surely no operation should remove anything from the repository.
>Operations like this irreversibly break the repository . When rebasing 
>the original branch must be retained.

It's easy to misread some of Git's strengths if you have come from other historic corporate 'version control systems' which are often based on drawing office practice of old (e.g. the belief there is a single master to be protected is one misconception for software).

Rebase, at the personal level, is an important mechanism for staff to prepare better code and commit messages. Trying to hide the reality will just make your management 'control' less effective as staff work around it and delay check-ins, etc.

The broader access control and repo management issues are deliberately not part of Git, and there are good tools for that. e.g. Gitolite.

>Yours faithfully,


>Gene Thomas.

Philip

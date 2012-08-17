From: Manfred Rudigier <manfred.rudigier@omicron.at>
Subject: GIT archive invocation with SHA sum
Date: Fri, 17 Aug 2012 08:25:53 +0200
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E301473171E4@alice.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 08:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2G7m-0003BI-6m
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 08:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab2HQGdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 02:33:31 -0400
Received: from ns.omicron.at ([212.183.10.25]:51466 "EHLO ns.omicron.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2HQGda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2012 02:33:30 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2012 02:33:30 EDT
Received: from counter.omicron.at ([212.183.10.29])
	by ns.omicron.at (8.13.1/8.13.1) with ESMTP id q7H6PspF014753
	for <git@vger.kernel.org>; Fri, 17 Aug 2012 08:25:59 +0200
Received: from mary.at.omicron.at (mary.at.omicron.at [172.22.100.48])
	by counter.omicron.at (8.14.4/8.14.4) with ESMTP id q7H6PspI009945
	for <git@vger.kernel.org>; Fri, 17 Aug 2012 08:25:54 +0200
Received: from alice.at.omicron.at ([172.22.100.49]) by mary.at.omicron.at
 ([172.22.100.48]) with mapi; Fri, 17 Aug 2012 08:25:54 +0200
Thread-Topic: GIT archive invocation with SHA sum
Thread-Index: Ac18Pf9Opxha+H3jTa62js3epAbQKg==
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE, en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

we have recently upgraded our Ubuntu server to 12.04, which comes with a newer version of GIT. However, we have noticed that git archive -remote does not work anymore by specifying the SHA sum of a commit.

By seaching the mailing list I have found out that this was already discussed before (http://thread.gmane.org/gmane.comp.version-control.git/191815). In our company we use the git archive -remote command for a similar purpose in our build system and we must currently stick with an older version of GIT until there is a solution for this.

I have read that this restriction was made for some kind of security reason, and one possibility would be to add a config option on the server repo to turn off this safety check. As we manage the git repos ourselves, this would be perfectly ok for us.

What is the current status of this - is there already such a config option?

Regards,
Manfred Rudigier

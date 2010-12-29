From: Marlene Cote <Marlene_Cote@affirmednetworks.com>
Subject: RE: help for a git newbie please - git hooks
Date: Wed, 29 Dec 2010 19:26:17 +0000
Message-ID: <20053D7ED46E664F8B9A4D5E5B31937407197592@MBX021-W4-CA-1.exch021.domain.local>
References: <20053D7ED46E664F8B9A4D5E5B31937407197534@MBX021-W4-CA-1.exch021.domain.local>
 <m3k4iscsq2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 20:26:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY1fF-0004Pc-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 20:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab0L2T0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 14:26:20 -0500
Received: from hub021-ca-5.exch021.serverdata.net ([64.78.56.70]:40915 "EHLO
	hub021-ca-5.exch021.serverdata.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188Ab0L2T0U convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 14:26:20 -0500
Received: from MBX021-W4-CA-1.exch021.domain.local ([10.254.4.83]) by
 HUB021-CA-5.exch021.domain.local ([10.254.4.89]) with mapi; Wed, 29 Dec 2010
 11:26:18 -0800
Thread-Topic: help for a git newbie please - git hooks
Thread-Index: AQHLp45DBMnLyqbn6UOTbrzjB4gOjg==
In-Reply-To: <m3k4iscsq2.fsf@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164324>

Jakub,
 Thank-you for your reply and your advice about the subject.  I apologize for the vagueness of the previous one.

I see the templates directory now.  Thanks again.

--------------------------
Regards,
Marlene Cote
Affirmed Networks
978-268-0821 



->-----Original Message-----
->From: Jakub Narebski [mailto:jnareb@gmail.com]
->Sent: Wednesday, December 29, 2010 1:58 PM
->To: Marlene Cote
->Cc: git@vger.kernel.org
->Subject: Re: help for a git newbie please
->
->Marlene Cote <Marlene_Cote@affirmednetworks.com> writes:
->
->> I don't understand the docs when they talk about hooks.  I have
->> tried making my .git/hooks samples executable and they don't have
->> any suffix to remove, so they should just run.  However, every time
->> I make a new clone, the changes I made to the hooks are gone.  Just
->> the samples get put into the clone again.  How do I put a hook in
->> place that every developer will get and execute?  If I should be
->> using server side hooks, where exactly would those go?  Should I
->> modify the hooks under my repositories directory?
->
->First, for the future, could you please use more specific subject?
->"Help for a git newbie please" doesn't tell us _anything_ about what
->problem do you have with git on first glance.
->
->Second, hooks are not versioned and not under version control.  They
->are not transferred on clone either.  There are reasons for that,
->including the safety (running code under control of other side), and
->the fact that hooks are usually configured to local needs, so they
->might not make sense for other people.
->
->
->Now, if you either use some kind of networked filesystem, or you can
->configure it so each developers machine has the same install, you can
->make use of git templates mechanism.  This is the way git includes
->sample hooks in newly created repositories (git init, git clone, or
->even IIRC "git init" on existing repository).
->
->Those template files are by default (on Linux) installed in
->/usr/share/git-core/templates.  So what you can do is to put hooks you
->want each developer to have (either as executable hook, or as hook
->sample) in /usr/share/git-core/templates/hooks/ directory (or its
->equivalent in your installation).
->
->I hope that helps.
->
->--
->Jakub Narebski
->Poland
->ShadeHawk on #git

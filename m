From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Thu, 17 Oct 2013 20:48:46 +0100
Organization: OPDS
Message-ID: <360782C85A2E4C9091EAD1E85D69680C@PhilipOakley>
References: <20131015123505.GA3097@shrek.podlesie.net> <525d35e766ad4_55661275e7426@nysa.notmuch> <20131015133327.GA22723@shrek.podlesie.net> <525d4354a5436_5844e73e843d@nysa.notmuch> <20131015145139.GA3977@shrek.podlesie.net> <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com> <525e0e1b28c87_81a151de743f@nysa.notmuch> <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com> <525ee9d93c3af_3983c19e7caa@nysa.notmuch> <8629441933A94862982C5CDD6BF47690@PhilipOakley> <20131016230634.GO9464@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "John Szakmeister" <john@szakmeister.net>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"Krzysztof Mazur" <krzysiek@podlesie.net>, <git@vger.kernel.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtYn-00005U-UH
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758642Ab3JQTsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:48:38 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:48032 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759508Ab3JQTsh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 15:48:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArIGABE+YFJOl3+a/2dsb2JhbABagweJcbUYCoEoF3SCIAUBAQQBCAEBBCoeAQENFAUGAgMFAgEDDgcDCSUUAQQIEgYHFwYTCAIBAgMBh2MDCQq2fQ2Ja4xjgSWBSYMmgQcDiQSGEocFjjiFN4MlO4E0
X-IPAS-Result: ArIGABE+YFJOl3+a/2dsb2JhbABagweJcbUYCoEoF3SCIAUBAQQBCAEBBCoeAQENFAUGAgMFAgEDDgcDCSUUAQQIEgYHFwYTCAIBAgMBh2MDCQq2fQ2Ja4xjgSWBSYMmgQcDiQSGEocFjjiFN4MlO4E0
X-IronPort-AV: E=Sophos;i="4.93,516,1378854000"; 
   d="scan'208";a="591407978"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip06ir2.opaltelecom.net with SMTP; 17 Oct 2013 20:48:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236309>

From: "Jonathan Nieder" <jrnieder@gmail.com>
> Philip Oakley wrote:
>
>> Would this be a good time to suggest a specific wording should be
>> proposed (or a reminder of what was proposed repeated) for the
>> documentation of this option. It will be the documentation that
>> users will refer to when they need to know, rather than the list
>> discussions.
>
> It's not clear to me that this config item is a good idea.
>

My point was that the arguments had been rehearsed and explored, and 
that it was possibly a suitable time for Filippe to update any commit 
message and config item documentation so that the proposal can be 
judged.

> What is the intended use?  If someone wants to test that their scripts
> will continue to work with git 2.0, wouldn't testing a 2.0 release
> candidate (or the current state of the 'jch' branch until one exists)
> be the simplest way to do that?  If someone just likes the proposed
> behavior changes and wants to start using them right away, maybe we
> can help them by releasing 2.0 sooner ;-), or by advertising the
> fairly simple changes in commandline usage to get the new behaviors:
>

In terms of moving forward, there needs to be a balance between being 
stuck in the old world of the 60's, and being projected into the bright 
new world of the 20's (OK so I have exaggerated a bit there ;-). It's 
always been a case of different strokes for different folks - there will 
be folk who will try such an option (in an honest manner), who may not 
be aware of branches that are outside of the regular pu / next / master 
/ maint branches which the project publicises.

Rather than letting the email discussion degenerate by going round in 
circles to the usual end point, having a clarifying proposal (hopefully 
well balanced) would at least allow a cleaner understanding and 
decision.

> Instead of "git add", use "git add -A".
>
> When using "git add -u" or "git add -A" from a subdirectory
> of the toplevel, specify "git add -u ." explicitly unless you
> want it to apply to the whole tree (in which case use
> "git add -u :/").
>
> Instead of letting "git push" guess, name the branch you
> want to push: "git push origin master".  Or set
> '[push] default = simple' in your configuration.
>
> Pass --prefix to "git svn clone".
>
> The downside of configuration like the proposed core.next is that it
> is hard to explain ("What do you mean that I can't roll back to the
> pre-2.0 behavior in Git 2.0 by setting this configuration setting to
> an appropriate value?"), users or scripts can rely on it, and
> configuration variables tend to accumulate and never be removed.  If
> we really want a run-time switch for this, I suspect an appropriately
> named environment variable would work better, since we have a history
> of being able to remove those without alarming people.
>
> My two cents,
> Jonathan
> 

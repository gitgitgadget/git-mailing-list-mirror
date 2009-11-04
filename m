From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH v2] format-patch: autonumber by default
Date: Wed, 4 Nov 2009 12:48:34 -0500
Message-ID: <EC82292D-1A52-4EFB-8E56-33E18A343AE0@silverinsanity.com>
References: <20081002205539.GA36768@Hermes> <m1ws261qqi.fsf@fess.ebiederm.org>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5k7r-0002rW-Ru
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 18:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbZKDR6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 12:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757392AbZKDR6U
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 12:58:20 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57009 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314AbZKDR6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 12:58:19 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2009 12:58:19 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C1A281FFC087; Wed,  4 Nov 2009 17:48:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 96F9D1FFC06B;
	Wed,  4 Nov 2009 17:48:31 +0000 (UTC)
In-Reply-To: <m1ws261qqi.fsf@fess.ebiederm.org>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132101>


On Nov 4, 2009, at 6:20 AM, Eric W. Biederman wrote:

> Grumble.  I updated git last night and this change just bit me.
> Grumble.
> Grumble.
>
> It is probably a good change, but it was unexpected.
> Grumble. Grumble. Grumble.

The change is a year old, and mentioned in the release notes from  
1.6.1.  If you're updating from old versions of git, it can be  
extremely useful to read the release notes as we do periodically have  
changes like this.  (In the git repository, they can be found as  
Documentation/RelNotes-*.txt)

If you wish to go back to the old default for a single project, use  
`git config format.numbered false`.  If you use the --global flag, it  
will set it for you all the time.  For a single set of unrelated  
patches being output at once, use the --no-numbered (short: -N) option  
to format-patch.

Sorry it caught you unawares.  Having it auto-number seemed like the  
most useful default.

~~ Brian

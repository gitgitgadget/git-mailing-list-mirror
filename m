From: Sam Vilain <sam@vilain.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 09:44:41 -0700
Message-ID: <1225385081.19891.1.camel@maia.lan>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	 <1225343538.10803.9.camel@maia.lan>
	 <18697.41702.241183.408377@lisa.zopyra.com>
	 <18697.42140.459170.891195@lisa.zopyra.com>  <4909A7C4.30507@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:46:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvaf0-0000i8-7b
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbYJ3Qoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbYJ3Qoz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:44:55 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36052 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbYJ3Qoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:44:54 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 30B9921D157; Fri, 31 Oct 2008 05:44:53 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8278021CF8D;
	Fri, 31 Oct 2008 05:44:47 +1300 (NZDT)
In-Reply-To: <4909A7C4.30507@op5.se>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99498>

On Thu, 2008-10-30 at 13:25 +0100, Andreas Ericsson wrote:
> >> Ok, now I'm confused.  The ONLY thing I want to prevent is the
> >> "crossing of streams" issue.  If I am on branch X and issue 'git
> >> push', I want X, and ONLY X, to be pushed to the remote repository's X
> >> branch --- I don't care if other branches are pushed to their
> >> respective remote branches, as long as they don't get merged to X.
> This particular bikeshed was painted a long time ago, with the consensus
> going in favour of "git push" pushing all *matching* refspecs.

I realise that - I just found it interesting that there was a user who
explicitly expected this not to be the case.

Which I think is reasonable, because it's what 'git pull' does.  I
myself have encountered many people who did not like the current default
behaviour.  I think far from "bikeshedding" this is quite an important
part of the ui experience.

Sam.

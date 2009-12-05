From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: [PATCH 2/5] git-svn: Make merge metadata
 accessible to make_log_entry
Date: Sun, 06 Dec 2009 11:59:32 +1300
Message-ID: <1260053972.22680.5.camel@denix>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net>
	 <1259780874-14706-3-git-send-email-alex@chmrr.net>
	 <1259786690-sup-8337@utwig> <20091205223241.GB2120@dcvr.yhbt.net>
	 <1260052934-sup-9563@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 23:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3bV-0000xu-32
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 23:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbZLEW7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 17:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757029AbZLEW7c
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 17:59:32 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:35084 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698AbZLEW7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 17:59:32 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id F281221C46F; Sun,  6 Dec 2009 11:59:37 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 4EFB321C389;
	Sun,  6 Dec 2009 11:59:33 +1300 (NZDT)
In-Reply-To: <1260052934-sup-9563@utwig>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134633>

On Sat, 2009-12-05 at 17:51 -0500, Alex Vandiver wrote:
> At Sat Dec 05 17:32:41 -0500 2009, Eric Wong wrote:
> > I'll continue to defer to Sam for ack-ing SVK-related things.
> > 
> > One thing I am very picky about is wrapping lines at 80-columns or
> > less (hard tabs being 8 characters wide).
> 
> *nod* I've fixed up my local copy for v2 to rewrap things at < 80
> columns, and will keep that in mind for the future.

Hi, I've just seen the series, looks like a good idea.  Just a couple of
questions then I'll review the code;

 - when a change is merged upstream with svk, you will get multiple log
entries in a single commit message.  What do you do with commits like
that?

 - there are quite a few repos which will have empty commits (ie, no
changes), but with one or more of the above log entries, owing to a bug
which I can't seem to find the details of right now..  how might those
appear?

Thanks for your submission!
Sam

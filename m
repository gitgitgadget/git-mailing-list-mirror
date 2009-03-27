From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 14:48:13 +0100
Organization: Universitaetsklinikum Regensburg
Message-ID: <49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCCB3D.8010706@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:50:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCS1-0006NJ-Se
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZC0Nsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZC0Nsb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:48:31 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:3980 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752362AbZC0Nsb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 09:48:31 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 7D5D7ABB7B;
	Fri, 27 Mar 2009 14:48:33 +0100 (CET)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id 23B78AAE3A;
	Fri, 27 Mar 2009 14:48:32 +0100 (CET)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n2RDmLwT008110;
	Fri, 27 Mar 2009 14:48:21 +0100
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    27 Mar 09 14:48:21 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 27 Mar 09 14:48:16 +0100
In-reply-to: <49CCCB3D.8010706@drmicha.warpmail.net>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589108@20090327.133413Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114893>

On 27 Mar 2009 at 13:49, Michael J Gruber wrote:

> Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:

[...]

> Keyword substitution and cvs/svn style version numbers are independent
> issues. The sha1 describes a commit uniquely, one could use that as a
> keyword.

However version numbers and time stamps have the property of being at least 
partially ordered in respect of "newer/older". That property does not hold for 
SHA-1 checksums. Just imagine suggesting users to upgrade from Microsoft 
Word/004765c2a1e9771e886f0dbe87d4f89643cd6f70 to Microsoft 
Word/00b7e6f51130f234a969c84ee9231a5ff7fc8a82 ;-)


> 
> Increasing version numbers are meaningless in a true DVCS world. What is
> your 100th commit may not be someone else's, even if both your master's
> heads are the same! This is why hg version numbers are a local thing.
> They are merely a local shortcut for specifying a revision and serve the
> same purpose as git's "backward" counts like HEAD~3 etc. Neither of them
> work permanently, not even in a local repo, if you allow rebasing.

Maybe I didn't fully understand, but having a version number that is larger than 
any parent's version numbers when doing a merge/commit doesn't look wrong to me.

> 
> git rev-list HEAD|wc may produce something like it, but be sure to read
> up on --sparse and --full-history.

I'm not deep enough into it, yet.

[...]

Regards,
Ulrich

From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: Re: qgit question: tagged commits not on a branch
Date: Fri, 27 Nov 2009 17:21:33 +0000 (UTC)
Message-ID: <Xns9CD0B0A0076E0ChrisCheneytesconet@80.91.229.13>
References: <Xns9CCFDEF02D061ChrisCheneytesconet@80.91.229.13> <4B0FECFA.9040307@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 18:22:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE4WB-00026A-D6
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 18:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbZK0RVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZK0RVv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 12:21:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:55081 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZK0RVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 12:21:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NE4W4-00023u-3G
	for git@vger.kernel.org; Fri, 27 Nov 2009 18:21:56 +0100
Received: from 82.25.192.152 ([82.25.192.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 18:21:56 +0100
Received: from chris.cheney.nospam by 82.25.192.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 18:21:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82.25.192.152
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133909>

Michael J Gruber <git@drmicha.warpmail.net> wrote in
news:4B0FECFA.9040307@drmicha.warpmail.net: 

> Chris.Cheney venit, vidit, dixit 26.11.2009 22:54:
>> My commit graph has a number of forks (I can't use the word
>> "branches" here) that are referenced only by a tag. Whereas gitk
>> --all displays this graph including those forks, qgit does not
>> display those forks - I don't see a way to make it do so, other than
>> by adding branches to those tagged commits. 
>> 
>> Have I overlooked something?
>> 
> 
> qgit --all does it for me. It may not be the newest qgit, though.
> I use tags like that to mark a version of a topic branch before
> rebasing, so that on old version won't be gc'ed away and the branch
> name space is not too crowded. Poor man's topgit, so to say. I guess
> it's a common use case.
> 
> Michael
> 

Doh, indeed it does.

The problem was that qgit isn't (by default) installed in the git program 
directory, as is gitk. Ok, I'll need to add a script in the git directory 
to invoke qgit (passing the command-line arguments through) from where it 
resides.

(WIBNI qgit and gitk provided a menu item to switch to --all mode.)

Thanks for your help

Chris

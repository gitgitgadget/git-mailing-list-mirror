From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Thu, 16 Oct 2008 18:09:48 -0400
Message-ID: <48F7BBAC.2090907@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 00:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqb3e-0002jD-Ts
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 00:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbYJPWJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYJPWJu
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 18:09:50 -0400
Received: from smtp242.iad.emailsrvr.com ([207.97.245.242]:50845 "EHLO
	smtp242.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbYJPWJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 18:09:50 -0400
Received: from relay14.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay14.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 6849C2055BF;
	Thu, 16 Oct 2008 18:09:48 -0400 (EDT)
Received: by relay14.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 495A0205573;
	Thu, 16 Oct 2008 18:09:48 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98429>

Peter Harris wrote:
> 
> Ah. I believe I misunderstood what you wanted. Perhaps you want "git
> remote add", then? Unfortunately, you have to know what your remotes
> are outside of git for this. Perhaps a script in the root of your
> repository you can run to set this up after the initial clone?

I think we're converging onto the same track.

Yes, I do want to use "git remote add".  My point is basically that, 
having done various git-remote-adds in the main repository, I'd like to 
avoid having to redo them in a clone of that repository.

A script would work, sure, but to me this seems like something git 
should handle for me.  If I have to re-establish my connections to the 
remotes whenever I want to pull in updates, then I don't see much point 
in keeping the remotes defined in any git repo.

> I seem to recall some discussion of allowing a .gitconfig to be in
> repositories (similar to .gitignore), but the idea was shot down for
> security reasons.

I think I can understand why that would be undesirable, but I don't know 
if something like that would be necessary for what I'm talking about.

		Marc

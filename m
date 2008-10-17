From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Working with remotes; cloning remote references
Date: Fri, 17 Oct 2008 09:33:36 +0200
Message-ID: <48F83FD0.90606@drmicha.warpmail.net>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 09:37:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqjtL-0001eB-3E
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 09:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYJQHdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 03:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbYJQHdk
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 03:33:40 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38001 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751207AbYJQHdk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 03:33:40 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 41C7018106F;
	Fri, 17 Oct 2008 03:33:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 17 Oct 2008 03:33:39 -0400
X-Sasl-enc: mmIQEUogc43gbPQU4zl/RI9cfk+FrJFbU9C9zOe/6qk8 1224228818
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7AB6D2C753;
	Fri, 17 Oct 2008 03:33:38 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48F7BBAC.2090907@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98455>

Marc Branchaud venit, vidit, dixit 17.10.2008 00:09:
> Peter Harris wrote:
>> Ah. I believe I misunderstood what you wanted. Perhaps you want "git
>> remote add", then? Unfortunately, you have to know what your remotes
>> are outside of git for this. Perhaps a script in the root of your
>> repository you can run to set this up after the initial clone?
> 
> I think we're converging onto the same track.
> 
> Yes, I do want to use "git remote add".  My point is basically that, 
> having done various git-remote-adds in the main repository, I'd like to 
> avoid having to redo them in a clone of that repository.
> 
> A script would work, sure, but to me this seems like something git 
> should handle for me.  If I have to re-establish my connections to the 
> remotes whenever I want to pull in updates, then I don't see much point 
> in keeping the remotes defined in any git repo.
> 
>> I seem to recall some discussion of allowing a .gitconfig to be in
>> repositories (similar to .gitignore), but the idea was shot down for
>> security reasons.
> 
> I think I can understand why that would be undesirable, but I don't know 
> if something like that would be necessary for what I'm talking about.

I don't think there is a direct gittish way for transferring the remote
config from one repo to a clone (other than copying what git submodule
does with .gitmodules etc.).

Would it be sufficient for you if a clone could trigger the main repo to
update its remotes (i.e. git remote update)?

Michael

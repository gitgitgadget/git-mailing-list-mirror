From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 00:10:04 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 06:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHWvY-0004aA-3T
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 06:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbYL3FKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 00:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbYL3FKf
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 00:10:35 -0500
Received: from rose.makesad.us ([219.105.37.19]:52171 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYL3FKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 00:10:35 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 36E49A011F
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 00:10:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id 5599E3A62BC
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 21:10:04 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104158>

On Tue, 30 Dec 2008, Ping Yin wrote:

> 2. unclear logic, for example, whether to remove the directory after the 
> last file in it is deleted

This is the thing I dislike most about git: that it sometimes calls 
rmdir() for me.  At least, one should be able to turn it off in a 
per-repository basis.  I'm going to see how hard a patch that would be to 
write.

> 3. hard work, no one has picked it yet

This is what I recall.

-- Asheesh.

-- 
Writing is turning one's worst moments into money.
 		-- J.P. Donleavy

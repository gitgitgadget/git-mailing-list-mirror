From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: How to manage heads on a remote repository?
Date: Sun, 14 Oct 2007 06:55:31 -0400
Message-ID: <FE53CAAB-6BAC-4EB6-A36F-C9DA69EDB04A@mit.edu>
References: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Theodore Ts'o" <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 12:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih18e-0006XO-UV
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 12:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbXJNKzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 06:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755170AbXJNKzx
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 06:55:53 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35015 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755367AbXJNKzw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 06:55:52 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9EAtWcM001319;
	Sun, 14 Oct 2007 06:55:33 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9EAtWjR010467
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 14 Oct 2007 06:55:32 -0400 (EDT)
In-Reply-To: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60827>


On 14 Oct 2007, at 6:46:25 AM, Theodore Ts'o wrote:

> so any automation at the moment
> looks like it would require me writing my own script and using  
> something
> like this:
>
>       ssh remote-host git --git-dir=xxx branch -D topics/foo
>
> ... which of course wouldn't work repo.or.cz since it requires shell
> access.
>
> Am I missing anything?

With my little exposure to git, I'd say it's not currently possible
with the git ui, but please wait for someone more authoritative to
say so.

In any case, I've run across similar problems, and I think this is
a good time to point out the feature that would be nice:
	
	All (most) git ui operations should be (relatively)
	transparent across networks;

I would like to clone to a remote server, for instance.

Michael Witten

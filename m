From: Marcel Partap <mpartap@gmx.net>
Subject: Git ~unusable on slow lines :,'C
Date: Mon, 08 Oct 2012 20:27:54 +0200
Message-ID: <50731B2A.6040104@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 20:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLI3y-0000d5-2X
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab2JHS2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:28:11 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:33540 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754445Ab2JHS2J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 14:28:09 -0400
Received: (qmail invoked by alias); 08 Oct 2012 18:28:07 -0000
Received: from unknown (EHLO [10.44.199.89]) [82.113.121.89]
  by mail.gmx.net (mp031) with SMTP; 08 Oct 2012 20:28:07 +0200
X-Authenticated: #724076
X-Provags-ID: V01U2FsdGVkX189/nBtwsk92g23TxqNGvFO6qe2Z158LVohCQ9/BF
	J94ScGZkFQQImS
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
X-Enigmail-Version: 1.4.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207257>

Dear Git Devs,
I love GIT, but since a couple of months I'm on 3G and after my traffic
limit is transcended, things slow down to a feeble 8KiB/s. Juuuust like
back then - things moved somewhat slower. And I'm fine with that - as
long as things just keep moving.
Unfortunately, git does not scale down very well, so for ten more days I
will be unable to get the newest commits onto my machine. Which is very,
very sad :/
> git fetch --verbose --all 
> Fetching origin
> POST git-upload-pack (1023 bytes)
> POST git-upload-pack (gzip 1123 to 614 bytes)
> POST git-upload-pack (gzip 1973 to 1030 bytes)
> POST git-upload-pack (gzip 5173 to 2639 bytes)
> POST git-upload-pack (gzip 7978 to 4042 bytes)
> remote: Counting objects: 24504, done.
> remote: Compressing objects: 100% (10705/10705), done.
> error: RPC failed; result=56, HTTP code = 200iB | 10 KiB/s       
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
> error: Could not fetch origin
Bam, the server kicked me off after taking to long to sync my copy.
Multiple potential points of action:
- git fetch should show the total amount of data it is about to transfer!
- when ab^H^Horting, the cursor should be moved down (tput cud1) to not
overwrite previous output
- would be nice to be able to tell git fetch to get the next chunk of
say 500 commits instead of trying to receive ALL commits, then b0rking
after umpteen percent on server timeout. Not?

#Regards!Marcel c:

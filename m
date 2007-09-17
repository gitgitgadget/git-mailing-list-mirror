From: Mike Hommey <mh@glandium.org>
Subject: commit summary, --pretty=short and other tools
Date: Mon, 17 Sep 2007 13:21:36 +0200
Organization: glandium.org
Message-ID: <20070917112136.GA30201@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 13:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXEgG-00084H-E2
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 13:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbXIQLWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 07:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbXIQLWP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 07:22:15 -0400
Received: from vawad.err.no ([85.19.200.177]:42956 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbXIQLWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 07:22:14 -0400
Received: from aputeaux-153-1-25-44.w82-124.abo.wanadoo.fr ([82.124.187.44] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IXEg5-0001me-CU
	for git@vger.kernel.org; Mon, 17 Sep 2007 13:22:14 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IXEfY-0007s3-BO
	for git@vger.kernel.org; Mon, 17 Sep 2007 13:21:36 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58425>

Hi,

I kind of shot myself in the foot with how to type proper commit
messages.

The git-commit manual page reads:
  Though not required, it´s a good idea to begin the commit message with a
  single short (less than 50 character) line summarizing the change,
  followed by a blank line and then a more thorough description. 

... and I happen to not have done the "followed by a blank line" part.

Now, git log --pretty=oneline (for instance), shows me the full commit
message on one line, which is not really what I would expect...

On the other hand, and that's how I got trapped into this, gitweb and
gitk only display the first line, be it followed by a blank line or not.

So, IMHO, there would be 2 solutions:
- either change --pretty=oneline,short and other similar things to take
  only the first line and change the git-commit manpage (and whenever
  else this might be written)
- or change gitweb, gitk and any other tool that would only take the
  first line so that it takes the same summary as --pretty=oneline.

What do you think ?

Mike

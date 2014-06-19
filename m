From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: The different EOL behavior between libgit2-based software and
 official Git
Date: Wed, 18 Jun 2014 19:59:38 -0700 (PDT)
Message-ID: <1403146778624-7613670.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 04:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxSZj-0004tI-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 04:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbaFSC7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 22:59:39 -0400
Received: from sam.nabble.com ([216.139.236.26]:44239 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756081AbaFSC7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 22:59:39 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1WxSZe-0000vK-KN
	for git@vger.kernel.org; Wed, 18 Jun 2014 19:59:38 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252087>

Hi:

^_^

I did some test on the EOL behavior between official git and libgit2-based
software(TortoiseGit).
Then, I got that they have different EOL behavior.

The blob stored in repository is a text file with mixed EOLs.
Even set core.autocrlf = true, official git checkout the file as it is(means
still *mixed EOLs* there).
But, libgit2 checkout it with *All CRLF EOLs*.

 * The steps:
   * set core.autocrlf = false
   * add file with mixed EOLs
   * set core.autocrlf = true
   * delete that file in the working tree
   * checkout that file
   * examine the EOL

If you are interested in this, you might take a look at my testing
repository on GitHub.
(https://github.com/YueLinHo/TestAutoCrlf)

Thank you.

Yue Lin Ho



--
View this message in context: http://git.661346.n2.nabble.com/The-different-EOL-behavior-between-libgit2-based-software-and-official-Git-tp7613670.html
Sent from the git mailing list archive at Nabble.com.

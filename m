From: list@phuk.ath.cx
Subject: git rm --cached and pull semantics
Date: Sat, 16 Jan 2010 17:50:01 +0100
Message-ID: <4B51EE39.3010401@phuk.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 17:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWBxv-0003CK-6v
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 17:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab0APQ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 11:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019Ab0APQ4p
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 11:56:45 -0500
Received: from xdsl-78-35-140-86.netcologne.de ([78.35.140.86]:37824 "EHLO
	horst.phuk.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0APQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 11:56:44 -0500
Received: from [192.168.10.157] (wald.phuk.ath.cx [192.168.10.157])
	by horst.phuk.ath.cx (Postfix) with ESMTP id 772A1230036
	for <git@vger.kernel.org>; Sat, 16 Jan 2010 17:49:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091230 Thunderbird/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137235>

Hello everyone,

I'm trying to manage and distribute a subset of /etc with git.
Therefore, I have * in .gitignore and use git add -f to add files. Now
sometimes I want to un-track a file that has been in previous commits,
but naturally I don't want the file deleted. I just want git to ignore
it again. As I read it, the way to do that is "git rm --cached $file".
On the local working tree, that works as expected, but when some remote
machine pulls a subsequent commit, it deletes the file from its working
tree. But I just want git to ignore the file again, just as it does in
the origin repo. How can I do that?

thanks for your time

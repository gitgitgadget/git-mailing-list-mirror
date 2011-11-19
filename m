From: Matthias Fechner <idefix@fechner.net>
Subject: Switch from svn to git and modify repo completely
Date: Sat, 19 Nov 2011 18:11:06 +0100
Message-ID: <4EC7E32A.9040903@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 18:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRoYb-0005yH-Qe
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 18:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab1KSRSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 12:18:04 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:21282 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab1KSRSD (ORCPT <rfc822;Git@vger.kernel.org>);
	Sat, 19 Nov 2011 12:18:03 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Nov 2011 12:18:03 EST
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pAJHBAks047105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <Git@vger.kernel.org>; Sat, 19 Nov 2011 18:11:14 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 2073E6B8E1
	for <Git@vger.kernel.org>; Sat, 19 Nov 2011 18:12:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YA_n-oLfr4OG for <Git@vger.kernel.org>;
	Sat, 19 Nov 2011 18:12:04 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:85bc:94f4:eba3:8b36] (unknown [IPv6:2001:a60:f035:1:85bc:94f4:eba3:8b36])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 81E5F6B8D6
	for <Git@vger.kernel.org>; Sat, 19 Nov 2011 18:12:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-Enigmail-Version: 1.3.3
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Sat, 19 Nov 2011 18:11:14 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185695>

Dear Git List,

I just started to migrate a svn repo to a git repo and was successfully
with the "git svn" command and waiting a long time :)

I have now some confidential documents in the repository I must remove
completely (including the complete history). These are single files
spread over the complete repository. Is this possible with git?

The next step I would like to do is separate the repo and smaller ones.
The problem here is it is not only take this directory and move it out,
it is a complete mess and the files are spread over the complete repo
and over all the revisions (files were moved around in the old
subversion repo from folder to folder). Is there a possibility to say
take file1, file2, fileN and directory1, directoryN and move it to
another repo or remove all not matching files/directories completely?

Thanks a lot for some hints which commands I could use here or if it is
possible.

Bye
Matthias

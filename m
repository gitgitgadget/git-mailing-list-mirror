From: "Julien POTIRON" <julien@gamr7.com>
Subject: git svn problem
Date: Wed, 13 Jan 2010 18:20:49 +0100 (CET)
Message-ID: <16912.217.109.160.5.1263403249.squirrel@www.gamr7.com>
Reply-To: julien@gamr7.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV70J-0007zq-Cr
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166Ab0AMR1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154Ab0AMR1b
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:27:31 -0500
Received: from outbound-mail-115.bluehost.com ([69.89.24.5]:36730 "HELO
	outbound-mail-115.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755907Ab0AMR1a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 12:27:30 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2010 12:27:30 EST
Received: (qmail 25212 invoked by uid 0); 13 Jan 2010 17:20:50 -0000
Received: from unknown (HELO box504.bluehost.com) (74.220.219.104)
  by outboundproxy3.bluehost.com with SMTP; 13 Jan 2010 17:20:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=gamr7.com;
	h=Message-ID:Date:Subject:From:To:Reply-To:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:Importance:X-Identified-User;
	b=epC+3LE6K+9X+xdh/F4FBDbcIWbyvzPX4qAr84eM/HuU92jL3Uo5ipeq8oN65jNmIU3r3E/urEf/vXzi7zM0UXr7eNQr5RhDMU5xxf2PibkEgocA3fFtbVPRPI4AaaYH;
Received: from localhost ([127.0.0.1] helo=www.gamr7.com)
	by box504.bluehost.com with esmtpa (Exim 4.69)
	(envelope-from <julien@gamr7.com>)
	id 1NV6tl-0006zZ-GI
	for git@vger.kernel.org; Wed, 13 Jan 2010 10:20:50 -0700
Received: from 217.109.160.5 ([217.109.160.5])
        (SquirrelMail authenticated user julien@gamr7.com)
        by www.gamr7.com with HTTP;
        Wed, 13 Jan 2010 18:20:49 +0100 (CET)
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Identified-User: {3137:box504.bluehost.com:gamrsevc:gamr7.com} {sentby:program running on server}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136844>

Hello, I have a problem with git.

Basically, here is what I have. I access a svn repository through git.
Until now, on python files, everything worked fine.

But lately I also added some pyd, dll and lib files on the repository. THe
first update went well. But then, these files have been modified and since
then I can't update. These files were added from a windows computer with
TortoiseSvn on the svn repository.

If I do a git svn rebase on linux, everything works fine.

If I do a git svn rebase on windows with msysgit (and also tortoisegit), I
have the following error : fatal: write error: Invalid argument

If I do a git svn rebase on windows with cygwin, I have the following
error : didn't find newline after blob at
/usr/lib/perl5/vendor_perl/5.10/Git.pm line 916

I tried several stuff (autocrlf true/false, safecrlf true/false), adding
.gitattributes file with the following line *.* -crlf -diff -merge and
nothing worked.

I'm a little stuck here so any suggestion would be welcome.

Thanks in advance.

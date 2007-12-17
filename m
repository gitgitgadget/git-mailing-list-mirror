From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Argument list too long" in git remote update (Was: Git and
 GCC)
Date: Mon, 17 Dec 2007 15:01:25 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712171455220.21557@woody.linux-foundation.org>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>   <2007-12-05-21-23-14+trackit+sam@rfc1149.net>   <1196891451.10408.54.camel@brick> <jeeje0ogvk.fsf@sykes.suse.de>   <1196897840.10408.57.camel@brick>  
 <38a0d8450712130640p1b5d74d6nfa124ad0b0110d64@mail.gmail.com> <1197572755.898.15.camel@brick> <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Harvey Harrison <harvey.harrison@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Oz9-0004FK-CA
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936618AbXLQXCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937232AbXLQXCO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:02:14 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60175 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934501AbXLQXCM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 18:02:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBHN1QrS004279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Dec 2007 15:01:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBHN1PBa006315;
	Mon, 17 Dec 2007 15:01:25 -0800
In-Reply-To: <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com>
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68650>



On Mon, 17 Dec 2007, Geert Bosch wrote:
> 
> With git version 1.5.3.6 on Mac OS X, this results in:
> potomac%:~/gcc%git remote update
> Updating gcc.gnu.org
> /opt/git/bin/git-fetch: line 220: /opt/git/bin/git: Argument list too long

Oops.

> Any ideas on what to do to resolve this?

Can you try the current git tree? "git fetch" is built-in these days, and 
that old shell-script that ran "git fetch--tool" on all the refs is no 
more, so most likely the problem simply no longer exists.

But maybe there is some way to raise the argument size limit on OS X. One 
thing to check is whether maybe you have an excessively big environment 
(just run "printenv" to see what it contains) which might be cutting down 
on the size allowed for arguments.

			Linus

From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 20:40:56 +0200
Message-ID: <200708232040.57014.robin.rosenberg.lists@dewire.com>
References: <46CC3090.7080500@gmail.com> <Pine.LNX.4.64.0708221713540.20400@racer.site> <3f4fd2640708221419w624a9920o5dc9a9fcbd680be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOHcs-00060U-9A
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764790AbXHWSlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760824AbXHWSlj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:41:39 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7728 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1764762AbXHWSlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:41:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6DCEE8027E5;
	Thu, 23 Aug 2007 20:33:54 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03692-10; Thu, 23 Aug 2007 20:33:54 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 075A28026EE;
	Thu, 23 Aug 2007 20:33:53 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <3f4fd2640708221419w624a9920o5dc9a9fcbd680be2@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56512>

onsdag 22 augusti 2007 skrev Reece Dunn:
> Given that you have to deal with other Windows issues (line ending,
> case insensitive file names, path format), why not put the current
> scripts in a posix porcelain directory and have a Windows porcelain
> directory where the Windows porcelain is written in C#?
Splitting effort in one language per platform would be very bad. Windows
programmers would write porcelains in C# that won't run on Linux.  Even
when you get the programs to run, C# is a second class citizen on *nix.

> Alternatively, the porcelain could be unified to use Python and
> compiled into an executable that is installed on the Windows platform
> (removing the need to have anything other than git installed to use
> it).
We need to attract developers on Windows too and making it hard to
get started with development (i.e. fix a tiny shitty bug or feature), should not require
lots of setups. When we speak of dependencies in an OSS project, those
that are required for development counts too.

> If not Python, then can you compile perl scripts to an executable
> form, in which case perl could be standardized on.

> This way, both camps (posix and Windows) will be happy.

Neither will be happy. Wannabe git hackers will find it hard to get started on
Windows, *nix users will be unhappy because the stuff written on windows
will be hard to get running on *nix etc and again windows users won't be 
unhappy because they don't get help with .NET issues from Linus.

-- robin

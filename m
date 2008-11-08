From: =?ISO-8859-1?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: libgit2 - a true git library
Date: Sat, 08 Nov 2008 14:26:51 +0100
Message-ID: <4915939B.1070306@gmail.com>
References: <20081031170704.GU14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 14:56:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyoIh-000429-Di
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 14:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbYKHNtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 08:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYKHNtQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 08:49:16 -0500
Received: from www.multitel.be ([193.190.194.194]:53686 "EHLO smtp.multitel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbYKHNtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 08:49:15 -0500
X-Greylist: delayed 1340 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Nov 2008 08:49:15 EST
Received: from localhost (localhost [127.0.0.1])
	by smtp.multitel.be (Postfix) with ESMTP id 234A34E81C8;
	Sat,  8 Nov 2008 14:26:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pop.multitel.be.multitel.be
Received: from smtp.multitel.be ([127.0.0.1])
	by localhost (pop.multitel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZJVTt79Daip; Sat,  8 Nov 2008 14:26:52 +0100 (CET)
Received: from [192.168.1.138] (unknown [91.86.82.250])
	by smtp.multitel.be (Postfix) with ESMTP id 477E44E8112;
	Sat,  8 Nov 2008 14:26:52 +0100 (CET)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <20081031170704.GU14786@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100401>

Shawn O. Pearce wrote:
> During the GitTogether we were kicking around the idea of a ground-up
> implementation of a Git library.  This may be easier than trying
> to grind down git.git into a library, as we aren't tied to any
> of the current global state baggage or the current die() based
> error handling.
> 
> I've started an _extremely_ rough draft.  The code compiles into a
> libgit.a but it doesn't even implement what it describes in the API,
> let alone a working Git implementation.  Really what I'm trying to
> incite here is some discussion on what the API looks like.

Just a random question: is there a reason why you have put all the .h in 
a separate includes/ directory instead of relying on the install target 
to put the include files at the right place ?

To me it makes it much harder to hack on the files as one is always 
required to switch between both directories...

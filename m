From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT RFC] Git Repository Exploring
Date: Tue, 5 Feb 2008 23:04:48 +0100
Message-ID: <200802052304.48382.robin.rosenberg@dewire.com>
References: <47A8841E.7050009@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:06:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVvT-0002Me-Ns
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760802AbYBEWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760617AbYBEWE5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:04:57 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29110 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1762577AbYBEWEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:04:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4647C800686;
	Tue,  5 Feb 2008 23:04:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8X8zQdy6u2W; Tue,  5 Feb 2008 23:04:51 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 4355780068A;
	Tue,  5 Feb 2008 23:04:51 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47A8841E.7050009@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72705>

tisdagen den 5 februari 2008 skrev Roger C. Soares:
> My first contact with egit was with the version that comes with fedora. 
> I tried to "checkout" a git project in many ways but none seemed to 
> work. Only a week later I read somewhere on the web that I had to import 
> an already cloned repo into eclipse and then go to Team -> Share Project.
> 
> So, to make it easier for new users coming from cvs or svn, my current 
> idea is to add a Git Repository Exploring Perspective and as soon as 
> possible give an warning that clone isn't there yet and how the user 
> should proceed.  Would it be ok?

Yes, but what infrastructure would that exploring facility work on? 
Known gitweb's? 

Anyway, by that time my fetch might be there. I was thinking about integrating
it with File/Import and add a new Git>Clone source and just have a dialog where
one could paste a URL-ish, user/password, or ssh public key. If you want to have
go at the dialog, I'd appreciate that.

I need to do at least basic local ref management in the fetching first, and maybe
some more test cases. Speed is slightly slower than the C version, but not terribly
so.

-- robin

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 19:48:48 +0000
Message-ID: <200803252048.48531.robin.rosenberg@dewire.com>
References: <20080324092726.GQ8410@spearce.org> <20080325053649.GE4759@spearce.org> <47E90246.3030509@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeFA8-0003Zk-1R
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022AbYCYTtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbYCYTtU
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:49:20 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21447 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758017AbYCYTtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:49:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 69DAB802659;
	Tue, 25 Mar 2008 20:49:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJTzASl+jJ9j; Tue, 25 Mar 2008 20:49:17 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id D4A8180069D;
	Tue, 25 Mar 2008 20:49:17 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47E90246.3030509@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78214>

Den Tuesday 25 March 2008 14.46.46 skrev Roger C. Soares:
> I understand that you guys use a lot of ASCII art and wrapping can mess
> this. But here we track more things in bugzilla and there's some
> copy&pasting going on, so wrapping makes comments more readable.
> Currently it's a toogle preference in the local toolbar menu (like the
> CVS plugin).

It seems to me ASCII art should be auto-detectable... Maybe enough to 
make the wrap flag unneeded in most cases. (wrap/nowrap/auto). At first
I was thinking about looking for special chars, but then it may be simpler
and just as useful to look for comment lines start with spaces ane a few
special characters.

Try this command: git log | sed 's/^    [\t |\\\/>]/|    /' | less. It seems 
to detect lines that I do not want wrapped pretty well.

-- robin

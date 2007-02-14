From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 20:18:52 -0500
Message-ID: <45D2637C.8030905@verizon.net>
References: <45CFA30C.6030202@verizon.net>
 <200702131816.27705.litvinov2004@gmail.com> <eqt40c$5ov$1@sea.gmane.org>
 <200702132258.20278.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 02:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH8o7-0007VF-1K
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 02:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXBNBS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 20:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXBNBS5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 20:18:57 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:16525 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbXBNBS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 20:18:56 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDF000R6IBC4HS0@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 13 Feb 2007 19:18:50 -0600 (CST)
In-reply-to: <200702132258.20278.robin.rosenberg.lists@dewire.com>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39606>

Robin Rosenberg wrote:
> 
> Even if there is a native port, I'm inclined to want to use the cygwin version 
> anyway because of the nice shell and scripting capabilities and large selection of packages
> that match what I'm used to in Linux. Git under cygwin should do CRLF transformations 
> according to the same rules that apply to text files in cygwin.
> 
> -- robin

The cygwin project is explicitly trying to bury the "text" mount option 
and drive towards binary (= \n line endings) only. They once had a rule 
that all cygwin programs fully grok \r\n, but that ethic disappeared a 
couple of years ago, it was just too hard. The cygwin git port itself 
will not operate on a text mount, it requires a binary mount, so crlf 
translations are simply not available with git under cygwin.

Mark

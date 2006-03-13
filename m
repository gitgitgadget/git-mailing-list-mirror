From: Mark Hollomon <markhollomon@comcast.net>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 18:26:48 -0500
Message-ID: <4415FFB8.3000001@comcast.net>
References: <20060313144747.GA81092@dspnet.fr.eu.org> <200603131717.53416.astralstorm@o2.pl> <Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Mar 14 00:27:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIwQu-00069X-56
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 00:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWCMX0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 18:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWCMX0d
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 18:26:33 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:34291 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751614AbWCMX0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 18:26:32 -0500
Received: from [10.0.0.3] (c-69-249-27-188.hsd1.de.comcast.net[69.249.27.188])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20060313232628m13001n34ae>; Mon, 13 Mar 2006 23:26:28 +0000
User-Agent: Thunderbird 1.5 (X11/20060113)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17577>

Linus Torvalds wrote:
> 
> 
> 	git whatchanged -p -1 <sha1>
> 
> instead (actually, if your git is really old, you shouldn't use the modern 
> shorthand of "-1", you should use the longer "--max-count=1" instead).

I must be misunderstanding this:

	git whatchanged -p -1 HEAD

in the current git tree results in nothing. only when I get to -5 does it show something.

Is this expected?

 > git version
git version 1.2.4.gea75

-- 
Mark Hollomon

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-format-patch possible regressions
Date: Fri, 26 May 2006 08:26:49 +0200
Organization: At home
Message-ID: <e56734$nj7$1@sea.gmane.org>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com> <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de> <7vy7wpr97n.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0605260125420.16816@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550605252309h2c4b74bcp50b095e09e6c133f@mail.gmail.com> <7v4pzdqpit.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 26 08:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjVmo-0005MF-5s
	for gcvg-git@gmane.org; Fri, 26 May 2006 08:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWEZG0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 02:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWEZG0w
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 02:26:52 -0400
Received: from main.gmane.org ([80.91.229.2]:4832 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751280AbWEZG0w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 02:26:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FjVmc-0005LB-OA
	for git@vger.kernel.org; Fri, 26 May 2006 08:26:50 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 May 2006 08:26:50 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 May 2006 08:26:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20799>

Junio C Hamano wrote:

> So the way for qgit to use it would become something like this.
> Instead of giving a list of ranges like "a..b c..d e..f":
> 
>  * Run "format-patch a..b"; by reading from its stdout you know
>    what patches you got -- you count them.
> 
>  * Run "format-patch --start-number=6 c..d" (if you got 5 out of
>    a..b);
[...]

I still think that having _shortcut notation_ being different for very
different commands is not a bad idea.

If one is really concerned about consistency of rev-list options, we could
use ',' or something to separate separate lists of commits, e.g.

   git format-patch a..b , c..d , e..f

or

   git format-patch a..b --then c..d --then e..f

What do you think about the idea?

-- 
Jakub Narebski
Warsaw, Poland

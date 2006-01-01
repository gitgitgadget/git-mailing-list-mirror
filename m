From: Christopher Faylor <me@cgf.cx>
Subject: Re: Possibility of a MinGW version?
Date: Sun, 1 Jan 2006 00:25:33 -0500
Message-ID: <20060101052533.GA31098@trixie.casa.cgf.cx>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <009701c60891$50893fd0$6900a8c0@sps> <Pine.LNX.4.63.0512241509240.24308@wbgn013.biozentrum.uni-wuerzburg.de> <003101c60976$f2912ff0$6900a8c0@sps> <20051231163952.GA29284@trixie.casa.cgf.cx> <43B6FDC5.6020601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 01 06:26:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsvjQ-0006RI-Jj
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 06:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWAAFZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 00:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWAAFZg
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 00:25:36 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:26812 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751090AbWAAFZg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 00:25:36 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id E625D13C49C; Sun,  1 Jan 2006 00:25:33 -0500 (EST)
To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <43B6FDC5.6020601@zytor.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14127>

On Sat, Dec 31, 2005 at 01:53:09PM -0800, H. Peter Anvin wrote:
>Christopher Faylor wrote:
>>As was mentioned, the Cygwin project is very far from dead and has
>>actually never been close to dead.  It is, however, like any open
>>source project and things like the setup program are always under slow,
>>sporadic development.
>>
>>The core cygwin dll is under active development and maintenance and
>>most of the packages in the distribution are under active maintenance,
>>however.
>
>Cygwin probably could benefit greatly if they adopted something like
>rpm/yum for packaging, instead of reinventing the wheel.

Yes, Cygwin isn't a new project so ideas like this have been kicked
around many times over the years.  You can't just port rpm, apt, or yum
and then say "We'll use this for updates now" because there are
chicken/egg problems.  The problems are not unsolvable but, so far, no
one has cared enough to do anything about them.

cgf

From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Annotate another problem report
Date: Mon, 7 Aug 2006 13:19:21 -0700
Message-ID: <20060807201920.GE15477@h4x0r5.com>
References: <20060807115000.GC15477@h4x0r5.com> <1154952684908-git-send-email-ryan@michonline.com> <11549526841904-git-send-email-ryan@michonline.com> <7virl42w6s.fsf@assigned-by-dhcp.cox.net> <7vpsfc1fkt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 22:20:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GABaR-00014d-7r
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 22:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWHGUU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWHGUU1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 16:20:27 -0400
Received: from h4x0r5.com ([70.85.31.202]:59407 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751039AbWHGUU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 16:20:27 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1GABZJ-0003Jo-E6; Mon, 07 Aug 2006 13:19:21 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsfc1fkt.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25039>

On Mon, Aug 07, 2006 at 01:00:34PM -0700, Junio C Hamano wrote:
> "git annotate Makefile v1.4.0" outputs this:

Known.  I think this is related to the merge-parsing bug.

Unfortunately, the only test cases I've found for this involve things
with both a lot of revisions and a lot of lines, so it's a bit hard to
manually see what's going wrong.

> ...
> 58e60dd2	(Nick Hengeveld	2005-11-02 11:19:24 -0800	13)# git.......
> 58e60dd2	(Nick Hengeveld	2005-11-02 11:19:24 -0800	14)# tra.......
> 	(          	1970-01-01 00:00:00 	15)#
> 6d9bbc50	(Patrick Mauritz	2005-09-19 16:11:19 +0200	16)# ..
> 6d9bbc50	(Patrick Mauritz	2005-09-19 16:11:19 +0200	17)# ..
> ...
> 
> There are a handful lines it couldn't tell where they came from:
> 
> 	(          	1970-01-01 00:00:00 	15)#
> 	(          	1970-01-01 00:00:00 	179)
> 	(          	1970-01-01 00:00:00 	182)
> 	(          	1970-01-01 00:00:00 	274)endif
> 	(          	1970-01-01 00:00:00 	323)
> 	(          	1970-01-01 00:00:00 	384)else
> 	(          	1970-01-01 00:00:00 	385)	LIB_4_ICONV =
> 
> 

-- 

Ryan Anderson
  sometimes Pug Majere

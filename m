From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: Massive testsuite failure on !(Linux || Solaris 8+)
Date: Mon, 26 Apr 2010 17:03:01 +0000
Message-ID: <20100426170301.GD28004@thor.il.thewrittenword.com>
References: <20100316100917.GA27121@thor.il.thewrittenword.com>
 <20100426074411.GA31428@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 19:03:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6RiK-0005qJ-S7
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab0DZRDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 13:03:05 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:62219 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0DZRDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 13:03:03 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 301955CAD;
	Mon, 26 Apr 2010 17:24:07 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 301955CAD
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 90D74A56;
	Mon, 26 Apr 2010 17:03:01 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 8259DBAB6; Mon, 26 Apr 2010 17:03:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100426074411.GA31428@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145830>

On Mon, Apr 26, 2010 at 02:44:11AM -0500, Jonathan Nieder wrote:
> Hi Gary,

Hi Jonathan,

> Gary V. Vaughan wrote:
> 
> > I have full logs on all hosts, up until t9300 test 120, which hangs (I
> > left it overnight to be sure since some of these machines are quite
> > old and slow) the testsuite until SIGINT.  The logs are, obviously,
> > huge so I won't post them here,
> 
> What tends be most useful is output from
> 
>   GIT_TEST_OPTS='-v -i' gmake test
> 
> [[...]]
> 
> Also, if you would like to investigate, you might find it useful to
> use
> 
>   sh -x relevant-test.sh
> 
> [[...]]
> 
> Hope that helps,

It does, thanks.  I've added looking into this to my TODO list... it's
relatively important that the testsuite is (at least mostly) useful on
our supported platforms as a sanity check against our patched builds
of git on those platforms.

I'll post any patches or further questions that arise back here in due
course.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)

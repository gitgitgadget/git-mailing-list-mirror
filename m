From: Greg KH <greg@kroah.com>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 22:44:35 -0800
Message-ID: <20060214064435.GA19831@kroah.com>
References: <20060214055425.GA32261@kroah.com> <20060214055648.GA592@kroah.com> <7vveviv5d1.fsf@assigned-by-dhcp.cox.net> <20060214063420.GA11851@kroah.com> <7vlkwev41k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:44:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tvP-0005nq-Hs
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWBNGoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbWBNGoc
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:44:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:26554
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030493AbWBNGoc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:44:32 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F8tvN-00023k-DJ; Mon, 13 Feb 2006 22:44:33 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkwev41k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16123>

On Mon, Feb 13, 2006 at 10:37:59PM -0800, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> >> Have you tried "git apply --stat" instead?
> >
> > How would that work after I've allready applied the patches to a branch?
> 
> Sorry I was unclear.  By "instead", I meant "instead of running
> diffstat -p1".

That doesn't give me a summary of all of the changes I made to the tree:

$ git apply --stat *.txt
 drivers/hwmon/vt8231.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
 drivers/hwmon/w83781d.c |   43 +++++++++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 18 deletions(-)
 Documentation/hwmon/w83627hf |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 drivers/hwmon/it87.c         |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
 drivers/i2c/busses/i2c-isa.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)


Instead of:

 Documentation/hwmon/w83627hf |    4 ++++
 drivers/hwmon/it87.c         |    3 ++-
 drivers/hwmon/vt8231.c       |    8 ++++----
 drivers/hwmon/w83781d.c      |   43 +++++++++++++++++++++++++------------------
 drivers/i2c/busses/i2c-isa.c |   12 ------------
 5 files changed, 35 insertions(+), 35 deletions(-)

Which is what I need to put into a "please pull from this tree" email
message.

thanks,

greg k-h

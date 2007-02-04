From: Niklas =?ISO-8859-1?Q?H=F6glund?= <nhoglund@gmail.com>
Subject: Re: git and file name case on cygwin
Date: Sun, 04 Feb 2007 13:59:17 +0000
Message-ID: <1170597557.7538.12.camel@localhost>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
	 <Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
	 <7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 14:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDhtt-0008CY-8B
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 14:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXBDN7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 08:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXBDN7X
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 08:59:23 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:12873 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXBDN7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 08:59:21 -0500
Received: by an-out-0708.google.com with SMTP id b33so893278ana
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 05:59:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=oDVlsH7/XTX+S3FlyLePqLvlbnasqP2kTBolLD509QVAZDpSpzqnfor6CBZs9z6cNm2mQ4WocJ8kaE2VSSBkpU27rBw1KNML+6l9xJxlNwECMMlTkaXqSo51nk5EwEYkmQ5V13E4wV3oT86Y0/6u9Eky+j5T3qyO9at09FgKIYM=
Received: by 10.100.120.5 with SMTP id s5mr3991215anc.1170597561107;
        Sun, 04 Feb 2007 05:59:21 -0800 (PST)
Received: from ?192.168.1.2? ( [86.145.174.167])
        by mx.google.com with ESMTP id c1sm6039605ana.2007.02.04.05.59.19;
        Sun, 04 Feb 2007 05:59:20 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
X-Mailer: Evolution 2.8.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38689>

On Sat, 2007-02-03 at 17:17 -0800, Linus Torvalds wrote: 
> Here's a clue:
> 
> 	include/linux/netfilter/xt_dscp.h
> 	include/linux/netfilter/xt_DSCP.h
> 
> are both tracked files..

Oh. It never struck me that people would use the "same" name for two
different things. I thought it was something more subtle, like I file
being renamed from one case to another. I should have looked a bit more
carefully.


On Sat, 2007-02-03 at 17:38 -0800, Linus Torvalds wrote:
> On Sat, 3 Feb 2007, Junio C Hamano wrote:
> > 
> > Are there plans to "fix" the confusion by renaming them to
> > reduce chances of name clashes on such suboptimal filesystems?
> 
> I don't think so. Nobody really does development on such broken 
> filesystems, and I kind of have this nagging suspicion that Niklas noticed 
> just because he wanted to test git, not because he really wanted to do 
> Linux development under Windows ;)

It's true that I don't intend to do any Linux development on a Windows
system. I'd use a Linux system or a Linux VM for that. I do on occasion
have a look through the Linux source code when I'm struggling with some
badly documented hardware, but I could use a tarball for that. (I guess
the netfilter code would still get mangled, but I can live with that.)

Niklas

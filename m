From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 00:16:35 -0800
Message-ID: <20060110081635.GS18439@ca-server1.us.oracle.com>
References: <43C2D2C4.2010904@cc.jyu.fi> <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net> <20060110045533.GO18439@ca-server1.us.oracle.com> <7vk6d8aaln.fsf@assigned-by-dhcp.cox.net> <20060110063247.GP18439@ca-server1.us.oracle.com> <7vy81o8r6n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 09:16:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwEgN-0001zn-RA
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 09:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWAJIQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 03:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWAJIQl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 03:16:41 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:42959 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932095AbWAJIQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 03:16:41 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k0A8GZHB028454;
	Tue, 10 Jan 2006 01:16:35 -0700
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A8GYxf013685;
	Tue, 10 Jan 2006 01:16:35 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0A8GYRZ013673
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 01:16:34 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1EwEgF-0001Ji-4A; Tue, 10 Jan 2006 00:16:35 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy81o8r6n.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14413>

On Mon, Jan 09, 2006 at 11:42:24PM -0800, Junio C Hamano wrote:
> Joel Becker <Joel.Becker@oracle.com> writes:
> > ...  I'd really rather have the tunneling
> > code be part of connect.c,...
> 
> For the record, I was pushing for that, but that approach was
> interrupted primarily by what this message implies:
> 
>     http://article.gmane.org/gmane.comp.version-control.git/10985

	Yeah, we want to handle multiple things.  Well, I've got it
working with git-tunnel.pl, so I'm happy enough not to be using rsync://
:-)

Joel

-- 

Life's Little Instruction Book #139

	"Never deprive someone of hope; it might be all they have."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

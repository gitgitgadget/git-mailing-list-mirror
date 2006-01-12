From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 11:00:31 -0800
Message-ID: <20060112190031.GH14196@ca-server1.us.oracle.com>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:00:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex7gd-0007Cd-O3
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 20:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWALTAg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 14:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWALTAg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 14:00:36 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:32453 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964775AbWALTAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 14:00:35 -0500
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0CJ0VDN025135;
	Thu, 12 Jan 2006 13:00:32 -0600
Received: from rgmsgw02.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0CJ0VLw007596;
	Thu, 12 Jan 2006 12:00:31 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k0CJ0VYI007582
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 12:00:31 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1Ex7gV-0007lN-3W; Thu, 12 Jan 2006 11:00:31 -0800
To: sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14579>

On Thu, Jan 12, 2006 at 09:37:00AM -0500, sean wrote:
> Use the author name and email information given as the 
> first line of the commit message in the form of:
> 
> From: name <email>
> 
> as the author's name and email address in the resulting
> commit object.  This makes committing foreign patches
> a little less cumbersome to handle for some workflows.

	If we do this, can we have it populated up front?  That is, when
the edit opens, the current idea of author is in the comments as "From:"
so I can see what the author would be if I changed nothing.  This would
catch surprises where I'd forgotten to set AUTHOR_*, etc.

Joel
 

-- 

Life's Little Instruction Book #182

	"Be romantic."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

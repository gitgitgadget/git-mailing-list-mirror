From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 15:50:56 -0700
Message-ID: <20060503225056.GT4226@ca-server1.us.oracle.com>
References: <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se> <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> <20060503164732.GB9820@thunk.org> <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org> <20060503223932.GA28081@mars.ravnborg.org> <20060503224645.GR27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 00:51:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbQBZ-0002SL-Vo
	for gcvg-git@gmane.org; Thu, 04 May 2006 00:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWECWvG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 18:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWECWvG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 18:51:06 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:38037 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751387AbWECWvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 18:51:04 -0400
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id k43MovJr004891;
	Wed, 3 May 2006 16:50:58 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k43Mou9e006901
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 16:50:57 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1FbQBM-0005yJ-Ms; Wed, 03 May 2006 15:50:56 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060503224645.GR27689@pasky.or.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19530>

On Thu, May 04, 2006 at 12:46:45AM +0200, Petr Baudis wrote:
> I think git ls-files isn't used directly very frequently. OTOH, you
> don't use cg-log or git log and cg-status/git status? :) Also, most
> people will pull.

	I use git ls-files, becuase it's the only way I know how to
blow away dirty state that added files.  I ran into this just yesterday,
actually.  git checkout -f won't remove files that are unknown.

    $ git ls-files -o | xargs rm -rf

Joel

-- 

Life's Little Instruction Book #452

	"Never compromise your integrity."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

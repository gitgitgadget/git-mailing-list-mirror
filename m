From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: git-bisect broken in 1.2.4
Date: Tue, 2 May 2006 09:01:55 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060502070155.GA861@informatik.uni-freiburg.de>
References: <20060501181020.GA21263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 02 09:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaouA-0004Fw-T4
	for gcvg-git@gmane.org; Tue, 02 May 2006 09:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWEBHCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEBHCF
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 03:02:05 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58864 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932421AbWEBHCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 03:02:02 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FaotV-0004S9-Cp
	for git@vger.kernel.org; Tue, 02 May 2006 09:02:01 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k42720m01005
	for git@vger.kernel.org; Tue, 2 May 2006 09:02:00 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060501181020.GA21263@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19399>

Olaf Hering wrote:
> Did SuSE just pick up a bad version of git, 1.2.4?
> git-bisect doesnt work correctly in the kernel sources, .git/HEAD doesnt
> contain the commit id anymore, but 'ref: refs/heads/bisect'
> 
> CONFIG_LOCALVERSION_AUTO depends on the id.
Probably you should update to at least linux-v2.6.15-g117a93d.  The
script to determine the localversion[1] depends on .git/HEAD being a
symlink.

Since 

	git-1.1.4-g2fabd21

.git/HEAD isn't a symlink any more (per default at least).

You can rebuild git with USE_SYMLINK_HEAD if you really want the old
behaviour.

Best regards,
Uwe

[1] scripts/setlocalversion

-- 
Uwe Zeisberger

http://www.google.com/search?q=gigabyte+in+bit

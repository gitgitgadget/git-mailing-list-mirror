From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Locking a branch
Date: Mon, 08 May 2006 11:45:33 +0100
Message-ID: <tnxzmhspzg2.fsf@arm.com>
References: <1146970243.24434.77.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 12:46:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd3FX-0006Kx-Vd
	for gcvg-git@gmane.org; Mon, 08 May 2006 12:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWEHKpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 06:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWEHKpp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 06:45:45 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:52640 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751109AbWEHKpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 06:45:45 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k48AjcZ8010460;
	Mon, 8 May 2006 11:45:39 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 8 May 2006 11:45:38 +0100
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1146970243.24434.77.camel@dv> (Pavel Roskin's message of "Sat,
 06 May 2006 22:50:43 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 08 May 2006 10:45:38.0692 (UTC) FILETIME=[8B6ECC40:01C6728C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19761>

Pavel Roskin <proski@gnu.org> wrote:
> I see there is an active discussion about branch attributes.  It
> would be nice to have an attribute to prevent git from changing the
> branch head in any way.  The reason is that it interferes with StGIT
> on StGIT managed branches.  If StGIT is fine with the change, it
> would remove or override the lock temporarily.  StGIT could also
> unlock the branch permanently if there are no applied patches.

I'm fine with this. At the moment, StGIT does extra checking before
some of the commands to ensure that HEAD is the same as the top of the
stack (i.e. no commits were generated outside stg commands). While
I'll probably still keep this check, the addition would be useful for
people mixing GIT and StGIT commands (I personally try to stay with
StGIT commands as much as possible).

-- 
Catalin

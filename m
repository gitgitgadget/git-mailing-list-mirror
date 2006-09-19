From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] Skip t3403 selftests if stdin is not a terminal
Date: Tue, 19 Sep 2006 17:04:42 +0000
Message-ID: <20060919170442.28169.qmail@e5754f1244ec85.315fe32.mid.smarden.org>
References: <20060915125910.10514.qmail@26499ea44f2ee3.315fe32.mid.smarden.org> <7vk644e5f5.fsf@assigned-by-dhcp.cox.net> <7v3base3l5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 19 19:04:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPj1E-0006xq-JV
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 19:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWISREV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWISREV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 13:04:21 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:36331 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1030319AbWISREU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 13:04:20 -0400
Received: (qmail 28170 invoked by uid 1000); 19 Sep 2006 17:04:42 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3base3l5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27279>

On Fri, Sep 15, 2006 at 11:19:02PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Gerrit Pape <pape@smarden.org> writes:
> >> sh t3403-rebase-skip.sh </dev/null fails because stdin is not connected
> >> to a terminal, as in the Debian autobuild environment.  This disbales
> >> the test 3 and 7 in this case.
> >
> > Disabling these tests somehow feels as if you are shooting the
> > messenger who reports breakage of the commands they try to test.
> >
> > Is it expected that the git Porcelainish commands involved in
> > these particular tests not to work without terminal?  If not
> > maybe we should fix them, not the test.
> 
> How about this instead?

Yes, this is the better fix, I agree.  The selftests work fine for me
with this patch applied.

Thanks, Gerrit.

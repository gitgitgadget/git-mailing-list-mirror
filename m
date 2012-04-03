From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: Failure of new tabbed preferences dialog
Date: Tue, 3 Apr 2012 22:19:45 +1000
Message-ID: <20120403121944.GC24141@bloggs.ozlabs.ibm.com>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
 <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
 <7vty12gl8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 14:23:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF2m1-00014z-1N
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 14:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab2DCMXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 08:23:35 -0400
Received: from ozlabs.org ([203.10.76.45]:38191 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab2DCMXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 08:23:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9B377B6FE9; Tue,  3 Apr 2012 22:23:32 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <7vty12gl8r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194616>

On Mon, Apr 02, 2012 at 09:19:00AM -0700, Junio C Hamano wrote:
> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
> 
> >> I just tried the new gitk (master @fae9d76) and, since I don't have
> >> themed widgets, the preferences menu item uses the emulated tabbed
> >> dialog code, which fails like so:
> >>
> >>     can't read "col": no such variable
> >
> > The issue here is that the incr command has changed between tcl 8.4
> > and 8.5 and in more recent versions automatically creates the named
> > variable if it did not exist. The fix you suggest is correct. I've
> > also included another that I realised had been applied to msysGit and
> > was not posted upstream.
> 
> This seems severe enough that we should put it in the coming release.
> I can queue them directory to gitk tree (and later ask Paul to pull it
> from me), and merge the result to expedite the roundtrip.

OK; the patches look fine to me.  If that's what you're doing, I won't
apply them to my tree, to avoid duplication.

Paul.

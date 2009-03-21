From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked branch
Date: Sat, 21 Mar 2009 10:10:48 +0900
Message-ID: <87zlff8yuf.fsf@catnip.gol.com>
References: <200903181448.50706.agruen@suse.de>
	<7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
	<200903210135.33729.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 02:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkq39-0004dT-IZ
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 02:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZCUB33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 21:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZCUB33
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 21:29:29 -0400
Received: from main.gmane.org ([80.91.229.2]:55417 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbZCUB32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 21:29:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lkq1b-00011z-Ci
	for git@vger.kernel.org; Sat, 21 Mar 2009 01:29:23 +0000
Received: from 218.231.175.8.eo.eaccess.ne.jp ([218.231.175.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 01:29:23 +0000
Received: from miles by 218.231.175.8.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 01:29:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.175.8.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:AAW/uzAnTn91KNhKYQkSUVfXqmg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114020>

Andreas Gruenbacher <agruen@suse.de> writes:
> To me the most obvious escape sequence would be \x for disabling whatever 
> special meaning x has (for non-alphabetic x). With quoting you likely 
> eventually end up needing  \' in some cases anyway...

I think it's a good idea to _avoid_ using backslash as an escape when
possible -- the potential for confusion and screwups from multiple
layers all interpreting backslash should be familiar to most people
here...  (single-quote suffers from the same problem a bit, but at least
it's not quite as overused as backslash)

-Miles

-- 
One of the lessons of history is that nothing is often a good thing to
do, and always a clever thing to say.  -- Will Durant

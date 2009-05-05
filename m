From: Tim Olsen <tim@brooklynpenguin.com>
Subject: Re: still getting 'It is a submodule!" in 1.6.2.5
Date: Tue, 05 May 2009 10:23:06 -0400
Message-ID: <4A004BCA.5070709@brooklynpenguin.com>
References: <gtnjq8$317$1@ger.gmane.org> <7vy6tc2gnt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 16:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1LYR-0004mk-UL
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 16:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbZEEOXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 10:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbZEEOXT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 10:23:19 -0400
Received: from main.gmane.org ([80.91.229.2]:60188 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbZEEOXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 10:23:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M1LYE-0002Qt-50
	for git@vger.kernel.org; Tue, 05 May 2009 14:23:18 +0000
Received: from cyrus.limewire.com ([76.8.67.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 May 2009 14:23:18 +0000
Received: from tim by cyrus.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 May 2009 14:23:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cyrus.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <7vy6tc2gnt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118299>

Junio C Hamano wrote:
> But that is not the one you want.  7dae8b2 (diff -c -p: do not die on
> submodules, 2009-04-29) is to allow viewing of such a merge correctly; To
> make the merge automatically, you'd need 0c44c94 (merge-recursive: do not
> die on a conflicting submodule, 2009-04-29), which is on 'master', but not
> on 1.6.2.X (and likely will never be).
> 
> Could you be running 1.6.3-rcX instead of 1.6.2.X?  In general, the tip of
> the 'master' is always as stable as any released version, if not more.

Thanks Junio for your reply.  We have made a copy of the offending
branch by hand and have managed to merge that instead for now.  I can
wait until 1.6.3 is released.

Thanks again for your help!

Tim

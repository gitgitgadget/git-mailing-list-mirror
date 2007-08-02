From: David Kastrup <dak@gnu.org>
Subject: Re: 1.5.3 plans and preparations
Date: Thu, 02 Aug 2007 11:42:37 +0200
Message-ID: <868x8umfw2.fsf@lola.quinscape.zz>
References: <7vfy32z9hv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708021021060.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 11:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXCl-0004fM-Ir
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbXHBJmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbXHBJms
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:42:48 -0400
Received: from main.gmane.org ([80.91.229.2]:58599 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXHBJmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 05:42:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGXCe-00027W-J7
	for git@vger.kernel.org; Thu, 02 Aug 2007 11:42:44 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 11:42:44 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 11:42:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:ddoQzV/KYFSx5U+wRLw5RloQ/to=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54530>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 2 Aug 2007, Junio C Hamano wrote:
>
>>   - "git commit --amend" is now compatible with various message source
>>     options such as -m/-C/-c/-F.
>
> Urgh.  That makes it much more easy for new users to shoot
> themselves in the foot.  By "-C" and "-F" you do not even see the
> runstatus anymore, since no editor was fired up.  Please say
> something like "use with care", or "do not try this at home", too.

Hm?  How is that specific to "--amend"?  Isn't that just a consequence
of -m/-C/-F, regardless of whether one uses --amend or not?

When there are unmerged changes, --amend will not complete anyway.
And of course, if you got things wrong, you can always do another
--amend, so it is not like there is serious damage involved.

What do I overlook here?

And before you complain about not getting a copy by Email again: I
have to go via Gmane from my work account, since it will for some
unfathomable reason drop most of my mails (except those I use for
testing the problem) from this address.  It is manual work to add a
"Cc" header in this setup (which I often forget), and even then, I
doubt this copy will arrive at your place via mail (please tell me if
it does).

-- 
David Kastrup

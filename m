From: David Kastrup <dak@gnu.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 02 Aug 2007 12:29:14 +0200
Message-ID: <86tzrikz5x.fsf@lola.quinscape.zz>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
	<7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	<87tzrjfe5h.wl%cworth@cworth.org>
	<alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
	<7vejim1n92.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 12:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXwp-0002sd-NA
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXHBK3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXHBK3i
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:29:38 -0400
Received: from main.gmane.org ([80.91.229.2]:49668 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756775AbXHBK3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:29:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGXvs-0007CG-JX
	for git@vger.kernel.org; Thu, 02 Aug 2007 12:29:28 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 12:29:28 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 12:29:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:DJsotmBATAJn3zeKgBIly+TLVt4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54536>

Junio C Hamano <gitster@pobox.com> writes:

>  * With -l, as long as the source repository is healthy, it is
>    very likely that the recipient would be, too.  Also it is
>    very cheap.  You do not get any back-up benefit.

Oh, but one does: an overzealous prune or rm -oopswrongoption in one
repo does not hurt the other.

> Which leads me to believe that being able to use file:/// is
> probably a good idea, if only for testability, but probably of
> little practical value, and we can default to -l for everyday
> use, and paranoids can use non -l as a way to make a back-up.

Sane enough, I guess.

-- 
David Kastrup

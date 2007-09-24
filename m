From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 13:39:16 +0200
Message-ID: <861wcouwbf.fsf@lola.quinscape.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz> <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com> <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp> <20070924080436.GB9112@artemis.corp> <Pine.LNX.4.64.0709241128460.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 13:39:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZmHq-0004Ty-NZ
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 13:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbXIXLjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 07:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbXIXLjd
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 07:39:33 -0400
Received: from main.gmane.org ([80.91.229.2]:54636 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbXIXLjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 07:39:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZmHe-0003lG-OY
	for git@vger.kernel.org; Mon, 24 Sep 2007 11:39:27 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 11:39:26 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 11:39:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:OfRpaeePz0+PlYl9j3LiJhQX35g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59042>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The reason we used "case" is that this has always been a builtin
> (has to be, because it changes workflow).
>
> Therefore I am somewhat uneasy that the patch went in so easily,

It didn't yet.

> especially given a message that flies in the face of our endeavours
> to make git less dependent on any given shell (as long as it is not
> broken to begin with).

"test" is not actually a shell dependency since it is available as an
external when not available as builtin.  And if you really want to
prefer "case" over "test" because the latter is not a built-in in a
small number of shells, then it should be done consistently everywhere
and not just in code I touch.

-- 
David Kastrup

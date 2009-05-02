From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] git-svn testsuite: use standard configuration for
	Subversion tools
Date: Sat, 2 May 2009 14:36:29 +0400
Message-ID: <GzXVCxlG1vigUEGxhNBLVXNYljM@AnOk+mYbmYVORDu5SWQWxomMUcc>
References: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7vfxfowugm.fsf@gitster.siamese.dyndns.org> <Z0zFdWIzyQzuBQjCf+Jk/nJtvIw@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7viqkkv43t.fsf@gitster.siamese.dyndns.org>
Reply-To: rea-git@codelabs.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normaperson@yhbt.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 02 12:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0CaK-0000QC-Rj
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 12:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZEBKgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 06:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbZEBKgg
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 06:36:36 -0400
Received: from 0.mx.codelabs.ru ([144.206.177.45]:52843 "EHLO 0.mx.codelabs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbZEBKgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 06:36:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender;
	b=oCbwyorCner0X8rt3SzgWCI/EzzgOyNqF3cFZGq6PGvSU5BdYdKKf2tWJwXo6rmBACHaGwAfzcQZfy0a+MMi/kUuTZeBkKxGF1/3YH86XL6SbZlKeMedifjVb5LkTa8QHjl9yN2+mgSyj29WLw5S8J/N8K6UZ9h7XY8rm/M3aE0=;
Received: from amnesiac.at.no.dns (ppp83-237-107-194.pppoe.mtu-net.ru [83.237.107.194])
	by 0.mx.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1M0Ca9-0002WR-0W; Sat, 02 May 2009 14:36:33 +0400
Content-Disposition: inline
In-Reply-To: <7viqkkv43t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118129>

Junio,

Fri, May 01, 2009 at 03:40:54PM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > What are your concerns, 'local'?
> 
> Exactly.

It exists in Bash and in *BSD /bin/sh.  It does not exist in Korn shell
(at least, I am failing to find one).  I can just remove 'local' from
the function, since it plays no big role, but generally I don't like to
pollute parent namespace by local variables.  Certainly, if 'local' will
break some known shell -- I'll refrain from using it in this script.

Do you know an example of shell that is used by Git (thus being /bin/sh
in the system) and that lacks 'local' builtin?

Thanks!
-- 
Eygene

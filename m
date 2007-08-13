From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 09:24:42 +0200
Message-ID: <86eji7lww5.fsf@lola.quinscape.zz>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 09:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKUIX-00071M-Sm
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 09:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941710AbXHMHZB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 03:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941706AbXHMHZA
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 03:25:00 -0400
Received: from main.gmane.org ([80.91.229.2]:45928 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S941698AbXHMHY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 03:24:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IKUIG-0007Re-JE
	for git@vger.kernel.org; Mon, 13 Aug 2007 09:24:52 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 09:24:52 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 09:24:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:/Av9JsVDTQ3UJEGZpQ5LY2hSYfk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55750>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>     $ git update-ref --no-deref HEAD $(git rev-parse v1.5.3-rc4^0)

Is there a fundamental difference to using

git-symbolic-ref HEAD $(git rev-parse v1.5.3-rc4^0)

here?

-- 
David Kastrup

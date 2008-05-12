From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 06:11:39 -0700
Message-ID: <87ej87is50.fsf@offby1.atm01.sea.blarg.net>
References: <4827DEF6.1050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 15:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvY0z-00073Q-1Y
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 15:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYELNXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 09:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYELNXX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 09:23:23 -0400
Received: from main.gmane.org ([80.91.229.2]:44789 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbYELNXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 09:23:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JvXzn-0000Vy-GR
	for git@vger.kernel.org; Mon, 12 May 2008 13:23:15 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 May 2008 13:23:15 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 May 2008 13:23:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:N/3FKYddV1pL0uZMPK0RGQOnc7s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81861>

>>>>> "bill" == bill lam <cbill.lam@gmail.com> writes:

    bill> Hello, this should be a simple question.  How to backup a git
    bill> repository but excluding files that not under versioned?  If I
    bill> cp or tar or rsync the directory.  All non-versioned files are
    bill> added.

I'd rsync just the .git directory.

-- 
It sounds churlish to bash a film that's as bereft of bad
thoughts as a tiny puppy.  But when the puppy licks your face for 108
minutes, enough's enough.
        -- Matt Zoller Seitz, NY Times

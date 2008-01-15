From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH - v2] gitk: fix "Key bindings" message
Date: Tue, 15 Jan 2008 22:57:47 +1100
Message-ID: <18316.40891.875291.618507@cargo.ozlabs.ibm.com>
References: <200801081437.46398.barra_cuda@katamail.com>
	<18308.2284.160506.432481@cargo.ozlabs.ibm.com>
	<200801091916.52680.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 12:59:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEkSC-0008Rv-Nr
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 12:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYAOL7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 06:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYAOL7K
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 06:59:10 -0500
Received: from ozlabs.org ([203.10.76.45]:58305 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbYAOL7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 06:59:08 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 88E58DDE32; Tue, 15 Jan 2008 22:59:05 +1100 (EST)
In-Reply-To: <200801091916.52680.barra_cuda@katamail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70516>

Michele Ballabio writes:

> This patch tries to do so. Is this correct?

Pretty good...  I think that $M1T needs to be passed through [mc] as
well, and I would tend to use [list M1T $M1T] rather than "M1T $M1T",
but apart from that it's OK.  I am wondering whether the help text
needs to be busted up into individual lines for processing by [mc].

Paul.

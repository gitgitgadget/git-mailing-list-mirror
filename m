From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 10:39:02 +1100
Message-ID: <18228.61334.145989.77872@cargo.ozlabs.ibm.com>
References: <4733AEA6.1040802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdRt-0005hF-MI
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXKIXjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbXKIXjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:39:25 -0500
Received: from ozlabs.org ([203.10.76.45]:54374 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303AbXKIXjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:39:24 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A1B53DDE33; Sat, 10 Nov 2007 10:39:23 +1100 (EST)
In-Reply-To: <4733AEA6.1040802@lsrfire.ath.cx>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64283>

Thanks for doing this.

Could I ask for a couple more things?  I would find it useful to have
format codes for the number of characters in the commit body.  Having
a code for the number of bytes in the commit body would also be
useful.  When reading commits in with Tcl, the number of characters is
more useful, but I can use the number of bytes (and I imagine others
would find that useful).

Paul.

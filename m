From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 11:52:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607011146530.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <e86ega$gnc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 20:52:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwkZz-0003WV-CA
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWGASw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWGASw2
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:52:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751543AbWGASw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 14:52:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k61IqOnW011250
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Jul 2006 11:52:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k61IqNPU007758;
	Sat, 1 Jul 2006 11:52:23 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e86ega$gnc$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23058>



On Sat, 1 Jul 2006, Jakub Narebski wrote:
> 
> Caret is used twice, with different meaning. As prefix operator "^" means 
> "exclude lineage of commit" (while commit without "^" in front means:
> "include lineage of commit and commit itself"). BTW. why we don't use '!'
> for that?

Using '!' is really nasty with most shells. Avoid, avoid, avoid.

It would be more sensible to use ~ (mathematical negation), but that also 
has magic meaning for shell at the beginning of a word..

			Linus

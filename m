From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPG signing for git commit?
Date: Tue, 7 Apr 2009 11:04:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904071102450.27889@localhost.localdomain>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <m3ljqc1h55.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chow Loong Jin <hyperair@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 20:07:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrFi9-0006Kv-Gc
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 20:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758799AbZDGSGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 14:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758605AbZDGSGO
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 14:06:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53939 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758185AbZDGSGO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 14:06:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n37I4PAL011928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Apr 2009 11:05:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n37I4PCC017293;
	Tue, 7 Apr 2009 11:04:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <m3ljqc1h55.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.44 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115973>



On Tue, 7 Apr 2009, Jakub Narebski wrote:
> 
> And if you really, really need for some reason (for example
> requirement checkpoint, or being paranoid enough) ned to have each and
> every commit signed, you can use Monotone instead of Git.  That is
> what we recommended IPsec (or something) on #git.

Yeah, well..

That's more of a "If you really want to be incredibly slow, depend on an 
unbelievably baroque model, _and_ you are too stupid to understand the 
fact that you only need to sign the tip", then use Monotone.

But yes, the "sign each commit" is one of the big design mistakes in 
Monotone. Go ask them about how much pain it has caused them.

			Linus

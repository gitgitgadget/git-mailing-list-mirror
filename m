From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path-restricted gitk with tags showing up?
Date: Tue, 1 Aug 2006 11:39:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608011137580.4168@g5.osdl.org>
References: <20060801174210.GA81699@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 20:40:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7z9b-0003eR-Uu
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 20:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWHASjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 14:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWHASjl
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 14:39:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751779AbWHASjk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 14:39:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k71IdHnW017252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 1 Aug 2006 11:39:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k71IdGYO023140;
	Tue, 1 Aug 2006 11:39:16 -0700
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060801174210.GA81699@dspnet.fr.eu.org>
X-Spam-Status: No, hits=-0.484 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24607>



On Tue, 1 Aug 2006, Olivier Galibert wrote:
>
> I'd like to do a (f.i) gitk include/sound/asound.h but still see the
> commits which are in the DAG delimited by the alsa commits and have
> tags attached.  The aim is to know what changes where in what released
> kernel version.  Is there a way to do that?

Not right now. It should be fairly easy to add a flag that marks all 
tagged commits (or, indeed, anything that is reachable from .git/refs/) as 
"TREECHANGE" so that they aren't optimized away, but we don't have 
anything like that right now at least.

A small exercise for somebody who wants to get into git, perhaps? Hint, 
hint..

		Linus

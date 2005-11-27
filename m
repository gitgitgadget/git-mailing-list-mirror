From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: What's in master and pu (aka when will 1.0rc4 be out)
Date: Sun, 27 Nov 2005 15:11:34 +0200
Message-ID: <20051127151134.0eac7019.tihirvon@gmail.com>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
 <7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 14:12:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgMJl-00051u-LD
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 14:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVK0NLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 08:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVK0NLm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 08:11:42 -0500
Received: from marski.suomi.net ([212.50.131.142]:22923 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S1751038AbVK0NLl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 08:11:41 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IQM005F87BGZ750@marski.suomi.net> for git@vger.kernel.org;
 Sun, 27 Nov 2005 15:11:40 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IQM00D047GTTU80@mailstore.suomi.net>; Sun,
 27 Nov 2005 15:14:53 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam2.suomi.net (Postfix) with SMTP id F3C8F11AE6A; Sun,
 27 Nov 2005 15:11:34 +0200 (EET)
In-reply-to: <7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.7; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.917,	required 5,
 autolearn=not spam, AWL 0.68, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12807>

On Sun, 27 Nov 2005 02:56:21 -0800
Junio C Hamano <junkio@cox.net> wrote:

> *1* Bisecting only in a subdirectory might be an interesting
> thing to do, hunting down a bug in a subsystem, but usually a
> subsystem has at least two relevant subdirectories (source and
> include file trees) ;-).

Hmm.. would something like 

    git-bisect --include drivers/char/drm/ --include include/ ...

be easy to implement?  That command would limit bisecting to only the
commits that have changed files under those two directories.

-- 
http://onion.dynserv.net/~timo/

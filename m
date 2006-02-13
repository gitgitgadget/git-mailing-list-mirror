From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:44:56 -0800
Message-ID: <20060213024456.6b68a1fa.akpm@osdl.org>
References: <20060213101443.GD11053@mythryan2.michonline.com>
	<20060213104036.67433.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: ryan@michonline.com, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 11:46:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8bDR-00049J-Vj
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBMKpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBMKpz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:45:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932071AbWBMKpy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 05:45:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DAjjDZ024252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 02:45:46 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1DAjjcp013565;
	Mon, 13 Feb 2006 02:45:45 -0800
To: ltuikov@yahoo.com
In-Reply-To: <20060213104036.67433.qmail@web31811.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16069>

Luben Tuikov <ltuikov@yahoo.com> wrote:
>
> Andrew,
> 
> Here is the output:
> 
> $ git-diff-tree --pretty -p 386093ef9a6c88576d8b418bf1c8616d5e410a20

Yes, that is decent.  But for many patches, I'd end up having to call the
files "386093ef9a6c88576d8b418bf1c8616d5e410a20.patch".  git-format-patch
chooses nice filenames.  Slowly.

Anyway, repeated applications of the one-diff git-format-patch (based on a
grep of the git-log output) got me the 69 patches which I want, so I can
find this bug now, thanks.

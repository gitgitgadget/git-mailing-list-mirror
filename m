From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] cogito - split out cg-X* to prefix/lib/cogito
Date: Tue, 26 Apr 2005 14:44:07 -0700
Message-ID: <20050426214407.GC5324@shell0.pdx.osdl.net>
References: <200504260053.33506.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:41:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXlj-00051c-Pw
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVDZVoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDZVoM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:44:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:18896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261781AbVDZVoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:44:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QLi7s4029222
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 14:44:08 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QLi7OG011419;
	Tue, 26 Apr 2005 14:44:07 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j3QLi7U7011418;
	Tue, 26 Apr 2005 14:44:07 -0700
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
Content-Disposition: inline
In-Reply-To: <200504260053.33506.jcorbin@wunjo.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(BTW, this patch was linewrapped)

* Joshua T. Corbin (jcorbin@wunjo.org) wrote:
> The following patch does the following:
>   * Change the Makefile to install all cg-X* to $(prefix)/lib/cogito
>   * Modify all cg-* to use this lib prefix.

Hmm, I agree with the intent of this patch (place extraneous bits out of
/usr/bin namespace), although I'm not sure it's the best method.  It
winds up only putting three files there (with cg- prefixes as well).

I've left it out of the rpm build for now.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

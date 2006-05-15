From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: how to display file history?
Date: Mon, 15 May 2006 10:54:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605151049470.3866@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670FB0A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 19:55:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfhHb-0002On-FY
	for gcvg-git@gmane.org; Mon, 15 May 2006 19:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWEORy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEORy7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 13:54:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965009AbWEORy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 13:54:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FHsrtH017774
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 10:54:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FHsmU9011229;
	Mon, 15 May 2006 10:54:51 -0700
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670FB0A@hdsmsx411.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20072>



On Mon, 15 May 2006, Brown, Len wrote:
>
> >	git log --stat -- A
> 
> very handy indeed.
> 
> I was surprised on initial use that --stat is
> limited to the file specified in "A" and doesn't
> expand to describe the entire commit that touches "A".
> (ie. the stat output is a subset of what is associated
> with the displayed commit comments).
> 
> This, of course, is clear now, it just isn't what
> I expected on first use.

Well,  you can obviously have your cake and eat it too (ie "--full-diff").

I don't often end up using the "--full-diff" thing. It's almost never 
actually worth it until I find the diff that I actually start caring 
about, and the full diff just makes it harder to see the part I explicitly 
told git I was interested in.

So the default "show only diffs for the files asked for" behaviour is in 
my opinion much superior (and it used to be the only one), because the 
"show the whole thing" part ends up being something you use only once 
you've already skimmed the default case and decide to go deeper.

Of course, "gitk" ends up using the full diff by default in its diff 
window. I'm not convinced that's the right thing, but usually when I use 
gitk I'm primarily looking at the history and the commit messages to 
decide if it's a relevant one, not the diff, so I don't think it matters.

			Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 08:06:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509190803270.9106@g5.osdl.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
 <85slw1rvne.fsf@riget.hn.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 17:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHNED-0001zz-Kx
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 17:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVISPGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVISPGn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 11:06:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932453AbVISPGm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 11:06:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JF6YBo013386
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 08:06:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JF6SRF029850;
	Mon, 19 Sep 2005 08:06:31 -0700
To: Joachim B Haga <cjhaga@fys.uio.no>
In-Reply-To: <85slw1rvne.fsf@riget.hn.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8875>



On Mon, 19 Sep 2005, Joachim B Haga wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > >   * strcasestr() in mailinfo.  We may need compat/strcasestr.c;
> > 
> > Totally untested, of course.
> >
> > +	int hlen = strlen(haystack) - nlen;
> 
> int hlen = strlen(haystack) - nlen + 1;

Yeah. Duh.

		Linus

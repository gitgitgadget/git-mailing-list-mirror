From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 20:40:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607032039010.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com>
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <1151973438.4723.70.camel@neko.keithp.com>
 <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org> <7vsllinj1m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 05:41:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxbmX-0000kv-37
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 05:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWGDDkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 23:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWGDDkt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 23:40:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750991AbWGDDks (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 23:40:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k643einW014444
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 20:40:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k643eh1d015065;
	Mon, 3 Jul 2006 20:40:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsllinj1m.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23244>



On Mon, 3 Jul 2006, Junio C Hamano wrote:
> 
> Isn't that because the repository have 32 subprojects, totally
> unrelated content-wise?  If you have real stuff to pull from
> there your pack generation needs to do 32 time as much work as
> you would for a single head in that case.

No, Keith said this was for the case where the fetching repository is 
already totally up-to-date:

    "And, it's painfully slow, even when the repository is up to date"

and gave a 17-second time.

			Linus

From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn changing file:// to svn+ssh://
Date: Tue, 27 Oct 2009 10:17:40 -0700
Message-ID: <1256663860.680.3.camel@denix>
References: <4AE5EF55.2070902@obry.net>
	 <32541b130910261218x5fdc0233jcce7c5769aad73ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: pascal@obry.net, git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ph4-0006bI-Jr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 18:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbZJ0RSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbZJ0RSm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 13:18:42 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43544 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbZJ0RSl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 13:18:41 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 51BB221C4D7; Wed, 28 Oct 2009 06:18:39 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [IPv6:::1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7F71921C3D6;
	Wed, 28 Oct 2009 06:18:21 +1300 (NZDT)
In-Reply-To: <32541b130910261218x5fdc0233jcce7c5769aad73ec@mail.gmail.com>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131361>

On Mon, 2009-10-26 at 15:18 -0400, Avery Pennarun wrote:
> > Now I have converted the file:// to svn+ssh:// using:
> 
> I'm not sure about the actual bug you're experiencing, but you could
> have done this more simply using the --rewrite-root option to git-svn.
>  It might still save you time to just do that from scratch.

Another thing: if your file:// repository was copied from the original
location using SVN::Mirror or svnsync, then git-svn is capable of
reading the breadcrumbs left by those tools with a switch and rewriting
the git-svn-id: lines accordingly.

Sam

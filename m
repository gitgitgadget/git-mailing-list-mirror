From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2, proof of concept] autoconf: Use %configure in
	git.spec, autoconf dependency only in rpm target
Date: Thu, 06 Jul 2006 00:16:37 -0400
Message-ID: <1152159397.10415.29.camel@dv>
References: <200607030156.50455.jnareb@gmail.com>
	 <200607041609.36329.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 06:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyLIK-00065Z-C9
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 06:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWGFEQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 00:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWGFEQl
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 00:16:41 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:26583 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965171AbWGFEQl
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 00:16:41 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FyLI7-0006O4-Q6
	for git@vger.kernel.org; Thu, 06 Jul 2006 00:16:39 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FyLI5-0002nh-Kh; Thu, 06 Jul 2006 00:16:37 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200607041609.36329.jnareb@gmail.com>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23371>

Hi Jakub,

On Tue, 2006-07-04 at 16:09 +0200, Jakub Narebski wrote:
> Sidenote 1: current git.spec.in doesn't allow building RPMS from a dirty
> version: 
>   error: line 3: Illegal char '-' in version: Version:    1.4.1.g1c7c-dirty
> Is it intentional?

I don't know if it's intentional, but it's annoying.  The workaround is
to use StGIT and run "stg refresh" before "make rpm".

> +Patch0: 	git-add-autoconf-configure.patch.gz

I don't think we need patches in git.spec.in.  Let's leave it to the
actual distributions.  If you have a problem with rpm, please submit the
autoconf support for now and the rest will be cleaned up eventually.
Besides, the "next" branch has different and potentially conflicting
changes to git.spec.in for Git.pm support.

-- 
Regards,
Pavel Roskin

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Initialize SVN::Client with svn config instead
 of, auth for "git svn branch".
Date: Wed, 23 Jul 2014 22:33:49 +0000
Message-ID: <20140723223349.GB14145@dcvr.yhbt.net>
References: <53C93611.7090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Monard Vong <travelingsoul86@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:33:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA56i-0001xB-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 00:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933994AbaGWWdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 18:33:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40790 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933856AbaGWWdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 18:33:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627A21F4DD;
	Wed, 23 Jul 2014 22:33:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <53C93611.7090705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254135>

Monard Vong <travelingsoul86@gmail.com> wrote:
> If a client certificate is required to connect to svn, "git svn branch"
> always prompt the user for the certificate location and password,
> even though those parameters are stored in svn file "server"
> located in svn config dir (generally ~/.subversion).
> On the opposite, "git svn info/init/dcommit" read the config dir
> and do not prompt if the parameters are set.
> 
> This commit initializes for "git svn branch", the SVN::Client with
> the 'config'
> option instead of 'auth'. As decribed in the SVN documentation,
> http://search.cpan.org/~mschwern/Alien-SVN-v1.7.17.1/src/subversion/subversion/bindings/swig/perl/native/Client.pm#METHODS
> the SVN::Client will then read cached authentication options.
> 
> Signed-off-by: Monard Vong <travelingsoul86@gmail.com>

Thanks, I do not have a good way to test this, but the idea seems
correct.

Your patch is whitespace mangled, and the commit message and subject
needs to be improved (see Documentation/SubmittingPatches on how to
describe your changes and how to send them without whitespace mangling.)

Thanks again.

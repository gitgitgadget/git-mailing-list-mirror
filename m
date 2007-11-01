From: Theodore Tso <tytso@thunk.org>
Subject: Re: remote#branch
Date: Thu, 1 Nov 2007 01:11:34 -0400
Message-ID: <20071101051133.GA8847@thunk.org>
References: <20071030053732.GA16963@hermes.priv> <472844D4.8050306@op5.se> <20071031091529.GA25025@glandium.org> <200711010122.34190.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Andreas Ericsson <ae@op5.se>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 06:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InSMi-0008Nh-Vb
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 06:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbXKAFMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 01:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXKAFMi
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 01:12:38 -0400
Received: from THUNK.ORG ([69.25.196.29]:44320 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbXKAFMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 01:12:37 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1InSVw-0004t8-UM; Thu, 01 Nov 2007 01:22:45 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1InSL8-00031w-Cr; Thu, 01 Nov 2007 01:11:34 -0400
Content-Disposition: inline
In-Reply-To: <200711010122.34190.jnareb@gmail.com>
1;1609;0cFrom: Theodore Tso <tytso@mit.edu>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62916>

On Thu, Nov 01, 2007 at 01:22:33AM +0100, Jakub Narebski wrote:
> The only thing to add (for absolutely no gain IMHO) would be code
> which would add quotes (single or double) around URL/path which
> contain spaces:
>   
>   Mirror URL    'git://repo.or.cz/repo with spaces.git'
>                 'http://repo.or.cz/r/repo with spaces.git'
>   Push URL      'repo.or.cz:/srv/git/repo with spaces.git'  

The one thing that I think might be worth doing out of all of this is
to add code to git so that it can accept URL quoted arguments.  Given
that it's highly unlikely anyone is using repository pathnames that
contain the '%' character, this would be highly unlikely to cause any
backwards compatibility problems.

					- Ted

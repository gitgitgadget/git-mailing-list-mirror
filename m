From: Josef Wolf <jw@raven.inka.de>
Subject: Re: How to push to http(s) repository with authentication?
Date: Fri, 24 Oct 2008 00:32:56 +0200
Message-ID: <20081023223256.GB3526@raven.wolf.lan>
References: <20081020182502.GH9707@raven.wolf.lan> <20081023175336.GA3526@raven.wolf.lan> <20081023190544.GA21079@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 00:41:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt8rw-0007fR-L4
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYJWWkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 18:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYJWWkN
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 18:40:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:46544 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYJWWkM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 18:40:12 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Kt8qg-0007QT-BC; Fri, 24 Oct 2008 00:40:10 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 302F53ABAB; Fri, 24 Oct 2008 00:32:57 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081023190544.GA21079@blimp.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98991>

On Thu, Oct 23, 2008 at 09:05:44PM +0200, Alex Riesen wrote:

Thanks for your response, Alex!

[ ... ]
>        --cacert <CA certificate>
[ ... ]

> Does this (setting $CURL_CA_BUNDLE) help?

Well, as I wrote in my original mail, I already got the certificate
working.  My problem is the usage of the .netrc file.  I don't want
to store passwords in cleartext in files.

So the real question is: how do I make git-http to ask for credentials.

Sorry, I should have made more clearly what's the problem.

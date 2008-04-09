From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Automated/Daily build systems supporting git?
Date: Wed, 09 Apr 2008 10:31:52 +0000
Message-ID: <1207737112.5698.9.camel@pitcairn.cambridgebroadband.com>
References: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
	 <20080408145953.GA8159@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 12:32:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjXbI-0001LD-8u
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYDIKbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 06:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYDIKbe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:31:34 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:11239 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbYDIKbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 06:31:33 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3227171fkr.5
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 03:31:32 -0700 (PDT)
Received: by 10.82.127.15 with SMTP id z15mr11659094buc.14.1207737091595;
        Wed, 09 Apr 2008 03:31:31 -0700 (PDT)
Received: from ?10.0.0.166? ( [212.44.17.78])
        by mx.google.com with ESMTPS id 7sm7228372nfv.18.2008.04.09.03.31.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Apr 2008 03:31:30 -0700 (PDT)
In-Reply-To: <20080408145953.GA8159@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79097>


On Tue, 2008-04-08 at 10:59 -0400, Jeff King wrote:
> On Tue, Apr 08, 2008 at 03:57:52PM +0100, Alex Bennee wrote:
> 
> > I'm currently doing some investigation into automated/daily build
> > systems to track the health of a source tree. There seem to be a number
> > about but as I'm also looking to move the CVS tree over to git I was
> > wondering if the denziens of the list knew of any they could recommend?
> 
> Have you looked at contrib/continuous?

Thanks for the pointer, it's a nice example of using the git hooks.

However perhaps it's a little too simple for our needs. We have multiple
build targets/hosts and configurations building out of the one
repository. We currently have a homemade script that runs nightlies and
emails the results, however to expand the build test we probably want
something that give a simple web-page overview of the current status.


-- 
Alex, homepage: http://www.bennee.com/~alex/
Scientists will study your brain to learn more about your distant
cousin, Man.

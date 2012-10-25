From: Josef Wolf <jw@raven.inka.de>
Subject: Workflow for templates?
Date: Thu, 25 Oct 2012 23:15:22 +0200
Message-ID: <20121025211522.GA28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 23:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRVCa-0001c4-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 23:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab2JYVmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 17:42:45 -0400
Received: from quechua.inka.de ([193.197.184.2]:55947 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab2JYVmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 17:42:44 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2012 17:42:44 EDT
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1TRUqZ-0005hc-Bz; Thu, 25 Oct 2012 23:20:11 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 70AD1760CB; Thu, 25 Oct 2012 23:15:22 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208420>

Hello everybody,

I am looking for a setup where teplates can be handled easily.

For a better explanation of what I'm trying to achieve, I use the apache
httpd project as an example.

Apache httpd provides an extensively commented httpd.conf template, which
users can use as a starting point for their own customization.

Tha's fine so far. But I'd like this to work in both directions:

Downstream: When the upstream template has new changes, I can merge them into
my local branch. Conflicts will remind me that I have to review my
customization.

Upstream: Within the customized working copy, I implement a new module or
change an existing one (e.g. mod_ssl). While implementing the new feature, I
add/modify my _customized_ template. When I'm happy with the new feature, I'd
like to rewrite the localized customization into something generic and send it
along with the implementation of the new feature to the upstream generic
template. My localized customization should not get lost during the
process, of course.

One more important aspect: since the customized template might contain
confidential information, those bits should have a hard time to propagate to
the upstream repository.

I guess the downstream part can be done by a vendor branch. But I have a hard
time to find a proper workflow for the upstream part.

Any ideas?

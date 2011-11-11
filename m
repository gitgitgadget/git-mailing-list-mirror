From: Jvsrvcs <jvsrvcs@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 13:09:42 -0800 (PST)
Message-ID: <1321045782702-6986770.post@n2.nabble.com>
References: <1321044904175-6986736.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 22:09:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROyM9-0006XS-GO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 22:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195Ab1KKVJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 16:09:45 -0500
Received: from sam.nabble.com ([216.139.236.26]:48883 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757308Ab1KKVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 16:09:43 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <jvsrvcs@gmail.com>)
	id 1ROyM2-0000DQ-Mr
	for git@vger.kernel.org; Fri, 11 Nov 2011 13:09:42 -0800
In-Reply-To: <1321044904175-6986736.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185287>

The thing is that I want my 'master' branch' to reflect what is in the
'master' repo - we are using another versioning control system than git for
the master for the moment. 

I want to be able to switch to the master at any moment, do an update there
with the primary versioning system in use, and get all others commits and
merge down to my branch from time to time.

It seems to me that this behaviour corrupts the master branch, reflecting a
change in the master branch that I did not want or expect.

so I suppose the correct work flow would to be *ALWAYS*, commit on the
branch you are on before switching to another branch?  I think this would
solve the problem.

This just seems a bit odd.  I did not commit on the branch, I switched and
it's on the master now.  At any rate, I can work with it, just need to know
the correct work flow I should take before switching to another branch, and
that seems to be *ALWAYS* commit before switching to get the expected
behaviour that seems normal to me.

--
View this message in context: http://git.661346.n2.nabble.com/Git-Unexpected-behaviour-tp6986736p6986770.html
Sent from the git mailing list archive at Nabble.com.

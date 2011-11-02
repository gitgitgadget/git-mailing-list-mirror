From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: (unknown)
Date: Wed,  2 Nov 2011 12:38:14 -0400
Message-ID: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Nov 02 17:38:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLdpX-0002Ki-RH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 17:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab1KBQiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 12:38:19 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:49858 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709Ab1KBQiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 12:38:18 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:35075 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RLdpR-0002RA-1V; Wed, 02 Nov 2011 12:38:17 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RLdpR-0001gQ-0S; Wed, 02 Nov 2011 12:38:17 -0400
Subject: 
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184644>

Hi Eric,

When running the test suite against subversion 1.7 on solaris, t9134
was failing with an assertion failure in the SVN bindings and a
subsequent core dump from perl.

The behaviour of 1.7 has seemingly changed such that even file paths
must be eascaped/canonicalized now.  The core dump behaviour is
something that still needs to be investigated with the subversion
folks.  A colleague and I will push that on their side.

See the initial discussion of this issue on the svn list here:
http://article.gmane.org/gmane.comp.version-control.subversion.devel/132227

With the following patch, the test suite once again passes.  I don't
know how it will behave against an older client though so maybe a
conditional check for the version of the bindings is still required?

Thanks
-Ben

From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: 
In-Reply-To: 

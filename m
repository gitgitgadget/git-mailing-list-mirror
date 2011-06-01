From: garyc618 <gary.carter@eigen.com>
Subject: How to make fetch get everything?
Date: Tue, 31 May 2011 17:06:16 -0700 (PDT)
Message-ID: <1306886776234-6425155.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 02:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRYx3-0005BP-KS
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 02:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab1FAAGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 20:06:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:58047 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab1FAAGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 20:06:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <gary.carter@eigen.com>)
	id 1QRYwy-0008Uk-7j
	for git@vger.kernel.org; Tue, 31 May 2011 17:06:16 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174840>

Hi List,

In one book it says that "git fetch [remote]" pulls down everything you
don't currently have in your local repository.  However, when I look at
FETCH_HEAD it only has the master head.  Other branches don't seem to get
fetched.

I tried "git fetch [remote] *:*" but that gave fatal error messages.

Then I tried "git fetch [remote] "*:foo/*" which worked great - I got every
single branch.

I am setting up a shared repo for a small devel team, which I want everyone
to push/pull to.   It seems safer to do that, than to have people just make
the shared mount their current directory, then run git commands, but how can
people see every branch in the shared repo using only fetch, other than the
trick with foo/* that I used above?  Am I missing something, or is this just
going to be kind of clunky?

Thanks,

Gary Carter

--
View this message in context: http://git.661346.n2.nabble.com/How-to-make-fetch-get-everything-tp6425155p6425155.html
Sent from the git mailing list archive at Nabble.com.

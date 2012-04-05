From: LordSmoke <dslice@morphometrics.org>
Subject: Re: Sharing nested subparts of large repository?
Date: Thu, 5 Apr 2012 01:32:34 -0700 (PDT)
Message-ID: <1333614754844-7439149.post@n2.nabble.com>
References: <1332693502389-7403743.post@n2.nabble.com> <1332957138457-7414676.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 10:32:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFi7W-00028W-PQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 10:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab2DEIch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 04:32:37 -0400
Received: from sam.nabble.com ([216.139.236.26]:34894 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab2DEIcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 04:32:36 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dslice@morphometrics.org>)
	id 1SFi7O-00039B-SI
	for git@vger.kernel.org; Thu, 05 Apr 2012 01:32:34 -0700
In-Reply-To: <1332957138457-7414676.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194764>

Okay, it seems submodules really were the answer. I split my app into a
standalone public subtree and a development subtree that will use the public
source as a submodule (haven't actually done that yet, though). These will
be excluded from the parent git repository, but I guess that is fine since
the parent is used mainly for archiving and the remote repository serves as
the code archive.

--
View this message in context: http://git.661346.n2.nabble.com/Sharing-nested-subparts-of-large-repository-tp7403743p7439149.html
Sent from the git mailing list archive at Nabble.com.

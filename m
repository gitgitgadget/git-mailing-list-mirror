From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Why is 'map' used in filter-branch's skip_commit?
Date: Wed, 13 Aug 2008 16:16:27 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808131606020.11830@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 23:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNio-0000r7-JJ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbYHMVQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYHMVQa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:16:30 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:33536 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYHMVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:16:29 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7DLGRRH013922;
	Wed, 13 Aug 2008 16:16:27 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7DLGRoI012436;
	Wed, 13 Aug 2008 16:16:27 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92275>

Hi,

I was wondering why skip_commit uses 'map' to rewrite the parents
supplied to the commit-filter.

For a moment, I was worried that if skip_commit has to rewrite parents
then the user should have to, too, before passing them to git
commit-tree - but no, it seems that the parents supplied to the
commit-filter are already rewritten.  In fact, before skip_commit was
introduced (commit f95eef), an example in the filter-branch
documentation used 'echo' instead of 'map' for the same construct.

Is it just a matter of style?  Or am I missing something else?

Thanks,

Jonathan

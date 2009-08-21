From: Seba Illingworth <seba.illingworth@gmail.com>
Subject: git diffall, open all diff files immediatly (eg tabbed window in BC)
Date: Fri, 21 Aug 2009 03:47:07 +0000 (UTC)
Message-ID: <loom.20090821T053954-649@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 05:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeL6I-0001vz-63
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 05:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbZHUDr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 23:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbZHUDr3
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 23:47:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:49095 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288AbZHUDr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 23:47:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MeL69-0001u5-Q1
	for git@vger.kernel.org; Fri, 21 Aug 2009 05:47:30 +0200
Received: from 125-239-18-92.jetstream.xtra.co.nz ([125.239.18.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 05:47:29 +0200
Received: from seba.illingworth by 125-239-18-92.jetstream.xtra.co.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 05:47:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.239.18.92 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126670>

I came up with the following 'git-diffall' script to open all diff files
immediately, rather than default behavior of opening them one at a 
time in serial.

    for name in $(git diff --name-only $1); do git difftool $1 $name & done

I blogged the details at 
http://blog.codefarm.co.nz/2009/08/git-diff-and-difftool-open-all-files.html

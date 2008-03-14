From: Sergei Organov <osv@javad.com>
Subject: The meaning of x~0 and x~ as rev-spec.
Date: Fri, 14 Mar 2008 16:20:30 +0300
Message-ID: <87bq5ho31d.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 14:21:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja9qa-0004mC-KD
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYCNNUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYCNNUj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:20:39 -0400
Received: from javad.com ([216.122.176.236]:4381 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbYCNNUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:20:39 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m2EDKbV76393
	for <git@vger.kernel.org>; Fri, 14 Mar 2008 13:20:37 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Ja9pm-0002fn-8U
	for git@vger.kernel.org; Fri, 14 Mar 2008 16:20:30 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77221>

Hello,

Testing suggests that <name>~0 and <name>~ are the same and are just
synonyms for <name> as rev-specs. Is that correct? Is that by design, or
by accident?

Shouldn't <name>~0 have [the same] special meaning as <name>^0?

Shouldn't <name>~ be a short-cut for <name>~1, similar to <name>^?

Anyway, I think that at least <name>~0 (useful for scripting) should be
explicitly documented, provided that <name>^0 has special (and
documented) meaning.

[
The question arose when I wanted to write something like this to
automate reverting of a few last revisions:

  for i in 0 1 2 3; do
      git revert -n HEAD~$i
  done
  git commit -a
]
 
-- Sergei.

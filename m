From: Mike Hommey <mh@glandium.org>
Subject: git rebase -i slow for a reason ?
Date: Tue, 13 Apr 2010 12:04:35 +0200
Message-ID: <20100413100435.GA7441@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 12:04:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1cz8-0006sr-6T
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 12:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab0DMKEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 06:04:40 -0400
Received: from vuizook.err.no ([85.19.221.46]:59154 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab0DMKEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 06:04:40 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1O1cyx-0005QS-V0
	for git@vger.kernel.org; Tue, 13 Apr 2010 12:04:38 +0200
Received: from mh by glandium.org with local (Exim 4.71)
	(envelope-from <mh@glandium.org>)
	id 1O1cyx-0002Mj-8L
	for git@vger.kernel.org; Tue, 13 Apr 2010 12:04:35 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144805>

Hi,

Most of the time, I run git rebase with -i, so while it is slow, I
always assumed there was somehow a reason.

For some reason, today, I was running some git rebase without -i, and
then the same rebases with -i, but without changing the pick list. While
the git rebase without -i were almost instant, git rebase -i was as slow
as usual, which is very far from instant.

Has anyone else seen such behaviour ?

Mike

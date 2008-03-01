From: Mike Hommey <mh@glandium.org>
Subject: [RFC] git rebase -s ours
Date: Sat, 1 Mar 2008 12:17:16 +0100
Organization: glandium.org
Message-ID: <20080301111716.GA3263@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 12:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVPff-0007QD-RU
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 12:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbYCALNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 06:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbYCALNv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 06:13:51 -0500
Received: from vuizook.err.no ([194.24.252.247]:45009 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237AbYCALNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 06:13:50 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVPev-0007ZZ-FZ
	for git@vger.kernel.org; Sat, 01 Mar 2008 12:13:49 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVPiO-0000sQ-TO
	for git@vger.kernel.org; Sat, 01 Mar 2008 12:17:16 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75658>

Hi,

What do you think git rebase -s ours should be considering as "ours"?
If I'm not mistaken, at the moment, "ours" stands for "upstream", which
is kind of confusing...

Mike

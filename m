From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] t3407-rebase-abort.sh: Enhance existing tests, and add
	test for rebase --merge
Date: Sat, 1 Mar 2008 12:14:14 +0100
Organization: glandium.org
Message-ID: <20080301111414.GA3112@glandium.org>
References: <mh@glandium.org> <1204369933-3040-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 01 12:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVPcl-0006j0-Lx
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 12:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbYCALKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 06:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbYCALKv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 06:10:51 -0500
Received: from vuizook.err.no ([194.24.252.247]:45003 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbYCALKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 06:10:50 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVPby-0007ZG-Qb; Sat, 01 Mar 2008 12:10:45 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVPfS-0000pV-3J; Sat, 01 Mar 2008 12:14:14 +0100
Content-Disposition: inline
In-Reply-To: <1204369933-3040-1-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75657>

On Sat, Mar 01, 2008 at 12:12:13PM +0100, Mike Hommey wrote:
> Removing .dotest should actually not be needed, so just test the directory
> don't exist after --abort, but exists after starting the rebase.
> 
> Also, execute the same tests with rebase --merge, which uses a different code
> path.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>

Should have been as a reply to
1204367534-28204-1-git-send-email-mh@glandium.org. Bad copy/paste...
Anyways, this is against your (Junio's) changes.

Mike

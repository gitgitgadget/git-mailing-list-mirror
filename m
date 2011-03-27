From: Mike Hommey <mh@glandium.org>
Subject: remote-helpers and refs without a value
Date: Sun, 27 Mar 2011 10:24:28 +0200
Message-ID: <20110327082428.GA4428@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 11:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3lvR-0005iP-LK
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 11:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1C0JGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 05:06:06 -0400
Received: from vuizook.err.no ([85.19.221.46]:57012 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab1C0JGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 05:06:05 -0400
X-Greylist: delayed 2491 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Mar 2011 05:06:05 EDT
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mh@glandium.org>)
	id 1Q3lGv-0003v5-Mi
	for git@vger.kernel.org; Sun, 27 Mar 2011 10:24:30 +0200
Received: from mh by glandium.org with local (Exim 4.74)
	(envelope-from <mh@glandium.org>)
	id 1Q3lGu-0001Bk-MY
	for git@vger.kernel.org; Sun, 27 Mar 2011 10:24:28 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: (score 1.4): No, score=1.4 required=5.0 tests=RDNS_DYNAMIC,TO_NO_BRKTS_DYNIP autolearn=disabled version=3.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170077>

Hi,

If I understand correctly how remote helpers work, the values that the
helper returns to the list command is then used to update the remote
branches, or FETCH_HEAD, dependint how the fetch happened.

But when the helper returns a '?' value to the list command, I don't see
how things are supposed to be updated. It looks like the helper is
the only one, then, to be able to update the refs. But it also doesn't
have any way to know which refs it needs to update...

Is it a misunderstanding from my part, or is it something that should be
improved in the remote-helpers support?

Mike

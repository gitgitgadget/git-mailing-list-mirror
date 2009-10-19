From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 07:56:59 +0000 (UTC)
Message-ID: <loom.20091019T094924-194@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzn7y-00038e-GZ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbZJSH53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbZJSH52
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:57:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:57112 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755640AbZJSH5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:57:24 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mzn7M-0002s2-5x
	for git@vger.kernel.org; Mon, 19 Oct 2009 09:57:28 +0200
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 09:57:24 +0200
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 09:57:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.14) Gecko/2009090217 Ubuntu/9.04 (jaunty) Firefox/3.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130670>

Hi,

I have a pack that contains a corrupted object.
It is an old corrupted repo that I have conserved.

As expected, git gc cries out loud about it.
It indicates an inflate error (data stream error with incorrect data check),
and then the impossibility to read an object from a certain offset in the pack.

However, git fsck does not complain at all about the repo.
I guess that for speed reasons, git fsck does not try to inflate the objects.

Is there a means to have fsck to a truly full check on the sanity of a repo?

This both on git 1.6.5.1 and 1.6.4.2.

Thanks

Sergio Callegari

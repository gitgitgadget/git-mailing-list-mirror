From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would
	write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 23:37:42 +0100
Message-ID: <20071211223742.GB19857@steel.home>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DkA-0003DF-TF
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbXLKWhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbXLKWhp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:37:45 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:63238 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbXLKWho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:37:44 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a7Bs=
Received: from tigra.home (Fc89d.f.strato-dslnet.de [195.4.200.157])
	by post.webmailer.de (fruni mo24) (RZmta 14.6)
	with ESMTP id v03660jBBLrWe4 ; Tue, 11 Dec 2007 23:37:42 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3C996277AE;
	Tue, 11 Dec 2007 23:37:42 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 19A5256D22; Tue, 11 Dec 2007 23:37:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67962>

David, Tue, Dec 11, 2007 14:48:32 +0100:
> Though there's still a few things remaining to be implemented, the
> bulk of the initial groundwork is already done.  All you need to
> build/run it is python and pyqt4 (pyuic4).  I've deliberately tried to
> keep the interface similar to git-gui for now since it is obviously
> based on it, but that's not a requirement.

Interesting. I had to start it like this:

	$ export PYTHONPATH=$(pwd)/build/default:$(pwd)/build/default/ui
	$ python ./build/default/bin/ugit.pyc

It has some problem with merges in "Git Commit Browser": takes a lot
of CPU and very slowly generates a very big diff.

The diff view is very ... dark. Out of place, when the rest of the
interface corresponds to system theme (mine is rather light).

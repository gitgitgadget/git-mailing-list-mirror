From: Hannu Koivisto <azure@iki.fi>
Subject: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Tue, 28 Oct 2008 18:28:24 +0200
Organization: NOYB
Message-ID: <83wsfs1y6v.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 17:30:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KurSA-0002ID-7F
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 17:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYJ1Q2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 12:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbYJ1Q2p
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 12:28:45 -0400
Received: from main.gmane.org ([80.91.229.2]:52195 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbYJ1Q2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 12:28:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KurQr-0002HE-EW
	for git@vger.kernel.org; Tue, 28 Oct 2008 16:28:37 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 16:28:37 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 16:28:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:wefPnL+GCllPW0YGQKO6iY9nwPQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99304>

Greetings,

git bisect view uses gitk if DISPLAY environment variable is set
and git log otherwise.  Since gitk doesn't require X server in
Cygwin, that seems like a bit questionable condition in that
environment.

I'd prefer it to use gitk unless an option given.  I think an
option would be preferable (to DISPLAY= git bisect view) in Unix as
well if you have DISPLAY set but you want it to use git log.

-- 
Hannu

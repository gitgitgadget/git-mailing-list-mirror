From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: lstat() call in rev-parse.c
Date: Wed, 26 Apr 2006 17:28:57 +0200
Message-ID: <E1FYlwn-0005mf-CL@moooo.ath.cx>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 26 17:29:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYlwz-0004or-Fs
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 17:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWDZP3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 11:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWDZP3D
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 11:29:03 -0400
Received: from moooo.ath.cx ([85.116.203.178]:34243 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932211AbWDZP3B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 11:29:01 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19208>

> So the rule is: if you don't give that "--", then we have to be able to 
> confirm that the filenames are really files. Not a misspelled revision 
> name, or a revision name that was correctly spelled, but for the wrong 
> project, because you were in the wrong subdirectory ;)

Shouldn't git rev-parse try to stat the file (additionally?) in the
current directory instead of the top git directory? git (diff|log|..)
seem to fail everytime in a subdirectory without --.

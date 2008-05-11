From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 18:39:54 +0300
Message-ID: <20080511153954.GA8129@mithlond.arda.local>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet> <4826EEDF.4010404@gmail.com> <20080511132752.GA22778@atjola.homenet> <4826F72D.2070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 17:40:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvDfM-0003aZ-Ui
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 17:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYEKPj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 11:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYEKPj7
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 11:39:59 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:44012 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbYEKPj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 11:39:58 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 48232FF0001DF1D4; Sun, 11 May 2008 18:39:55 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvDeU-0002li-6W; Sun, 11 May 2008 18:39:54 +0300
Content-Disposition: inline
In-Reply-To: <4826F72D.2070205@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81779>

Dima Kagan wrote (2008-05-11 16:39 +0300):

> My proposed change shouldn't necessarily break the described workflow.
> Git can keep the current behavior for new branches, but automatically
> 'stash' the changes when checking-out an existing branch. At least
> having an optional parameter for "auto-stashing" will be nice.
> 
> What do you think of that?

With the fact that Git's branches are just pointers to a commit (and
therefore to a history) and that you can checkout anything that refers
to a commit (branches, tags, SHA1's, relative pointers like
HEAD@{30.minutes.ago}^2~3) I think such auto-stashing would be make
things pretty complicated and unintuitive in the big picture. The user
interface remains simpler if we just learn to use "git stash" to
temporarily put away changes in the index and the working directory when
we need to.

From: linux@horizon.com
Subject: Re: [PATCH] git-rev-list --help anywhere
Date: 19 Feb 2006 14:39:40 -0500
Message-ID: <20060219193940.7493.qmail@science.horizon.com>
References: <Pine.LNX.4.63.0602192023270.11855@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: git@vger.kernel.org, junkio@cox.net, linux@horizon.com
X-From: git-owner@vger.kernel.org Sun Feb 19 20:40:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAuPU-0006iF-9X
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 20:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWBSTjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 14:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWBSTjw
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 14:39:52 -0500
Received: from science.horizon.com ([192.35.100.1]:58921 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750797AbWBSTjw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 14:39:52 -0500
Received: (qmail 7494 invoked by uid 1000); 19 Feb 2006 14:39:41 -0500
To: Johannes.Schindelin@gmx.de, raa.lkml@gmail.com
In-Reply-To: <Pine.LNX.4.63.0602192023270.11855@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16446>

> can someone please enlighten me why you need to see the usage, when you 
> cannot execute the command anyway?

Because you're writing a script, or explaining it to someone over
the phone, or writing shell autocompletion macros, otherwise using
it in some kind of delayed or deferred way.

These ain't no steenkin GUI tools; they can be used in more ways
that typed interactively for immediate execution.

(Have you ever noticed how all the GUI people have rediscovered the
concept of a pathname and a single-character directory separator when
explaining how to navigate a menu/dialog maze?  The character '>' seems
to be popular.
	Go to menu A
	Then go to submenu B
	Then select item C to open a dialog
	Then go to tab D of that dialog.
	Then hit the "Advanced options" button
	Then select tab E of that dialog
	Then select option F
How exactly is this is an improvement over A/B/C/D/Advanced options/E/F?)

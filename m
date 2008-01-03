From: David Brown <git@davidb.org>
Subject: Re: Retroactively change email signature?
Date: Wed, 2 Jan 2008 16:53:09 -0800
Message-ID: <20080103005309.GA6158@old.davidb.org>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com> <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org> <9b3e2dc20801021406h46a73ef3ye0c4613d6472a4b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:54:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAELW-0000Cg-9D
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 01:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbYACAxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 19:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760165AbYACAxM
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 19:53:12 -0500
Received: from mail.davidb.org ([66.93.32.219]:44784 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810AbYACAxL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 19:53:11 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1JAEKb-0001zn-Da; Wed, 02 Jan 2008 16:53:09 -0800
Mail-Followup-To: Stephen Sinclair <radarsat1@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9b3e2dc20801021406h46a73ef3ye0c4613d6472a4b3@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69504>

On Wed, Jan 02, 2008 at 05:06:37PM -0500, Stephen Sinclair wrote:

>For example, I have a clone of this repo on a Linux, Windows, and OS X
>machine, and also another clone for each on my laptop..  git is
>actually turning out to be great for doing all this swapping between
>machines, but it does take a little training to remember to set the
>configuration, since there's no central repo to ask me for my username
>and password before I can commit.

You can set the user.email and user.name globally with 'git config --global
user.email ...' and the likes, but that only works if you use the same ID.

It'd be nice if there was something that could be put in the global
user.email to require each repository to override that.  On one machine, my
password file doesn't have my name in it, and I kind of get this behavior
by default, but it be nice to be able to do it for real.

Anyone have ideas on how this could be done?

Dave

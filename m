From: Tom Koelman <tkoelman@xs4all.nl>
Subject: Can a git repository be initialized with a bundle?
Date: Wed, 13 Feb 2008 09:21:42 +0100
Message-ID: <m3abm56zc9.fsf@assurancetourix.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 09:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCw6-0006lH-Gf
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbYBMIZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 03:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbYBMIZL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:25:11 -0500
Received: from main.gmane.org ([80.91.229.2]:35786 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108AbYBMIZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:25:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JPCvO-0005qf-Qp
	for git@vger.kernel.org; Wed, 13 Feb 2008 08:25:02 +0000
Received: from tosti.xs4all.nl ([80.126.36.191])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 08:25:02 +0000
Received: from tkoelman by tosti.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 08:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: tosti.xs4all.nl
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:FQN7sqVBby/xy2X4huHbDzNxi/o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73754>


Hi,

I got some repository from which I created a bundle like so:

$ git bundle create all.bundle --all

Now I want to recreate this repository somewhere else:

$ mkdir tmp ; cd tmp ; git init
Initialized empty Git repository in .git/
$ git fetch all.bundle
fatal: Couldn't find remote ref HEAD

It doesn't matter whether I try to fetch, pull, or add -f to the command
line, I always get this response.

Am I trying to accomplish something that can't be done or am I doing it
wrong?

I am running git version 1.5.4.1 under Linux.

Regards,
Tom Koelman

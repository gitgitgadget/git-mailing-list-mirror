From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: erratic behavior commit --allow-empty
Date: Sat, 12 Jan 2013 19:30:36 +0100 (CET)
Message-ID: <alpine.LNX.2.01.1301121927350.15558@nerf07.vanv.qr>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com> <506AA51E.9010209@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:31:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu5rD-00046m-47
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 19:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab3ALSaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 13:30:39 -0500
Received: from ares07.inai.de ([5.9.24.206]:53530 "EHLO ares07.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754010Ab3ALSai (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 13:30:38 -0500
Received: by ares07.inai.de (Postfix, from userid 25121)
	id 239BC96A06B8; Sat, 12 Jan 2013 19:30:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ares07.inai.de (Postfix) with ESMTP id EFB6496A068E;
	Sat, 12 Jan 2013 19:30:36 +0100 (CET)
In-Reply-To: <506AA51E.9010209@viscovery.net>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213298>


On Tuesday 2012-10-02 10:26, Johannes Sixt wrote:
>
>Note that git commit -m A --allow-empty *DID* create a commit. Only, that
>it received the same name (SHA1) as the commit you created before it
>because it had the exact same contents (files, parents, author, committer,
>and timestamps). Obviously, your script was executed sufficiently fast
>that the two commits happend in the same second.

What about introducing nanosecond-granular timestamps into Git?

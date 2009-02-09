From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Mon, 09 Feb 2009 16:36:31 -0600
Message-ID: <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabio Augusto Dal Castel <fdcastel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:38:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWelO-0006FY-Qa
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbZBIWgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZBIWgf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:36:35 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36786 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbZBIWgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:36:35 -0500
Received: by mail.nrlssc.navy.mil id n19MaV0S029442; Mon, 9 Feb 2009 16:36:31 -0600
In-Reply-To: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
X-OriginalArrivalTime: 09 Feb 2009 22:36:31.0661 (UTC) FILETIME=[DAF95DD0:01C98B06]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109152>

Fabio Augusto Dal Castel wrote:

> * Stashes expire (already discussed in
> http://thread.gmane.org/gmane.comp.version-control.git/84665 )

Correction: stash expiration is now configurable and does not expire by
            default thanks to Junio.

Not sure if I'd use this snapshot tool, but per-branch stash would
probably be useful.  If stashes were per-branch, then it would probably
be pretty easy to build this snapshot tool on top of it.

-brandon

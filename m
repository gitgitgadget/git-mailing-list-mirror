From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 5 Feb 2008 16:23:21 +0100
Organization: glandium.org
Message-ID: <20080205152320.GA19370@glandium.org>
References: <ve53xwob.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPeO-0007MC-Qw
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYBEPXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYBEPXY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:23:24 -0500
Received: from smtp28.orange.fr ([80.12.242.99]:23367 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbYBEPXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:23:24 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2802.orange.fr (SMTP Server) with ESMTP id A9BEF80000FF
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 16:23:22 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-42-109.w82-124.abo.wanadoo.fr [82.124.6.109])
	by mwinf2802.orange.fr (SMTP Server) with ESMTP id 8CD9180000E1;
	Tue,  5 Feb 2008 16:23:22 +0100 (CET)
X-ME-UUID: 20080205152322576.8CD9180000E1@mwinf2802.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JMPdp-000531-Nv; Tue, 05 Feb 2008 16:23:21 +0100
Content-Disposition: inline
In-Reply-To: <ve53xwob.fsf@blue.sea.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72670>

On Tue, Feb 05, 2008 at 05:14:28PM +0200, Jari Aalto <jari.aalto@cante.net> wrote:
> Change git specific doings into namespace .git*. Define new variable
> WORKDIR, which points to working directory .git-dotest.
> 
Shouldn't this just go in the .git/ directory ?

Mike

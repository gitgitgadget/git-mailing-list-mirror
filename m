From: Naja Melan <najamelan@autistici.org>
Subject: git-bundle behaves unexpected with submodules
Date: Wed, 27 Jun 2012 16:47:42 +0200
Message-ID: <20120627164742.22f3941c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 17:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjtuv-0005M0-Hf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 17:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2F0PMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 11:12:25 -0400
Received: from contumacia.investici.org ([178.255.144.35]:64251 "EHLO
	contumacia.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab2F0PMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 11:12:24 -0400
X-Greylist: delayed 1449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2012 11:12:24 EDT
Received: from [178.255.144.35] (contumacia [178.255.144.35]) (Authenticated sender: oijjjio@autistici.org) by localhost (Postfix) with ESMTPSA id 78D7BE8935
	for <git@vger.kernel.org>; Wed, 27 Jun 2012 14:48:12 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.8.2 contumacia.investici.org 78D7BE8935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
	s=stigmate; t=1340808493;
	bh=gfoG49Ads/lKChKFjFfanj6uEa0CyJcUXALRegR1nvQ=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=qayAYnpKZqAu3abSUHZhg+8jpZBMgWjDWhG18dBPXFFSjLnrQigTzFFPk8NCSKxZB
	 yhuf3hTQhzgWXUzuAEy2vUi2ZrQQsjH2EqOe5158HOVxUpvUqYcyNi1MAlrOL4lTjx
	 aRNxjdlQ+kE7UdZOkcbaHuClNhf0MYJ8RKOiEZm4=
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200725>

I am the author of a script: https://github.com/najamelan/git-backup

I am using git bundle to back up git repositories. In recent versions of git the repository metadata of a submodule are stored in .git/modules of the parent repository.

When git-bundle is ran in a submodule, it creates a bundle of the parent repo, omitting the information from the submodule, thus effectively not backing it up.

Anyone who can shed light on this?

thanx in advance
naja

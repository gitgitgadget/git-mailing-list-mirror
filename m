From: Olaf Hering <olh@suse.de>
Subject: git-bisect broken in 1.2.4
Date: Mon, 1 May 2006 20:10:20 +0200
Message-ID: <20060501181020.GA21263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-From: git-owner@vger.kernel.org Mon May 01 20:10:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Facqq-00061G-J3
	for gcvg-git@gmane.org; Mon, 01 May 2006 20:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWEASKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWEASKX
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 14:10:23 -0400
Received: from mx1.suse.de ([195.135.220.2]:56969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWEASKW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 14:10:22 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id F1734F02F
	for <git@vger.kernel.org>; Mon,  1 May 2006 20:10:20 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19384>


Did SuSE just pick up a bad version of git, 1.2.4?
git-bisect doesnt work correctly in the kernel sources, .git/HEAD doesnt
contain the commit id anymore, but 'ref: refs/heads/bisect'

CONFIG_LOCALVERSION_AUTO depends on the id.

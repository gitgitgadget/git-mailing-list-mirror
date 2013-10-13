From: John Keeping <john@keeping.me.uk>
Subject: Re: Best practices on updating documentation?
Date: Sun, 13 Oct 2013 22:03:04 +0100
Message-ID: <20131013210304.GN27238@serenity.lan>
References: <20131013204240.GD865149@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Oct 13 23:03:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVSot-0007fr-Ni
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 23:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3JMVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 17:03:12 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:54457 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab3JMVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 17:03:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A5F7122C31;
	Sun, 13 Oct 2013 22:03:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aI5NlCCaPJDI; Sun, 13 Oct 2013 22:03:09 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id C166722F1F;
	Sun, 13 Oct 2013 22:03:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20131013204240.GD865149@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236082>

On Sun, Oct 13, 2013 at 08:42:40PM +0000, brian m. carlson wrote:
> If I'm going to be adding an option to a command, should I update the
> documentation in the same commit or in a separate commit?

I would say the same commit, where it can help a reviewer see the code
change in the context of the expected user-facing behaviour.

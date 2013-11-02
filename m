From: John Keeping <john@keeping.me.uk>
Subject: Re: [ANNOUNCE] git reintegrate 0.1; manager of integration branches
Date: Sat, 2 Nov 2013 11:00:28 +0000
Message-ID: <20131102110028.GD24023@serenity.lan>
References: <CAMP44s2cuHnW0cGEBRt2EmG8Wmav4athMLXRCh2cJ2KymeHmmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 12:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcYwd-0006QM-O9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 12:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab3KBLAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 07:00:40 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48066 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab3KBLAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 07:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 69E2319800D;
	Sat,  2 Nov 2013 11:00:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 41TptOGmZYw0; Sat,  2 Nov 2013 11:00:39 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 1C402198007;
	Sat,  2 Nov 2013 11:00:39 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1625F161E484;
	Sat,  2 Nov 2013 11:00:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vaU9p6HeJcxl; Sat,  2 Nov 2013 11:00:34 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D0C71161E512;
	Sat,  2 Nov 2013 11:00:30 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2cuHnW0cGEBRt2EmG8Wmav4athMLXRCh2cJ2KymeHmmg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237240>

On Fri, Nov 01, 2013 at 06:35:39AM -0600, Felipe Contreras wrote:
> One feature that is missing from git-integration is the ability to
> parse existing integration branches.

Nice - I'd never thought of doing this.

> It also has support for "evil merges", so it should be perfectly
> usable for git.git maintenance.

By this, do you mean that you have an ability to squash a fixup into the
merge?  If so, how do you handle this in the status display - I've had a
WIP branch for a while but haven't come up with a satisfactory way of
displaying the status of a fixup.

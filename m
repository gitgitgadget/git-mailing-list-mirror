From: John Keeping <john@keeping.me.uk>
Subject: Re: Proper URI for "svn clone" on a network share (Win32)
Date: Thu, 15 Aug 2013 09:00:58 +0100
Message-ID: <20130815080058.GM2337@serenity.lan>
References: <20130814124933.77b51a04@bigbox.christie.dr>
 <20130814182657.3c03c5df@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 10:01:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9sUg-0007bk-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 10:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760546Ab3HOIBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 04:01:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:38863 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758823Ab3HOIBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 04:01:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 23EF96064F1;
	Thu, 15 Aug 2013 09:01:12 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBJuFD6zCeTc; Thu, 15 Aug 2013 09:01:03 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 77FF660655A;
	Thu, 15 Aug 2013 09:01:00 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130814182657.3c03c5df@bigbox.christie.dr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232337>

On Wed, Aug 14, 2013 at 06:26:57PM -0500, Tim Chase wrote:
> On 2013-08-14 12:49, Tim Chase wrote:
> > If it makes any difference, this is within a cmd.exe shell (with
> > $PATH set appropriately so git is being found).
> 
> Just a follow-up, I tried it within the "bash"ish shell included in
> the git install and got the same error regarding "/tmp/report.tmp".

It seems that report.tmp is something that SVN creates and for some
reason the svn on your system is trying to create it in a Unix style
temporary directory.

What happens if you export TMPDIR=C:/Windows/Temp before running
git-svn?

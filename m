From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Starting 1.5.3 stabilization cycle
Date: Tue, 3 Jul 2007 13:34:06 +0200
Message-ID: <20070703113406.GK12721@planck.djpig.de>
References: <7v8x9yrllv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 13:34:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ge8-00019D-2E
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 13:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbXGCLeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 07:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757434AbXGCLeO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 07:34:14 -0400
Received: from planck.djpig.de ([85.10.192.180]:4495 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756313AbXGCLeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 07:34:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 583D188102;
	Tue,  3 Jul 2007 13:34:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q7xvVhE1kJbd; Tue,  3 Jul 2007 13:34:06 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 6CC1588105; Tue,  3 Jul 2007 13:34:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8x9yrllv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51477>

On Tue, Jul 03, 2007 at 12:29:32AM -0700, Junio C Hamano wrote:
> GIT v1.5.3 Release Notes (draft as of -rc0)
> ========================
> 
> Updates since v1.5.2
> --------------------
> 
> * The commit walkers other than http are officially deprecated
>   (but still supported).
> 
> * The submodule support has Porcelain layer now.
> 
> * An initial interation of Porcelain level superproject support
>   started to take shape.

Should that be "iteration"?

> * Thee are a handful pack-objects changes to help you cope better with
>   repositories with pathologically large blobs in them.

"There"?

> * Updated behavior of existing commands.
> 
>   - "git svn dcommit" retains local merge information.
> 
>   - "git config" to set values also honor type flags like --bool
>     and --int.

"honors"

>   - "git cvsimort" creates lightweight tag; there is not any
>     interesting information we can record in an annotated tag,
>     and the handcrafted ones the old code created was not
>     properly formed anyway.

"lightweight tags"

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/

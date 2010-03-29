From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 2/5] convert: Keep foreign $Id$ on checkout.
Date: Mon, 29 Mar 2010 14:48:36 +0200
Message-ID: <20100329124836.GE22480@cuci.nl>
References: <cover.1269860022.git.grubba@grubba.org>
 <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Henrik Grubbstr??m (Grubba)" <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 14:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEWM-00023W-NT
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 14:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab0C2M4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 08:56:38 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59512 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab0C2M4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 08:56:36 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1B6E05446; Mon, 29 Mar 2010 14:48:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143465>

Henrik Grubbstr??m (Grubba) wrote:
>If there are foreign $Id$ keywords in the repository, they are most
>likely there for a reason. Let's keep them on checkout (which is also
>what the documentation indicates). Foreign $Id$ keywords are now
>recognized by there being multiple space separated fields in $Id:xxxxx$.

>Signed-off-by: Henrik Grubbstr??m <grubba@grubba.org>
>---
>The typical use case is for repositories that have been converted
>from some other VCS, where it is desirable to keep the old identifiers
>around until there's some other reason to alter the file.

Looks good.

Acked-By: Stephen R. van den Berg <srb@cuci.nl>
-- 
Stephen.

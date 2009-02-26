From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Thu, 26 Feb 2009 08:23:31 +0100
Organization: private
Message-ID: <86bpspy83w.fsf@broadpark.no>
References: <cover.1235629933.git.gitster@pobox.com>
 <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:25:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcacE-0005H0-Sf
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 08:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbZBZHXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 02:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbZBZHXi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 02:23:38 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55218 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZBZHXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 02:23:36 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFN00250WJ9WT10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 26 Feb 2009 08:23:33 +0100 (CET)
Received: from localhost ([80.203.106.217]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFN000D4WJ81ZC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 26 Feb 2009 08:23:33 +0100 (CET)
In-reply-to: <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111536>

Junio C Hamano <gitster@pobox.com> writes:

> -
> -	} else { /* Classic exact string match */
> -		/* Yes, I've heard of strstr(), but the thing is *data may
> -		 * not be NUL terminated.  Sue me.
> -		 */
> +	} else {
> +		/* data many not be NUL terminated; we cannot use strstr() */

  spellfix: s/many/may/

  -- kjetil

From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 4/4] doc: Generate a list of valid merge tools
Date: Sun, 27 Jan 2013 22:54:23 +0000
Message-ID: <20130127225423.GW7498@serenity.lan>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-5-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzb7l-0000S1-6V
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab3A0Wyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:54:32 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:57145 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806Ab3A0Wyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:54:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id B5D851FC8A;
	Sun, 27 Jan 2013 22:54:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7xNNksns5qc; Sun, 27 Jan 2013 22:54:30 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 4256F1FC5A;
	Sun, 27 Jan 2013 22:54:30 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 36FB1161E54F;
	Sun, 27 Jan 2013 22:54:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dAYmAZIFz27U; Sun, 27 Jan 2013 22:54:30 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C79E4161E564;
	Sun, 27 Jan 2013 22:54:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359321886-80523-5-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214746>

On Sun, Jan 27, 2013 at 01:24:46PM -0800, David Aguilar wrote:
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -1,5 +1,6 @@
>  #!/bin/sh
>  # git-mergetool--lib is a library for common merge tool functions
> +test -z "$MERGE_TOOLS_DIR" &&
>  MERGE_TOOLS_DIR=$(git --exec-path)/mergetools

The preferred pattern in Git seems to be this:

    : ${MERGE_TOOLS_DIR=$(git --exec-path)/mergetools}


John

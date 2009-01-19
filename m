From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [StGit PATCH] Added basic bash completion script for StGit.
Date: Mon, 19 Jan 2009 18:15:46 -0500
Message-ID: <497509A2.5020101@tedpavlic.com>
References: <1232405879-6188-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "catalin.marinas" <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3Mp-0007ho-UQ
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbZASXPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbZASXPu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:15:50 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:51411 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752530AbZASXPu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 18:15:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4CB9D80D8035;
	Mon, 19 Jan 2009 18:09:56 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v5TERftngs0m; Mon, 19 Jan 2009 18:09:56 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 719DC80D8037;
	Mon, 19 Jan 2009 18:09:55 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <1232405879-6188-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106400>

> +# Use __stg for stg completion and bail out to normal bash completion
> +complete -o bashdefault -o default -F __stg stg 2>/dev/null \
> +    || complete -o default -F __stg stg

Somehow I didn't see the existing

	stgit-completion.bash

in stgit.git. I was looking in stgit.git/contrib, which is where Git 
(and Mercurial) puts its completion script.

So it looks like there's no need for this patch.

Thanks --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

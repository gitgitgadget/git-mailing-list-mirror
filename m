From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [patch] gitignore: warn about pointless syntax
Date: Mon, 9 Jan 2012 14:44:45 +0100
Message-ID: <87vcolrnw2.fsf@thomas.inf.ethz.ch>
References: <alpine.LNX.2.01.1201091233050.28805@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Jan 09 14:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkFWv-0002ZM-OJ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 14:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab2AINot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 08:44:49 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:37709 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab2AINot (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 08:44:49 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 9 Jan
 2012 14:44:45 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 9 Jan
 2012 14:44:46 +0100
In-Reply-To: <alpine.LNX.2.01.1201091233050.28805@frira.zrqbmnf.qr> (Jan
	Engelhardt's message of "Mon, 9 Jan 2012 12:34:12 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188172>

Jan Engelhardt <jengelh@medozas.de> writes:

> parent eac2d83247ea0a265d923518c26873bb12c33778 (v1.7.9-rc0)
> commit b629bde461aeb178b257ab7e0f6c180f69f98cb0
> Author: Jan Engelhardt <jengelh@medozas.de>
> Date:   Mon Jan 9 12:30:07 2012 +0100
>
> gitignore: warn about pointless syntax
[...]
> -- 
> # Created with git-export-patch

Are you the author of this tool?  The format is bogus in so far as it
causes git-am to insert the above lines into the git commit message, as
in:

    $ git am -3 < gitignore-patch.mbox
    Applying: gitignore: warn about pointless syntax
    $ git show
    commit 59bea4d9a1de3b3b9c0139de4298ffd9d9431457
    Author: Jan Engelhardt <jengelh@medozas.de>
    Date:   Mon Jan 9 12:34:12 2012 +0100

        gitignore: warn about pointless syntax
        
        parent eac2d83247ea0a265d923518c26873bb12c33778 (v1.7.9-rc0)
        commit b629bde461aeb178b257ab7e0f6c180f69f98cb0
        Author: Jan Engelhardt <jengelh@medozas.de>
        Date:   Mon Jan 9 12:30:07 2012 +0100
        
        gitignore: warn about pointless syntax
    [...]

So using this tool over format-patch is just a pointless cause of manual
fixup work.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 0/4] implement automatic submodule merge strategy when
 possible
Date: Wed, 07 Jul 2010 01:53:04 +0200
Message-ID: <201007070153.05684.johan@herland.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 01:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWHwx-0003cn-6O
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 01:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab0GFXxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 19:53:10 -0400
Received: from smtp.getmail.no ([84.208.15.66]:56107 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab0GFXxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 19:53:08 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5500BALUCJYY60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 07 Jul 2010 01:53:07 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BD72B1EEF25C_C33C1E3B	for <git@vger.kernel.org>; Tue,
 06 Jul 2010 23:53:07 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A36A61EEC951_C33C1E3F	for <git@vger.kernel.org>; Tue,
 06 Jul 2010 23:53:07 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5500DT6UCJWR30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 07 Jul 2010 01:53:07 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <cover.1278444110.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150420>

On Tuesday 06 July 2010, Heiko Voigt wrote:
> Changes since the previous iteration:
> 
>  * Add missing option --ancestry-path to setup_revisions()
>  * Drop unnecessary caching of submodule refs
>  * Use buf.len instead of NUL-padding for path buffer in
>    git_path_submodule()
>  * Extend the testcases so they will check for the correct suggestion
>    output in case of a failed merge.
>  * cleanup of some comments
> 
> 
> Heiko Voigt (4):
>   add missing && to submodule-merge testcase
>   teach ref iteration module about submodules
>   extent setup_revisions() so it works with submodules
>   implement automatic fast forward merge for submodules

I've quickly looked through the patches, and the general logic seems good. 
There are a few typos and other small issues to fix, though:

Patch #3:

- commit message: s/extent/Extend/ and s/so it works/to work/

Patch #4:

(see separate email)


Thanks for the effort.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

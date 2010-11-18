From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 0/3] Improvements to mergetool-lib
Date: Thu, 18 Nov 2010 11:27:57 +0000
Message-ID: <4CE50DBC.3090409@hashpling.org>
References: <4CE50290.90600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 12:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ2ni-0007PO-Ge
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 12:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab0KRLhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 06:37:07 -0500
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:20662 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750854Ab0KRLhG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 06:37:06 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2010 06:37:06 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEABec5EzUnw4T/2dsb2JhbACiUnG8fYVLBIUS
Received: from outmx04.plus.net ([212.159.14.19])
  by relay.ptn-ipout01.plus.net with ESMTP; 18 Nov 2010 11:27:33 +0000
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx04.plus.net with esmtp (Exim) id 1PJ2eL-0006uI-32; Thu, 18 Nov 2010 11:27:33 +0000
Received: from heisenberg2.hashpling.org ([192.168.76.29])
	by hashpling.plus.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1PJ2eJ-0005dw-Rj; Thu, 18 Nov 2010 11:27:31 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.11) Gecko/20101013 Thunderbird/3.1.5
In-Reply-To: <4CE50290.90600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161664>

On 18/11/2010 10:40, Sebastian Schuberth wrote:
> This small series adds Beyond Compare 3 as a diff / merge tool
> and performs some minor improvements.
>
> Sebastian Schuberth (3):
>    mergetool--lib: Sort tools alphabetically for easier lookup
>    mergetool--lib: Add Beyond Compare 3 as a tool
>    mergetool--lib: Add the proper executable name for ECMerge
>
>   Documentation/git-difftool.txt         |    4 +-
>   Documentation/git-mergetool.txt        |    4 +-
>   Documentation/merge-config.txt         |    8 +-
>   contrib/completion/git-completion.bash |    2 +-
>   git-gui/lib/mergetool.tcl              |  101 +++++++------
>   git-mergetool--lib.sh                  |  243 +++++++++++++++++---------------
>   6 files changed, 195 insertions(+), 167 deletions(-)
>

I'm not an ecmerge or Beyond Compare user. The reordering of tools makes 
for a bit of a messy diff but I think it makes sense.

This series looks good to me. Has it been well tested?

Charles.

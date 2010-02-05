From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 6 Feb 2010 00:17:49 +0100 (CET)
Message-ID: <alpine.LSU.2.01.1002060009430.30204@obet.zrqbmnf.qr>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 00:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXQy-0003Ux-CN
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328Ab0BEXRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:17:51 -0500
Received: from borg.medozas.de ([188.40.89.202]:57160 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757698Ab0BEXRu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:17:50 -0500
Received: by borg.medozas.de (Postfix, from userid 25121)
	id 77E39F0C327A6; Sat,  6 Feb 2010 00:17:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 2215B119CE
	for <git@vger.kernel.org>; Sat,  6 Feb 2010 00:17:49 +0100 (CET)
In-Reply-To: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
User-Agent: Alpine 2.01 (LSU 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139119>

On Saturday 2010-02-06 00:09, Jan Engelhardt wrote:

>What works is (3).
>
>(3)	$ git grep -- -- '->cnt' net/ipv4/netfilter/

No, I spoke too soon. This command will search for --, not ->cnt.
So git cannot search for patterns starting with a dash at all,
as I see it. This is getting fun..

>As I said, it's a mess. And I know not whether any code can convince
>the "but we need to watch compatibility"-sayers, because this would
>definitely be a flag change.

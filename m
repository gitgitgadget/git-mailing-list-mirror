From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Wed, 11 Feb 2009 09:06:42 -0500
Message-ID: <4992DB72.4080109@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com> <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com> <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com> <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com> <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com> <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Stefan Karpinski <stefan.karpinski@gmail.com>,
	git <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 15:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFlB-0004g4-Uk
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 15:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbZBKOGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbZBKOGu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:06:50 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:42737 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750945AbZBKOGu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 09:06:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BFEBB80D8036;
	Wed, 11 Feb 2009 09:00:19 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12NInu-yAdkr; Wed, 11 Feb 2009 09:00:19 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A691880D8005;
	Wed, 11 Feb 2009 09:00:19 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109417>

> That fixes half the problem.  It no longer leaves a highlight on the
> wrong line, but the newly selected line does not highlight the empty
> space at the end of the line.

I haven't tried the patch yet, but I can tell you that (on my system) 
the other "half" of the problem is there before the patch.

That is, the trailing whitespace on a new line goes without highlight. I 
was under the (wrong?) impression that this was desired and that the 
whitespace highlighting was a bug. No?

(in fact, it might be useful if the trailing "screen space" is *not* 
highlighted. That makes it easy to X-ray trailing whitespace buried in 
the changeset)

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 16:21:06 -0500
Message-ID: <496BB442.90107@tedpavlic.com>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <496BB204.2040109@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUF0-0005ux-Hm
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbZALVVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZALVVI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:21:08 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:39511 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752689AbZALVVH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 16:21:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 50C1280D802E;
	Mon, 12 Jan 2009 16:15:25 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwfnKmrOyHyk; Mon, 12 Jan 2009 16:15:25 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 3A90080D8022;
	Mon, 12 Jan 2009 16:15:25 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <496BB204.2040109@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105383>

> (note: for some reason Mercurial's bash completion script does not have
> this problem; they use $1 directly without bash complaining)

It appears like they use

	complete -o bashdefault

whereas Git's uses

	complete -o default

I think that's the difference.


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

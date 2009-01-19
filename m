From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [StGit PATCH] Added basic bash completion script for StGit.
Date: Mon, 19 Jan 2009 18:35:39 -0500
Message-ID: <49750E4B.3000203@tedpavlic.com>
References: <1232405879-6188-1-git-send-email-ted@tedpavlic.com> <497509A2.5020101@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "catalin.marinas" <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3g5-0004LP-49
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZASXfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZASXfo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:35:44 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:49190 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753394AbZASXfn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 18:35:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 8BAEE80D8038;
	Mon, 19 Jan 2009 18:29:49 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-qEYKa70Fdl; Mon, 19 Jan 2009 18:29:49 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 3EA6580D8035;
	Mon, 19 Jan 2009 18:29:49 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <497509A2.5020101@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106403>

>> +# Use __stg for stg completion and bail out to normal bash completion
>> +complete -o bashdefault -o default -F __stg stg 2>/dev/null \
>> +    || complete -o default -F __stg stg
>
> Somehow I didn't see the existing
>
> 	stgit-completion.bash

I didn't see it because it is generated in the build process. :(

Sorry for the bother --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [StGit PATCH 2/2] Make bash completion fail to bashdefault before
 default completion.
Date: Thu, 22 Jan 2009 11:38:09 -0500
Message-ID: <4978A0F1.9080703@tedpavlic.com>
References: <1232412373-10836-1-git-send-email-ted@tedpavlic.com> <1232412373-10836-2-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "catalin.marinas" <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2af-0003Oh-T2
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbZAVQiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZAVQiN
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:38:13 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:57134 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161AbZAVQiN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 11:38:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 991F680D8045;
	Thu, 22 Jan 2009 11:32:14 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p7KWGdw6KnTj; Thu, 22 Jan 2009 11:32:14 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 80A3A80D8030;
	Thu, 22 Jan 2009 11:32:14 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <1232412373-10836-2-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106761>

>   def install():
> -    return ['complete -o default -F _stg stg']
> +    return ['complete -o bashdefault -o default -F _stg stg 2>/dev/null \\', [
> +            'complete -o default -F _stg stg' ] ]

Oops -- that second "complete" should have two pipes in front of it...


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

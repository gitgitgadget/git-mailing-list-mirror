From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 12:06:44 -0500
Message-ID: <499EE324.4050305@tedpavlic.com>
References: <499EC48B.9070004@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYrP-0004gF-BK
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbZBTRG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbZBTRGz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:06:55 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:33768 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753297AbZBTRGz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 12:06:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 7C75480D8022;
	Fri, 20 Feb 2009 12:00:09 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0uL7wILoV3I; Fri, 20 Feb 2009 12:00:09 -0500 (EST)
Received: from TedBook.local (rrcs-24-123-153-141.central.biz.rr.com [24.123.153.141])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 34E5580D8015;
	Fri, 20 Feb 2009 12:00:09 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <499EC48B.9070004@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110866>

> +		if test "$(git config --bool core.bare)" == "true"; then

As discussed in another thread, to be consistent with local coding 
convention, "test" should be replaced with "[ ... ]".

Additionally, double equality (==) should be replaced with single 
equality (=).

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

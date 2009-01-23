From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: RFC: git diff colorization idea
Date: Fri, 23 Jan 2009 17:28:09 +0900
Message-ID: <20090123172809.6117@nanako3.lavabit.com>
References: <7vhc3q6evi.fsf@gitster.siamese.dyndns.org>
 <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQHS8-0006f7-VK
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbZAWI2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbZAWI2S
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:28:18 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52101 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZAWI2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:28:17 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id E0C33C7B31;
	Fri, 23 Jan 2009 02:28:16 -0600 (CST)
Received: from 8620.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id LZ32EKR8HX4P; Fri, 23 Jan 2009 02:28:16 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=bVawa9dlksd2MeZf6eXmdkeG59ql2QipC24XxY5BB2Rj6VGyAaEGD0HEuVw75OxGOku1L4dr8rd7G97U/itvfN1bojpdVi8yNWJ/MCUlczLCf5YPZoKjliS3faDMRHMoQaY8PybZj6fiwBz5MXZclWVjrGSpRtOJTJgqCmI/O+M=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vhc3q6evi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106857>

Quoting Junio C Hamano <gitster@pobox.com>:

> If you were to go this route, I suspect that showing the unchanged part on
> the preimage line in light gray might make sense, like:
>
>   | _git_remote ()
>   | {
>   |-    <gray>local subcommands="add rm show prune<gray> <red>update</red>"
>   |+    local subcommands="add <green>rename</green> rm show prune"
>   |     local subcommand=$(__git_find_subcommand "$subcommands")"
>   |     if ...
>
> because there will be the same chars/words on the postimage line anyway.

I think this makes a lot more sense than any of the screenshot
WIncent prepared on his web pages, and it is a much easier output
for users to spot which word is different by not coloring the
unchanged word at all.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

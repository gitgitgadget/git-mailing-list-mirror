From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: Quick command to count commits
Date: Tue, 06 Jan 2009 14:55:23 -0500
Message-ID: <4963B72B.8090406@tedpavlic.com>
References: <1231267896595-2118851.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKI2l-0003sR-AA
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZAFTz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbZAFTz2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:55:28 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:34150 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961AbZAFTz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 14:55:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BB00080D803E;
	Tue,  6 Jan 2009 14:49:54 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0U9RINa+ZN8N; Tue,  6 Jan 2009 14:49:54 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.166.97])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 9F6CD80D803B;
	Tue,  6 Jan 2009 14:49:54 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <1231267896595-2118851.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104715>

I doubt it's going to be much faster, but it's easier to type

	git shortlog -s|numsum

I *think* that should give you the same number, and it forces git to do 
more of the counting (rather than wc).

Strangely, on one repo that I test that on, I get slightly different 
numbers from that command and yours. I'm not quite sure why (I guess 
shortlog doesn't count all commits?).

--Ted

On 1/6/09 1:51 PM, Henk wrote:
>
> Hi,
>
> For GitExtensions (windows git ui) I need a command to count all commits. I
> now use this command:
> git.cmd rev-list --all --abbrev-commit | wc -l
>
> This works perfect but its very slow in big repositories. Is there a faster
> way to count the commits?
>
> Henk

-- 
Ted Pavlic <ted@tedpavlic.com>

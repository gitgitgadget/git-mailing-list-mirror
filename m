From: Eric Stegemoller <estegemoller@idmcomp.com>
Subject: Re: External Diff Tool
Date: Thu, 30 Jul 2009 15:22:25 -0400
Message-ID: <4A71F2F1.4060605@idmcomp.com>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 21:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWbD5-0000RS-Tf
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 21:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbZG3TW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZG3TW2
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 15:22:28 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:48743 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZG3TW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 15:22:27 -0400
Received: from relay2.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id D3E62E2103E;
	Thu, 30 Jul 2009 15:22:27 -0400 (EDT)
Received: by relay2.relay.dfw.mlsrvr.com (Authenticated sender: estegemoller-AT-idmcomp.com) with ESMTPSA id 73E15E2049E;
	Thu, 30 Jul 2009 15:22:27 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124478>

Bert Wesarg wrote:
> On Wed, Jul 29, 2009 at 22:16, Eric Stegemoller<estegemoller@idmcomp.com> wrote:
>   
>> Hello,
>>
>>  git config --global diff.tool TestTool
>>  git config --global difftool.TestTool.cmd ""c:/TestTool/test.exe" "$LOCAL"
>>     
> Try with quoting the " inside the config value:
>
>   git config --global difftool.TestTool.cmd "\"c:/TestTool/test.exe\"
> \"$LOCAL\" \"$REMOTE\""
>   
> Bert
>   
Thanks, but this did not solve it. Interestingly, I have captured the 
command line that is sent out by GIT and it is calling the correct 
program but not adding anything to the command line. So, nothing is 
there. Seeing this I have been experimenting around with the parameters 
and I still it is calling the correct program but sending a blank 
command line. Any suggestions on how to pursue this?

Eric

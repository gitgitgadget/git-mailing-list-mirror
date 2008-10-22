From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git history and file moves
Date: Wed, 22 Oct 2008 14:38:51 +0200
Message-ID: <48FF1EDB.8010503@drmicha.warpmail.net>
References: <1224640967.14280.0.camel@minggr.sh.intel.com> <81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Moore, Robert" <robert.moore@intel.com>
To: Lin Ming <ming.m.lin@intel.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 14:40:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksd0V-0000SF-VN
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 14:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbYJVMi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 08:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbYJVMi4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 08:38:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55120 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451AbYJVMiz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 08:38:55 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9DB9A182301;
	Wed, 22 Oct 2008 08:38:54 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 22 Oct 2008 08:38:54 -0400
X-Sasl-enc: R7nUloGJ/DJyrhrL2U6HFfQtGJak96e86aDnPp6rtUXl 1224679134
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AF4032EE50;
	Wed, 22 Oct 2008 08:38:53 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98860>

Alex Riesen venit, vidit, dixit 10/22/08 13:19:
> 2008/10/22 Lin Ming <ming.m.lin@intel.com>:
>> I'm looking for a way to move files to a new directory and have the
>> full history follow the file automatically. Is this possible?
>>
>> I know about --follow, but I want the history to just follow the file
>> transparently. ...
> 
> Of all Git tools, what does not do this "transparently" or "automatically"?
> How more transparent do you imagine this?
> What do you think should follow what?
> 
> I ask, because it is hard to understand what exactly is it you're missing:
> merge support (which we have), git log listing the files as copied/renamed
> (which is what --follow is for, and the suggestion for you is to make an
> alias or something), git blame (ever looked at git gui blame?) or gitk
> (which follows renames in default configuration)
> 
>> Also, we have a git web interface and we want the full
>> history for the moved files to be available.
> 
> It is available. Whether it is shown is another question. git-web can
> be improved (or just configured?)

By default, gitweb uses "-M" for diff. You can specify all options (-C,
-CC, -B) using  "@diff_opts" in the config file for gitweb.cgi - if that
is what you are using. Is it?

Anyways, using default configs for git log and gitweb.cgi both of them
show the full history (renames, history before and after) for me here,
using current git (1.6.0.3.514.g2f91b). What is your setup?

Michael

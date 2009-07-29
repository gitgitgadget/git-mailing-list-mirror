From: Eric Stegemoller <estegemoller@idmcomp.com>
Subject: External Diff Tool
Date: Wed, 29 Jul 2009 16:16:31 -0400
Message-ID: <4A70AE1F.7070004@idmcomp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 22:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWFk4-0003r2-2C
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 22:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbZG2U1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbZG2U1F
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 16:27:05 -0400
Received: from smtp132.dfw.emailsrvr.com ([67.192.241.132]:58866 "EHLO
	smtp132.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbZG2U1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 16:27:04 -0400
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 16:27:04 EDT
Received: from relay3.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 047855D8328
	for <git@vger.kernel.org>; Wed, 29 Jul 2009 16:16:32 -0400 (EDT)
Received: by relay3.relay.dfw.mlsrvr.com (Authenticated sender: estegemoller-AT-idmcomp.com) with ESMTPSA id D66455D8291
	for <git@vger.kernel.org>; Wed, 29 Jul 2009 16:16:31 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124384>

Hello,

First off I am using Git for windows. I am trying to configure git to 
use an external diff tool. I am nearly there. I have it launching the 
correct program when "git difftool testfile.txt" is invoked. However, it 
appears the file paths are not being passed. I suspect I may not be 
using the $LOCAL and $REMOTE variables correctly. Below is how I have 
configured things thus far. Any help or suggestions would be greatly 
appreciated.

  git config --global diff.tool TestTool
  git config --global difftool.TestTool.cmd ""c:/TestTool/test.exe" 
"$LOCAL" "$REMOTE""
  git config --global difftool.prompt false

Thanks,
Eric

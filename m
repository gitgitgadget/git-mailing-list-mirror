From: Gerd Knops <gerti-git@bitart.com>
Subject: Whitespace options
Date: Thu, 2 Apr 2009 14:18:19 -0500
Message-ID: <3C72F4A7-9B7A-44D0-B13D-FD534EB02C27@bitart.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 21:27:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpSZc-0003gi-78
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 21:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407AbZDBTZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 15:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbZDBTZy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 15:25:54 -0400
Received: from mail.bitart.com ([75.146.45.42]:49771 "EHLO
	mail.summitsite.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbZDBTZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 15:25:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2009 15:25:53 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.summitsite.info (Postfix) with ESMTP id 02DEA2220334
	for <git@vger.kernel.org>; Thu,  2 Apr 2009 14:18:40 -0500 (CDT)
X-Virus-Scanned: Debian amavisd-new at localhost
Received: from mail.summitsite.info ([127.0.0.1])
	by localhost (summitsite.summitsite.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRQyDtV9e7ze for <git@vger.kernel.org>;
	Thu,  2 Apr 2009 14:18:38 -0500 (CDT)
Received: from [192.168.42.242] (unknown [75.146.45.44])
	by mail.summitsite.info (Postfix) with ESMTPA id 40FA4222017C
	for <git@vger.kernel.org>; Thu,  2 Apr 2009 14:18:38 -0500 (CDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115488>

Hi all,

I think there should be a whitespace option that ignores lines that  
consists completely of whitespace vs lines with actual trailing  
whitespace preceded by non-whitespace.

The reason is that many editors (especially those supporting indent- 
based code folding) keep 'empty' lines at the current indentation  
level. git (with default settings) flags all those lines.

I know I could just remove 'trailing-space' from 'core.whitespace',  
but I would actually still like be notified about the case where a  
line that is not whitespace only ends with trailing whitespace.

Thanks

Gerd

From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: svn to git with non-standard layout
Date: Wed, 23 Nov 2011 22:19:23 +0100
Message-ID: <op.v5e36lxp0aolir@keputer.lokaal>
References: <jajh7m$it7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	"Bernd Schubert" <bernd.schubert@itwm.fraunhofer.de>
X-From: git-owner@vger.kernel.org Wed Nov 23 22:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKE8-00031I-QF
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 22:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab1KWVT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 16:19:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37936 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab1KWVT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 16:19:27 -0500
Received: by faas1 with SMTP id s1so858507faa.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=t53+SlwqXbYvgjTBcoPWFxS+VrQOBmJWFWIivU+/8/k=;
        b=NYl3JLpWksPJxMl0NC9GYebQ8vn+i9fXV/jrC0XCQ/pvaq8wrQhJObJSXzWMAu04NK
         NqK/hqWYGDxc8sYhRPioUpdV5OD4MOnJkyMd4aTc+ubIQEs2/yDfmAPbXluFjQpN4sva
         IjewwCcMXjOSGOGge07AikO6Ce9SVWRAeO1VM=
Received: by 10.180.106.3 with SMTP id gq3mr25368210wib.34.1322083164845;
        Wed, 23 Nov 2011 13:19:24 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id gf10sm8645998wib.2.2011.11.23.13.19.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 13:19:24 -0800 (PST)
In-Reply-To: <jajh7m$it7$1@dough.gmane.org>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185875>

On Wed, 23 Nov 2011 20:23:34 +0100, Bernd Schubert  
<bernd.schubert@itwm.fraunhofer.de> wrote:

> we just want to migrate from subversion to git, but so far all attempts  
> to do that resulted in missing commit information.

What are all attempts? Did you try only git-svn, or did you try tools like  
svn2git?


> Any ideas what I still could try to do?

If you haven't tried anything other than git-svn, try svneverever &  
svn2git[1] for an actual repository conversion. Or have a look at the  
newest kid on the block called SubGit[2][3]. In both I don't have any  
experience, but of svn2git I know Qt and KDE have used it successfully to  
convert their repositories.

I assume both are somewhat more complex to use and set up than to simply  
use git-svn, but I guess it will be worth the effort.

Good luck,
Frans

[1] http://techbase.kde.org/Projects/MoveToGit/UsingSvn2Git
[2] http://subgit.com/
[3] http://thread.gmane.org/gmane.comp.version-control.git/185806

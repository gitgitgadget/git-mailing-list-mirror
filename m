From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Incremental CVS update
Date: Thu, 22 Jun 2006 08:26:59 -0400
Message-ID: <9e4733910606220526o14ebe76ala4d327f012a0e8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 22 14:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtOH3-0004YU-Ag
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 14:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWFVM1B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 08:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWFVM1B
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 08:27:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:1834 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751324AbWFVM1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 08:27:00 -0400
Received: by nz-out-0102.google.com with SMTP id l1so438564nzf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 05:27:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PdTt62ExBWl8xDgBoVXKIWDQ5SueNlD3hX5Iylm0I980EfuHX+fROBF43zJJy6uuGD7cg5l1A7xB+QXVOh4wAsDoO/xoroVSMWUOZD+yLN5H1UaoTYnheQa1Bsnc2etG0Iawey0DMAyOQard+FoZOAa5NoL2xbaNSAKqcpLkQZ0=
Received: by 10.36.247.57 with SMTP id u57mr1897084nzh;
        Thu, 22 Jun 2006 05:26:59 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Thu, 22 Jun 2006 05:26:59 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>, git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22324>

cvsps keeps it's incremental status in ~/.cvps/*. parsecvs might want
to keep it's status in the .git repository and use tags to locate it.
You could even have a utility to show when and what was imported. By
keeping everything in git it doesn't matter who runs the incremental
update commands.

-- 
Jon Smirl
jonsmirl@gmail.com

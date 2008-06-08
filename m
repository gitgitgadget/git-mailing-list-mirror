From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: git local repo export
Date: Sun, 8 Jun 2008 17:46:01 +0400
Message-ID: <20080608134601.GA7020@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 15:48:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5LFX-0008RV-RZ
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 15:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbYFHNqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 09:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYFHNqh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 09:46:37 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:29373 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbYFHNqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 09:46:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so414277and.103
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=uHqYL5SfF3Po67esBdvXp/uotK9gMuA+mjLPKzdxG8c=;
        b=MU6fP3tzNySn0tE5flZt2H26KwSusi3BxUvAprOHjTHKvx+MvozRPiGxX52dSaxzBV
         7UiD4vr9MavItPORVobAtbzGCFZ7Sb06acyzwViP3IOG2kP0fn65O1I9zcUbrzX4uYs+
         V2siJHKR5+sj+z3CBJwv4roattQtdlXIir0I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Kgj1hGVgrOJWkhIznqNuT/mW253Yu8hEX1lH6vDm6fF/s0Amt4x8vcaUzZIhk7z7tj
         rr1oOKA+n2J+A3iJu2BPcJY9AsfKNMfKQuR9rKi8z94FkVrtAYnVFs3G2U9JqxbFZIyU
         8JkEOf3+I34s4aXiR4KDawJpfrBPwkpSvJ8NY=
Received: by 10.100.122.12 with SMTP id u12mr1295860anc.109.1212932774514;
        Sun, 08 Jun 2008 06:46:14 -0700 (PDT)
Received: from gorcunov ( [78.37.199.118])
        by mx.google.com with ESMTPS id d21sm16984094and.0.2008.06.08.06.46.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 06:46:14 -0700 (PDT)
Received: by gorcunov (Postfix, from userid 1000)
	id 441FE4C3; Sun,  8 Jun 2008 17:46:01 +0400 (MSD)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84266>

Hi,

could someone say me if there is a way to pack git repo in a single file somehow?
I mean - sometime I have to move _whole_ git database by some media without net
access so I can't fetch it. Usually I just create tar.gz for .git directory and
copy it to some media then unpack it in place where I need. But maybe there is
some other more elegant way exist to do the same?

Thanks in advace, please CC me since I'm not subscribed to git list.

		- Cyrill -

From: Marcelo de Moraes Serpa <celoserpa@gmail.com>
Subject: Spreading .gitignore rules to svn:ignore and keeping them in sync
Date: Fri, 29 May 2009 18:23:37 -0500
Message-ID: <1e5bcefd0905291623v6d90d9acv92bdaa05b0e72ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 01:23:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MABQW-00086w-Lm
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 01:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZE2XXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 19:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbZE2XXh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 19:23:37 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:30297 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZE2XXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 19:23:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so13019033and.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=WgJfqE/35/9LwcErUWJLuaGmG5n42QYDLC1B+hBH7SI=;
        b=pcO6WG46FZKud0pYRwBC2SoRg+dURU1enVXlR0BdlUUoOBbvthj6H3Dq0k6ksTmZgk
         BgvdwAnAB80NcmpQVhv9m7BGw3j6JQztjOByF9Pv7skZS9sZJLt4DGt1t51mJptZ0Uui
         fxQoI+9HXELD3sGrpqP1zU+M8reddgSPODyno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=WWmdDDAHW8Otmoxhh7ILP2t+nSVw0mHIQ7pNUM+dIFDJu/R64ASv+87sDEJNl0Ze47
         gxRtfzp05AMFhn6Jrw+XEG4gSBRU30ntr21WhVdAtYqaPsvOeApHndTMt7A+t40qRHYu
         uQQNaUlwVM3pr6xKnFvFAZa7HapB4RL5rhSFM=
Received: by 10.100.45.13 with SMTP id s13mr2021504ans.193.1243639417821; Fri, 
	29 May 2009 16:23:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120325>

Hello list,

I'm working on a project that is using svn as it's
vesion-tracking/control technology. I'm the only rebel and I'm using
git-svn to interact with this svn repo :)

I need to make the version control system ignore a specific file and
spread this ignore rule across all developers. Now, if everyone was
using git, this would be a simple solution -- just create a .gitignore
file in the root of the working tree and commit it. The thing is, all
other developers are using svn, and I'm not sure how I could put this
entry into svn:ignore for them and also make my .gitignore synced with
svn:ignore.

Any ideas?

Thanks in advance,

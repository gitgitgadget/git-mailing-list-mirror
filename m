From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: cleaning up after using git branch delete commands
Date: Wed, 7 Nov 2007 09:06:44 -0500
Message-ID: <9e4733910711070606t2c558ac9ob4c729d5baca8fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IplYc-0006aw-Tz
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbXKGOGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757086AbXKGOGq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:06:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:62159 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650AbXKGOGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:06:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2817282wah
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 06:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xGo+5CH7yiyMhvbWjE6WgJ4iKuoXZ75W3cYxeoOKD3I=;
        b=nxQdfD3ABk0MqRG0dAVgS056P5wdtCkzMB1hBj45zw0tIep/azBrqE6qdPW4ku5Wklh9OxuM6bCqekQpBhOj9Iwnd2IF55gDT4D/FkM2TiYNdLQqyntZL7yNUNuWv2SRRoDsPvOIBcQFGRqZouNsGEMKWgi+xiAX04GHUclsigU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UqjIh1JrIq8Ur/loUdFSbw8b0qqXqCkV+1Inwea+U19fItrwQhbTsxkJIVgnyNRCC7h2C4slxW04btWadmRjeVRH3MvZPoeABZ6PVlTj8uCWvIclMAekum8xve9Ic8WT4lfEvGzdXIgYjaSNf01o2AQkV42vILeYyOSUe3Jijlk=
Received: by 10.114.148.1 with SMTP id v1mr7558951wad.1194444404734;
        Wed, 07 Nov 2007 06:06:44 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 06:06:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63807>

I've used git commands to delete several branches that had stgit
active on it.  Doing that has left a bunch of clutter in the .git
directory. Is there a stgit command to remove all the clutter from
branches that no longer exist? I'd like to use the branch names again
but the clutter is interfering.

-- 
Jon Smirl
jonsmirl@gmail.com

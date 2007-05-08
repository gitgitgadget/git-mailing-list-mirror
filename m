From: Dana How <danahow@gmail.com>
Subject: [PATCH 0/4] git-repack --max-pack-size
Date: Tue, 08 May 2007 13:01:17 -0700
Message-ID: <4640D70D.9030605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVt9-0005FF-U2
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031804AbXEHUBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031879AbXEHUBa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:01:30 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:7046 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031804AbXEHUBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:01:24 -0400
Received: by py-out-1112.google.com with SMTP id a29so1581131pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 13:01:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=TW2F2XgZRWNU/Q50BSykzUOo7Sr1hEnDbyukZSv0rnhBgy4F/n8SHesB2hjzWlDYbzlGJAuORuX7ujvA9s1wTVFCbdB9dhYffhOEdk/mrmff9tRYiCbcCNlQtRM16t34D9PykedAj7FbxVHLKVHeIgLyoVYBw7K5BV+fgtkZKRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EFWrx0Ew4Za7PotnHyk/XsOeP7hT61odSWhlbTfZ8YzT6HIt/8stcStU86crLsLmPWuznPrdknBEZH6jNlSNG/AtwoIKekHWDk+ZAhKHiqbIffvpOMgX2aguRSETtjn31eLx8ViwS1jPnp4EgJIPtzZQDzNufKVoARswvyx8XlI=
Received: by 10.35.98.3 with SMTP id a3mr13860553pym.1178654481372;
        Tue, 08 May 2007 13:01:21 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id f77sm13638210pyh.2007.05.08.13.01.18;
        Tue, 08 May 2007 13:01:20 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46612>


This patchset adds git-fast-import's "--max-pack-size=N"
option,  with the same behavior,  to git-repack.

This latest patchset includes the following new updates:
* sha1close() changes split out as an earlier patch;
* rebased on top of recent changes to pack-objects;
* fixed delta reuse _reporting_ buglet when deltas split;
* temporary packfiles built in GIT_OBJECT_DIRECTORY not GIT_DIR;
* updated documentation.

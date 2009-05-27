From: guo tang <tangguo77@gmail.com>
Subject: msysgit git log slow performance
Date: Wed, 27 May 2009 08:43:39 -0700
Message-ID: <4120f6ec0905270843u225d6b3bt701c1817d68b4648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 17:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9LIU-0006a0-O1
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 17:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762503AbZE0Pnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 11:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762388AbZE0Pnk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 11:43:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:12757 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762419AbZE0Pnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 11:43:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2660895yxj.1
        for <git@vger.kernel.org>; Wed, 27 May 2009 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=2e++2opLNvc/TWQNyyL0sikznUXTme+yiz5VQDPH81s=;
        b=saGq3wYAuq3dp6udLoLOIvATmp6vhd8Ht8n72AZ2cYpFX58Wfjf4B6bW7mMGSpdS7C
         HlR/D9xGZLiCwgecLQyElrhpvjksmC9rcZK04RJeLmB0BeNu8PTPjrS21vz4LsyOImW8
         hbJ0FJpeLTNhithPapNvMp/AsI1B0yNWXot6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CPu1I2Rom/YB8Dl3sCz/E6YUz48ckNYiw7QD02R3HzxgRLQvvt64aBFK8qhlgJH1H6
         /JQBqmhJ7zM8PD/dAWh7xfVa1HPvrFbS8+BSaGx1Gl0KXd5n6htuL43xYyCeMV7qInzO
         ML9RBvIB+BlJFk9oesrXQIpKSRAyKoBWYUBZs=
Received: by 10.151.145.20 with SMTP id x20mr426341ybn.274.1243439019895; Wed, 
	27 May 2009 08:43:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120073>

Hi, Gentlemen,

Anyone else has performance problem with msysgit "git log" command? In
one of my XP box,
git log takes about 5 seconds. I did some Google search, one email
thread in this mailing list
says setting "GIT_PAGER=" can solve the problem. I tried it, it really
works. But some other
commands like push is still slow. I am using
http://msysgit.googlecode.com/files/PortableGit-1.6.3-preview20090507.7z
In another XP box, the same msysgit binary, the same "git log" command
is very fast without GIT_PAGER change.
So it might due to some strange XP settings. Anyone has idea?

Thanks,
Guo

From: "Josh Boyer" <jwboyer@gmail.com>
Subject: git-unpack-objects
Date: Mon, 1 May 2006 17:52:44 -0500
Message-ID: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 02 00:53:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FahGy-0004ZU-DM
	for gcvg-git@gmane.org; Tue, 02 May 2006 00:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWEAWwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 18:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEAWwq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 18:52:46 -0400
Received: from uproxy.gmail.com ([66.249.92.173]:3297 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932300AbWEAWwp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 May 2006 18:52:45 -0400
Received: by uproxy.gmail.com with SMTP id h2so1775878ugf
        for <git@vger.kernel.org>; Mon, 01 May 2006 15:52:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sOEKj+Cibmt6Q1uYH1A/odLA0tRIlxxBk/9AeyrlKOzu0kiFCNupT9FfSwTO7smSqjAsNhRX0pC51U6XsERnsxo0Ar2FcHhEMaF0Ailui9V7nT9dEHQViblHLMRAoGMPwihhFYHfexi2+9WltxHSdI+7OHWbw0aCHjguCatjN4Q=
Received: by 10.78.23.16 with SMTP id 16mr587436huw;
        Mon, 01 May 2006 15:52:44 -0700 (PDT)
Received: by 10.78.29.19 with HTTP; Mon, 1 May 2006 15:52:44 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19391>

I was playing around with git repack and decided to "undo" the repack
I did using git-unpack objects.  Below is the output:

[jwboyer@vader linux-2.6]$ git-unpack-objects <
.git/objects/pack/pack-497d1e639572013de48eeb00cb95738d2ca959e1.pack
Unpacking 236950 objects
 100% (236950/236950) done
[jwboyer@vader linux-2.6]$ ls -l .git/objects/
total 8
drwxrwxr-x 2 jwboyer jwboyer 4096 May  1 17:48 info
drwxrwxr-x 2 jwboyer jwboyer 4096 May  1 17:48 pack
[jwboyer@vader linux-2.6]$


As you can see, the objects don't seem to get unpacked back into the
.git directory.  So either I am misunderstanding what that command is
supposed to do, or it isn't working properly.

Any ideas?

thx,
josh

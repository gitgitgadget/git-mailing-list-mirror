From: Matan Nassau <matan.nassau@gmail.com>
Subject: remote rename
Date: Sat, 8 Mar 2014 19:11:01 -0500
Message-ID: <361C9A05-DB96-4786-AEA6-1FEE732613FA@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 01:18:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMRRN-0004zM-Gj
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 01:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbaCIARp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 19:17:45 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:58179 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbaCIART convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2014 19:17:19 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Mar 2014 19:17:19 EST
Received: by mail-qg0-f44.google.com with SMTP id a108so16313322qge.3
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 16:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:content-type:message-id:date:to
         :content-transfer-encoding:mime-version;
        bh=TGqaTrhyTNU+AO23SSwvE+0VIL/dKKrcfx6jBHdZFeE=;
        b=CkJszdxJQdLOKOkNL3k44/IZxmQErUVkNLVq0EBLub/8cgh+pHEdysMahPODES6MeT
         zQnJF3ujrAFWRDjTxRGKNG7BiC9ipPuTsVIhYZXZVR+fPz3MoaCKkDoIlOhYGB4GXKua
         xCZVa/toMmxh3mjbJqXPOb3zf/Aj60BAxXNT3PeBCkEenUUHhKgFiCH4cHnhKN1japYb
         Y2fZYcgSEZK5c4AsLQ54D9a9kPy+cpLwBZviXYuYXze841HMqm740uksmHwwbuAt7a9w
         yefmTfLtVPnjHMu3DJUljjGMFrxRG/FQBYNa/CDdrfvZWaeA1Dz0cFYvU2MjE8kuRgrH
         CRUQ==
X-Received: by 10.229.56.200 with SMTP id z8mr25119242qcg.1.1394323866762;
        Sat, 08 Mar 2014 16:11:06 -0800 (PST)
Received: from [10.0.1.3] (modemcable052.152-83-70.mc.videotron.ca. [70.83.152.52])
        by mx.google.com with ESMTPSA id 73sm19546814qgg.22.2014.03.08.16.11.05
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Mar 2014 16:11:06 -0800 (PST)
X-Mailer: iPod touch Mail (11B651)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243685>

Hi,

If I have a remote branch origin/topic/foo, running

 $ git remote rename origin renamed

seems to leave directory traces behind: .git/refs/remotes/origin/topic

I expected to see .git/refs/remotes/renamed/topic/foo but not .git/refs/remotes/origin. Is this a glitch?

I see this with Git 1.9.0.


Matan
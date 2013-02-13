From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Recommended packing for HTTP repositories
Date: Wed, 13 Feb 2013 13:38:42 +0100
Message-ID: <1360759122.6610.15.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 13:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5bcM-00077V-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 13:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036Ab3BMMix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 07:38:53 -0500
Received: from mail-ea0-f175.google.com ([209.85.215.175]:56782 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab3BMMix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 07:38:53 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so452741eab.20
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 04:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:content-type:x-mailer
         :mime-version:content-transfer-encoding;
        bh=OSNJHZfLMOusq/FBGVHwAE15WI/qSdYbfsQFbYpWDJM=;
        b=Et3x8XvexbCiPee0hxj4Sro/O3DpvzuHHmKUK8V8K2myRfKFxP84xdqY9uPlz798K+
         Gqi5IfFh1v8xb8YFJxOenkXrQMgYCOGjY8wA5W776fXf8XS9Retn9TXilTQz0iBsxMym
         zq4Sez3y5XiHPDuki36Um75hRY/3hkAYE9e15sMwePMpZd1Noaec6K6cmSOkaGn+wFEF
         2ebDLDAZkMCW5AFdXeqOj8wjkg6rDkHKdcTzvUx17rYV4dbMVtTiYHw4VsCpDvc5Oc5d
         SExXKzmRz62nQ6l/z+mVCx1uHAIDDHGh69nEkIuYi+ZUk7XnFByu5dpAd6eg0Iy7Ffl8
         8wqQ==
X-Received: by 10.14.220.135 with SMTP id o7mr59105378eep.3.1360759131562;
        Wed, 13 Feb 2013 04:38:51 -0800 (PST)
Received: from [192.168.42.21] ([46.115.76.23])
        by mx.google.com with ESMTPS id q42sm63682917eem.14.2013.02.13.04.38.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 04:38:50 -0800 (PST)
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216253>

Hello!

I provide dumb HTTP access to a git repository on a server where I can't
enable the smart HTTP protocol. When the history of the repository
grows, should I run git repack to pack all revisions together? Would
that cause clients that just want to download a few commit to download
the whole pack? What is recommended to do?

Yours, Robert Clausecker

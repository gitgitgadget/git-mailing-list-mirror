From: Matthew Cline <matt@nightrealms.com>
Subject: Feature request: Config option for
 --no-ignore-removal/--ignore-removal
Date: Tue, 24 Sep 2013 21:01:31 -0700
Message-ID: <1380081691.7963.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 06:01:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOgIE-0004Dv-VH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 06:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772Ab3IYEBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 00:01:35 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35850 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab3IYEBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 00:01:34 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so5449434pdj.20
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:subject:from:to:date:content-type:mime-version
         :content-transfer-encoding;
        bh=vwJOplNyu2yTlqsh+6ztbRuRh/eOOgwmy1XoIqYEylg=;
        b=KmSMJkarsv3tqPI3TpqRfDZyuQ+9DQUE+ZXzCMrZ1gI6Yxq2r/1wQo/HQrd++PsPLk
         xvhIMAKAEmrKt1DG1DVM+kC5/dpyzGGU/Wux17kkNJGpqPtakh3ke99/9bCMLWIZQFuO
         jkhHVY49I8Ov3jczqcjeYVfK+5jl8PF4vrPLADDX46+q86JNBSzIk1rrhfzGFnOzDpPY
         v8O7S2ZKSUhdvlURXNAukiOyoBS8jC9TkFDDca27FaRdcs6bvhhB8x/tEuFxXyi2apyV
         JGHYvtyNw//qBzkoZyjr6mPHO+myc9sgIkBDaBWfuOAPHv1Xgm8pDNydYHAYFSI0KHpQ
         Py4w==
X-Received: by 10.68.48.166 with SMTP id m6mr30462169pbn.105.1380081694052;
        Tue, 24 Sep 2013 21:01:34 -0700 (PDT)
Received: from ?IPv6:2601:9:400:de:821f:2ff:fe36:d140? ([2601:9:400:de:821f:2ff:fe36:d140])
        by mx.google.com with ESMTPSA id or6sm10758593pbb.36.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 21:01:33 -0700 (PDT)
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235332>

When I try to a plain old "git add ." when files have been
deleted/moved, I get the warning

> You ran 'git add' with neither '-A (--all)' or '--ignore-removal'

There should be some way to put something in ~/.gitconfig to tell git to
always choose one or another.

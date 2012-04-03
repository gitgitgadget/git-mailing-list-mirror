From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Tue, 3 Apr 2012 16:12:19 -0500
Message-ID: <20120403211219.GC19858@burratino>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
 <20120403144505.GE15589@burratino>
 <4F7B650C.9060800@sohovfx.com>
 <20120403210815.GB19858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFB1s-0002ww-GV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab2DCVMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:12:36 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34157 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2DCVMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:12:35 -0400
Received: by obbtb18 with SMTP id tb18so189209obb.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9ewdgpmwGDLy+iR6hsnqroaV/TrBwBwMquG7p4XovS4=;
        b=dBf/vbFG2TgyyOqXuHx2y37wZFRWE6P8WBbp+rlavOLg9NWWusjUCH9RC4rElIhK1h
         WxhoPc9wYIYrGiSR+spKURsen84iZgGVMoydLBaM+RoVXD2U8MKn5lmRWvunMviwU6wP
         ufOyR7+mlE+kZ2BnOriIzGyILfs+z3kbxXUm0fDpMCTTpQlVk18Tyg83c3iBRYUiV1Lg
         kVBYptR2mnG/qtfOpSN0ZPxW2sGaQs5kWHw2YVynmFH3UWhpU0Gm/vKM0R+YoCGtZFUF
         wrTrypDk0unDQiNBlT4RsvneGRsDBMbQoCLGedLVI4BY6P3bwwViWMSw5BeZirJQSANG
         wlqA==
Received: by 10.182.11.100 with SMTP id p4mr21376789obb.63.1333487554936;
        Tue, 03 Apr 2012 14:12:34 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h7sm17940661oeh.9.2012.04.03.14.12.33
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 14:12:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120403210815.GB19858@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194648>

Jonathan Nieder wrote:
> Andrew Wong wrote:

>> Besides the "empty commit" failure, "cherry-pick" can still run into
>> various errors, such as merge conflict.
>
> Cherry-pick does the merge, so it is what notices the merge conflict.
> If you search for CHERRY_PICK_HELP in builtin/revert.c, the relevant
> code should show up.

I was looking at an older git version.  In newer gits, the code path
in question lives at print_advice() in sequencer.c.

Sorry for the noise.
Jonathan

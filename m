From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] environment: enable core.preloadindex by default
Date: Tue, 3 Jun 2014 15:41:58 +0700
Message-ID: <CACsJy8A0EixLPCEO4R_pX2FM35PMJuFPxLw3_axxBUpj-rb18A@mail.gmail.com>
References: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 10:42:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrkIl-0006HP-EY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 10:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbaFCImb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 04:42:31 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:40358 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbaFCIm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 04:42:29 -0400
Received: by mail-qg0-f52.google.com with SMTP id a108so12465593qge.39
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hzDfstoPNf9Ckmf84tIcm+T+7r/luTqIe1zokCCHkk4=;
        b=gjnV15G2D8yFBgLcnBmAM5gPtYmpZvBWE3EKwMhZ1bRc+FM69eqwO2Gbbv65lVd4xP
         UfsKczBr9kyNleea3i97VZS/NG6cRuSrKu76bUaBUco0I4EDrJxzuGCtdvkmgmJ+qVwC
         nzSoZbRNKWa95nPFSQmzbTWaqGsggNS3hA++z5h5/SakXulhhMbNTZftTVBzkD2sVxpm
         B90ICh9kSLoQsgNGCfBhw8nsuzhRof+1d1GBdLeaR/2xA4Zi4m3ih9f0pg7mtMuYkfG6
         EXK70QM+wxVV9cxN9aicR4SOcPjhdIdCWzrxuchQU3awEW3Jj90t7v22kYJOmbu3MA2X
         V7Rw==
X-Received: by 10.140.92.200 with SMTP id b66mr52752971qge.41.1401784948932;
 Tue, 03 Jun 2014 01:42:28 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 3 Jun 2014 01:41:58 -0700 (PDT)
In-Reply-To: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250620>

On Mon, Jun 2, 2014 at 11:43 PM, Steve Hoelzer <shoelzer@gmail.com> wrote:
> There is consensus that the default should change because it will
> benefit nearly all users (some just a little, but some a lot).
> See [1] and replies.
>
> [1]: http://git.661346.n2.nabble.com/git-status-takes-30-seconds-on-Windows-7-Why-tp7580816p7580853.html

Not only Windows. core.preloadindex helps large repos on Linux as well
[2]. So +1.

[2] http://article.gmane.org/gmane.comp.version-control.git/248013
-- 
Duy

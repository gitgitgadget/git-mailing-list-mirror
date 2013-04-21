From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 13:08:00 +0530
Message-ID: <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com> <7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTorK-0002FL-R7
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab3DUHil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:38:41 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40061 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab3DUHik (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:38:40 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so5958473ied.19
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4wOrUcD6B+g7SZs7zpyahG5qbPtHKYx9GKmMWk1d9qE=;
        b=ybFoALjaSTYRvG5HLQnXPDL7cYV5/8NTMgLurWUh0ylXt239pFVYSRky39OBLIbcr+
         R21aqf9jWcGyoAboydl+0Wm8+9qjgC6vYtef9HMK35Fi23QsbkEvu/kSX4A866btxbk9
         KvWpB6Mll/xpiI1ysWa6KF5e5an6KnSOIytIuP5w+PeG8dcJLRQROl8+3AA9cs3gYE9m
         nwdU9PEa1TnUpCCDet9e7oQiuiRxgW8hcHS4lJxr3LwTKh98ZarkfSSzYraD5sKr7FVd
         EDeAjHHz9dHfSyA3+hB38qiCmIotz/3jX+nsPxcw2U8dOOojMWxV93a2csh8Bcl1h0Ax
         0b5g==
X-Received: by 10.50.17.166 with SMTP id p6mr5586232igd.12.1366529920262; Sun,
 21 Apr 2013 00:38:40 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 00:38:00 -0700 (PDT)
In-Reply-To: <7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221907>

Junio C Hamano wrote:
> A list of revisions is merely a way to specify "revision range" that
> are reachable from any of these revisions listed.  "log A B" won't
> stop by just showing A and B (that would be "show A B"), but will
> list those that are reachable from A B, so in the context of
> discussing the arguments given to "git log" command, "A B" is still
> "revision range".

... and what about 'git log HEAD^!'?  Is that a range?  What about
'git log HEAD:README' (hint: it doesn't error out)? I would argue that
"A B" is not inherently a revision range, but rather two revisions.
It's upto different commands to interpret it differently.

Then again, in the context of log, we just want ranges (also
considering we had <since>..<until> for this long, and I didn't even
object to it).  So I'll go with your "revision range", but I won't
claim that it's technically accurate.

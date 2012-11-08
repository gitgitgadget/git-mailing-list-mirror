From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Revert option for git add --patch
Date: Thu, 8 Nov 2012 19:00:06 +0700
Message-ID: <CACsJy8CXV=TPWPkNnF7rPRvuObRH=m6RY0KXVXkCaum1EovDCQ@mail.gmail.com>
References: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:00:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWQmx-0003HO-SF
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 13:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab2KHMAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 07:00:38 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46436 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2KHMAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 07:00:37 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so2696762obb.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LtpeeV+ESbzYG2bob8gFnVq3ZessASLjT5ZSW6AxsMg=;
        b=Wdc6oDs9VzVpjGkElv7M+ZzmclwPOFrk+k+vxP1SHyrzLW6UpLHLXv71BLifLhyz9K
         3P3Em1m8CiOhIYWvzzynaRazEvh+9GmQRpmqoZKo07fCCQTeHfR2kq6sWByafYTIkRG8
         tQOw/F9TUwtsJk2BYPyIux3qZS1IdAmVzZCTIjtEjDjVnlw+Y1cdIKrNrgGP7dZOmRJV
         +fQx8s8Vp8ujr6CUjRZDUaLOU9Txt4M8W6t0u8mqaywMskeGiWfhKHW2ZZz2IYq+3atv
         vc+O3qIe9Ae8u+6i3TMCBcEhYygsQ3lcPm0F3b9bX/7ipnriD93N+rzwMjrP9b51t/2G
         mTRQ==
Received: by 10.60.13.132 with SMTP id h4mr4814560oec.72.1352376036955; Thu,
 08 Nov 2012 04:00:36 -0800 (PST)
Received: by 10.182.49.41 with HTTP; Thu, 8 Nov 2012 04:00:06 -0800 (PST)
In-Reply-To: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209154>

On Thu, Nov 8, 2012 at 3:57 PM, Jonathon Mah <jmah@me.com> wrote:
> Nathan,
>
> I find myself performing similar actions to you: using git add -p to stage hunks, sometimes editing the staged patch; and keeping mental notes of things I wanted to revert, sometimes changing them in the editor in another window, and sometimes reverting them after the add session with git checkout -p).

I agree. I'd be really nice to have an interactive command about hunk
manipulation between HEAD (or some other ref), index and worktree in
both directions (except writing to HEAD, of course). This reminds me
of the "git put" discussion a while ago, which also moves code between
different locations..
-- 
Duy

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 20:39:13 +0700
Message-ID: <CACsJy8AXonkSXNU_uUXh=d2wojOhAn+S1JW7eUMywxohnAOXjg@mail.gmail.com>
References: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
 <CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com>
 <CALKQrgfb8qbeKmCzri27iA1qk9H8R4FgyA-YsUQf_JQRWvGK4g@mail.gmail.com> <CACsJy8A4-XC7AS4ZqZ1Whsoo-mztTNFvEnk810e10-rwXBkJHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG8t7-0000GN-BU
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 15:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab2IXNjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 09:39:44 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54347 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2IXNjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 09:39:43 -0400
Received: by ieak13 with SMTP id k13so10812922iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pzTATT2AlPgxkVL9/FmmmOyZ+Qamxqx7Fnq0tPs3dF4=;
        b=rl+IrVqAXnRESnFf2BzHroBV/mPVj9OAB2YuENh12KAZ9MG6YwA6J+EYIF/Q0TdEgP
         jU0hsCrPwIO1ytBBzf1tT8amEhfGbQiKM5Ky3qQ7BXUronjaMetHnHljcOMqC7WG1Ogg
         T72viuyPgMjlx280dXNxkEZjNGF/v1bZ9M+NXT8+zZ4i8SH5aCX0TRBDkbI5OlNzE5B1
         SSVajdiFr2Hk/XU9pVyLM6wP429U/CciZik6esZBvwjIO+sfXUt+pzqDbvxMkiRmKk/c
         tfQlLN6HKwUKCMeNtfP0yiZIRzaJBYC63V2aFA2AB/fVW4fQvgmg2HMTnSpk2+Z49J6e
         xsSw==
Received: by 10.50.207.33 with SMTP id lt1mr4329265igc.40.1348493983264; Mon,
 24 Sep 2012 06:39:43 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 06:39:13 -0700 (PDT)
In-Reply-To: <CACsJy8A4-XC7AS4ZqZ1Whsoo-mztTNFvEnk810e10-rwXBkJHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206270>

On Mon, Sep 24, 2012 at 8:30 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Any special in gitdir/worktree setting?

What does "GIT_TRACE_SETUP=1 git log -- /Documentation" show?
-- 
Duy

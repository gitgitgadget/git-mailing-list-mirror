From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 16:04:29 +0200
Message-ID: <CALKQrget=YpoZuH+aRdiey_S==37SPnJ+PvwiDpSM2701w602A@mail.gmail.com>
References: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
	<CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com>
	<CALKQrgfb8qbeKmCzri27iA1qk9H8R4FgyA-YsUQf_JQRWvGK4g@mail.gmail.com>
	<CACsJy8A4-XC7AS4ZqZ1Whsoo-mztTNFvEnk810e10-rwXBkJHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:04:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9HA-0001nY-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab2IXOEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:04:36 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64989 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551Ab2IXOEf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:04:35 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TG9Gz-0000a7-A8
	for git@vger.kernel.org; Mon, 24 Sep 2012 16:04:33 +0200
Received: by oago6 with SMTP id o6so5409611oag.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 07:04:29 -0700 (PDT)
Received: by 10.182.225.5 with SMTP id rg5mr9827895obc.49.1348495469843; Mon,
 24 Sep 2012 07:04:29 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Mon, 24 Sep 2012 07:04:29 -0700 (PDT)
In-Reply-To: <CACsJy8A4-XC7AS4ZqZ1Whsoo-mztTNFvEnk810e10-rwXBkJHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206271>

On Mon, Sep 24, 2012 at 3:30 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> In any case, what is the _preferred_ way to path-limit "git log" to
>> Documentation/RelNotes, when my cwd is t/?
>
> If you want worktree root no matter where you stand, use "git log --
> :/Documentation/RelNotes". The idea is ":" starts some "magic" in path
> handling, but for now there is only ":/". Or if you don't like magic,
> `git rev-parse --git-dir` should give you worktree's root to start
> with.

Ah, ok, that's exactly what I wanted. Then I guess "cd t && git log --
/Documentation" should have never worked in the first place, and I
question about "git log -- /Documentation/RelNotes" was misguided.

Thanks for clearing up my confusion.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

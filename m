From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status & seg.fault
Date: Sun, 7 Nov 2010 16:23:07 +0700
Message-ID: <AANLkTinfrkp6_AG=G_hHiWe9t0ke=bm_pg=_ecShXsbB@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com> <AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Rado Dr." <radodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 10:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF1Y8-0002Ep-3s
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 10:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab0KGJXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 04:23:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51558 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab0KGJX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 04:23:29 -0500
Received: by wyb36 with SMTP id 36so2472960wyb.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 01:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=V0Y2HvPkX8XTDeTrujNiHu+mFNrphRY4ObjJshTUNS4=;
        b=dbMSuW/Ehr7aW3e7C1MhV0Z9ygeNFzRgj0clW2Mpcbc8BsbL6M32bGk1aiR3Ft+tY3
         v4hmHwNgCfyhE5KHRGeSe1hmP+p0BYs6DqKMhWwEIo0e1k/RMdb6ClHjDQyGB9jEtqE7
         mO+MoXlWUlvZeIeykEo696yXkYctZ4cP9FfTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GVzYXbjn6NYZwOS5JvMxehoo2IQFeq7wctwykuy2UqGP4cPaavKGFdK706QbG+7qUJ
         7KzMJ9hRx/rovYytQeqm/wCdWUqGgArTb+wXkHP8b6BnQw0J3I0VhOI+z/NJ9XpEX5IO
         fJYcijXVVzeBM/p3Bv+VKw6GqFDGjI0zjoHpk=
Received: by 10.216.172.9 with SMTP id s9mr4050474wel.56.1289121807971; Sun,
 07 Nov 2010 01:23:27 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Sun, 7 Nov 2010 01:23:07 -0800 (PST)
In-Reply-To: <AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160869>

On Tue, Oct 26, 2010 at 1:44 PM, Rado Dr. <radodr@gmail.com> wrote:
> Hi there,
>
> I have "Segmentation fault" error after "git status" command in one of
> my local repos. Just i one repo, other repos are OK. I can't find any
> clue how to fix it, and as usually I need work with that repo ;-)

Has anybody resolved this? If not, Rado can you send me your
$GIT_DIR/index if the fault still happens?
-- 
Duy

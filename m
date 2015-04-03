From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: gitk drawing bug
Date: Fri, 3 Apr 2015 17:05:33 -0600
Message-ID: <CAMMLpeQ3J_x5xee=V+Sn4=FTRNM-yQSm_yXSwFpiCNJz2AD7Gg@mail.gmail.com>
References: <CACZ2eqdm_DXfa0o9J3NXfxD0XG-iAbPNUhySg026qhkqZAYWJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>
To: "Martin d'Anjou" <martin.danjou14@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 01:06:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeAf1-0001mU-QZ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 01:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbbDCXFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 19:05:55 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:32791 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbDCXFy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 19:05:54 -0400
Received: by wgin8 with SMTP id n8so31291146wgi.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xZEvGjx/Xio/6hQfhl290VMLsOqu7ZDpEWBl1QRjeck=;
        b=NvYzQ50at4oi0ykX2Og1x0jI5V18TWmU7SOHTG4mtfjXawYb5pQhLP8CnDdjeN4I09
         WV0FjK3h3xRWSOYpsMEWrwljDr04RQ87UP2KJkgLLe/dAETEVvYT3IaBGNvY0gdxpsjv
         RcL28pvEhLDDyAEunxbjA1YMfeY/E85p/MCPf2u8VQeSLqsNpaWvQOmfLHmHinNrHlrD
         QtVqaX60t6kfpi0QwnDtPTdyHRnaC/RKj4tsyjOwMIwJ+ypyyBik3i11NBaZGhenQqLg
         zY8rHS8qZ6BsYGDBjoXAE6mQO8dZzkBz187EkDb7QG1x5dMC6nZxU9z+6UvHpJdBu8Mu
         BaTQ==
X-Received: by 10.194.63.16 with SMTP id c16mr9174005wjs.117.1428102353745;
 Fri, 03 Apr 2015 16:05:53 -0700 (PDT)
Received: by 10.28.182.196 with HTTP; Fri, 3 Apr 2015 16:05:33 -0700 (PDT)
In-Reply-To: <CACZ2eqdm_DXfa0o9J3NXfxD0XG-iAbPNUhySg026qhkqZAYWJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266747>

2015-02-18 12:27 GMT-07:00 Martin d'Anjou <martin.danjou14@gmail.com>:
> It appears I have uncovered inconsistent behaviour in gitk. Looks like
> a bug. I have a picture here:
> https://docs.google.com/document/d/19TTzGD94B9EEIrVU5mRMjfJFvF5Ar3MlPblRJfP5OdQ/edit?usp=sharing
>
> Essentially, when I hit shift-F5, it sometimes draw the history
> differently (still valid, but drawn differently). There is no change
> in the repository between the shift-F5 keystrokes.

Did you ever contact the gitk maintainer, Paul Mackerras
<paulus@samba.org>, about this bug?

-Alex

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Fri, 18 Nov 2011 12:36:31 +0100
Message-ID: <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
References: <4EC52508.9070907@tu-clausthal.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Nov 18 12:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRMlv-0003qS-IV
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 12:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398Ab1KRLhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 06:37:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38632 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab1KRLhM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 06:37:12 -0500
Received: by ggnb2 with SMTP id b2so2334612ggn.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 03:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sdnoAfARYMzifuRgRyBQJVx/1CyD6gXx4flm0/Cqz4k=;
        b=S789wdPHo07kc6N11N2mOMzy6tnZ5F6wyjHgIKKm3F7GtykA9CxZzPEn/2jprla0+o
         1Yy7xhVgx1lsyXNiBxGy+wLaBF5y+Tl+UXgUYmqKnEhxeWynkDS5Hfl9uv5xo+CwzBO7
         cjW9VBM/UuVJDdCAAFkzghZT5OKXdy5qdT3BI=
Received: by 10.68.39.98 with SMTP id o2mr8834697pbk.119.1321616232123; Fri,
 18 Nov 2011 03:37:12 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Fri, 18 Nov 2011 03:36:31 -0800 (PST)
In-Reply-To: <4EC52508.9070907@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185654>

On Thu, Nov 17, 2011 at 4:15 PM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> From 8e576705ca949c32ff22d3216006073ee70652eb Mon Sep 17 00:00:00 2001
> From: Sven Strickroth <email@cs-ware.de>
> Date: Thu, 17 Nov 2011 15:43:25 +0100
> Subject: [PATCH 1/2] honour GIT_ASKPASS for querying username
>
> git-svn reads usernames from an interactive terminal.
> This behavior cause GUIs to hang waiting for git-svn to
> complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).
>
> Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>

IIUC, GIT_ASKPASS is intended for passwords and not usernames. Won't
this cause console-users to not see their username prompted anymore?

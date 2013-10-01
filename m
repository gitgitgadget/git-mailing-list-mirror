From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 1 Oct 2013 08:12:37 +0700
Message-ID: <CACsJy8De8uER-=N4DonycE9i0cOG-mvcx+bRnQ=Gxt4X9_1TfQ@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net> <20130924183958.GK9464@google.com>
 <CAMP44s0UcP5AhWrm7vjBDLvY6CupzL03kys1YXs9cpGJNxkBBA@mail.gmail.com>
 <52479C04.8060000@alum.mit.edu> <20130930193343.GW9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 01 03:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQoWa-00018w-CB
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 03:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab3JABNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 21:13:09 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:39153 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3JABNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 21:13:08 -0400
Received: by mail-oa0-f49.google.com with SMTP id i4so4283679oah.22
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 18:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fzscRHHoAIXLNUvm/oliN2RwTSeFiZNUgiCEksd8Glk=;
        b=Ey7rzONWOYV15UVfIka10hHgL5GSF3VlxSnuMzx5NK0tpQZ1MtxDPTqxooCBA5wfoP
         dh6z0Wg2ShdVyYhL4+Ns/uleyaVYasxuLCgpwS5Z7R4aiIbgQm1AYINC1wvpp3B19cCw
         F5fW+9bTDk56ur1odkkQnJ3RUiaClAua2QlXsyo9GX+ZeRDDdeRsB3jCTGQYbP9pz/j2
         qngYF0sDZ4zTcFvGBOe9/urHDBxDh+miUpAtVY/LVT7fByj4gwU03lQ5DlMEJrXc09v5
         ZQqYZvWZi6dIBhkGo5HH67Wyp3DPxRtAWsn7kDe5ve7kzvQKIGAfKD02e1VZqZT4RRcD
         VdXg==
X-Received: by 10.60.133.71 with SMTP id pa7mr3974762oeb.44.1380589987946;
 Mon, 30 Sep 2013 18:13:07 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Mon, 30 Sep 2013 18:12:37 -0700 (PDT)
In-Reply-To: <20130930193343.GW9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235637>

On Tue, Oct 1, 2013 at 2:33 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Michael Haggerty wrote:
>
>> That being said, independent of aliases, there are many other config
>> settings that can affect commands that might be used in documentation or
>> scripts, and which also could be the source of errors for the non-vigilent.
>
> Yep, this is a problem, too (I'm looking at you, "git push").  We try
> to avoid this problem or balance it against convenience by being
> careful when adding new configuration, but sometimes we slip up.

I think the problem is we start pushing too much on the porcelain
front and forget about plumbing. "git push" is for human, but I don't
think there's an equivalent for scripts. "git branch --list" vs "git
for-each-ref" is a good example.
-- 
Duy

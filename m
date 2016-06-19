Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3692120189
	for <e@80x24.org>; Sun, 19 Jun 2016 14:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcFSOPX (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 10:15:23 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:32979 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbcFSOPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 10:15:21 -0400
Received: by mail-vk0-f45.google.com with SMTP id d185so168400998vkg.0
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 07:15:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=JIkFjcoo4uuVQZ3EN5/Zh46uD/xdMpWNueWmqhyJecI=;
        b=KEy9pACiAB5Y8SNN7Lv2bSJmWKp6ogym6ALFQqY4g/tahDy/d2Bajhinqb9oKrLOh3
         0VE8zq9b9ax/Ls1gK7nkB8H+LVakABWlIsQ+f2mnpGKghnmNF2PZV7WSPhMSgIpWALML
         NVqdp/YVqy5NL90l2va7XktHsjG8YioFWMjosFCuDChGK4h4r0k49zP33huVic4OOrh/
         Ds0eQPTF7XaXXR5yufgL02Q0Uv9LA2sLwE20yFFTUNz8Gin7VnSvOSH+d4QSs8mGu+QJ
         EgyWDhGbf2A2ENQ0JeYS3fY21d5pIjtyYgkFuCBTEetYTc8nIfQfwy/ZvWsrxqbwu2Sl
         fVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=JIkFjcoo4uuVQZ3EN5/Zh46uD/xdMpWNueWmqhyJecI=;
        b=L7Ey3f+TRjOA8Oxj9q85dKwbT7ZV6z8LfqN27wLn1EQe5nvQjoDwV1VV6x8kWmFUt2
         ACGQytpFEDRzWqfttPO+gs27oB8m5EFaTO1r0MVJDOaG0JTKG5pD6eXwqiJx1f7GaCDr
         QQrIRmblV9ZLLJoo0Ks69RL//RLwBbHLq4WXRF4asK6OfZVzG057OL1PFtPJW0uK5xbl
         zorUrdfxXuFMkZSdTPCC/yxLt6Ti+ibRHiwdmJuLDtDQh4nNSnnIrbjTID4HCWauZllB
         p6P8aXTKy3QJV/3sxP+dTjzDuWoQ7rf1h4PvImumbwVCsRh4Z3Ur1jgjiDnVZngVe5Wv
         C1YA==
X-Gm-Message-State: ALyK8tLaMbzQINKnNeEnihHDugoE4KVEGwwJNCBfeRMvJUn6caHxEsOa3dwAX3LB0Vi3xQOZLIEq9IGDUuhn8g==
X-Received: by 10.159.41.231 with SMTP id s94mr4777428uas.74.1466345720700;
 Sun, 19 Jun 2016 07:15:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.13.131 with HTTP; Sun, 19 Jun 2016 07:15:20 -0700 (PDT)
In-Reply-To: <CAHWPVgNrTEw9FmW6K7QucgA74QWsTKfxZGt+mGd099k+O7O+rw@mail.gmail.com>
References: <CAHWPVgNrTEw9FmW6K7QucgA74QWsTKfxZGt+mGd099k+O7O+rw@mail.gmail.com>
From:	Ovatta Bianca <ovattabianca@gmail.com>
Date:	Sun, 19 Jun 2016 17:15:20 +0300
Message-ID: <CAHWPVgMWeHoD5vTiFJ1gsm2hS74LK7j4npVVbOZeR43cX3qWXw@mail.gmail.com>
Subject: Fwd: what is a snapshot?
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I read in every comparison of git vs other version control systems,
that git does not record differences but takes "snapshots"
I was wondering what a "snapshot" is ? Does git store at every commit
the entire files which have been modified even if only a few bytes
were changed out of a large file?

thank you

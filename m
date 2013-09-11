From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/21] np/pack-v4 updates
Date: Wed, 11 Sep 2013 21:21:10 +0700
Message-ID: <CACsJy8C87k7K6dnr5N_mqz9w7YtdHzjB+jPwrwtMk1oeXxWYGQ@mail.gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com> <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Sep 11 16:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJlIf-0001Sh-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 16:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab3IKOVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 10:21:42 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:46152 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab3IKOVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 10:21:41 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so9193259oag.4
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kllUL2NvqZOLv/hKfQJI699CP7ceSdhNtYza+RNdzl8=;
        b=OA9pVd6wbrTQDSPA0PD8pfd4k3x3fb987wgycVM2lXqAei3uhbuQwgx+5UH+Zd7S8g
         tcXNgGaH9rr695XdHkCohI5M63385oho1/fXsTnB16TSbWOFJYxkRZB57VvYSF1M5rry
         4bODuOmdszr1LvzRR/C+ol2mNcJEqhCIYkhdh/p9+9mjCa/tRplBdY6h3uKT14Kjhka3
         o5nYHCx3mQKbnmC7Da6d7RIw0aXiQ1c67E9bt/3YFFmLI7RhDzoiCYuDBwkQGMxENgPZ
         wVQKb3Nco+/KJZvqUpOWUxHjEjv1Uo9t35UEO7tbMVE6OP0tpnriIfrdXqvp5ULWgani
         PWKA==
X-Received: by 10.60.34.4 with SMTP id v4mr571038oei.101.1378909300868; Wed,
 11 Sep 2013 07:21:40 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 11 Sep 2013 07:21:10 -0700 (PDT)
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234567>

Nico, if you have time you may want to look into this. The result v4
pack from pack-objects on git.git for me is 35MB (one branch) while
packv4-create produces 30MB (v2 is 40MB). I don't know why there is
such a big difference in size. I compared. Ident dict is identical.
Tree dict is a bit different (some that have same hits are ordered
differently). Delta chains do not differ much. Many groups of entries
in the pack are displaced though. I guess I turned a wrong knob or
something in pack-objects in v4 code..
--
DUy

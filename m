From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Support triangular workflows
Date: Fri, 22 Mar 2013 13:14:29 +0530
Message-ID: <CALkWK0mj-DqGogJwjudLPbNz1Kz_MNAziEWjCu_m_POEWGZ3-A@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com> <CALUzUxq1gJY_gSQt4iffrVzawx6Qk4=BWnPoCsZqFeHUpkgwCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:45:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwf7-00068u-4s
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab3CVHou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:44:50 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35883 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab3CVHot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:44:49 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so4533462ieb.31
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8SBBd9/UT77DJfRRTNadUqym+MGYcIMnE5rMCKYhxsw=;
        b=UC50qBbVYBMd7ZABMCBhN8beW8h8AY34ncL4Y8vM73vd1rpB3u0tQJ2NOuYPAmg7qr
         lFmUXgqZdWZj8a1xp6ZueMXBUboYRB+MuVZUW6aV/FbJWB46Oi6iJJtm9E6dRQFj7v/M
         79lmj/PsKpGIl5qZqNbxxN4qXgWYh8ioRoyvpvuC0uflNZhEakpKOGgUNaj5tKZBwCsV
         N5Z8tPHCHgnFKz1ZLEvbrNahl1pz8KDkRLly5yeAc0Bkdo10AP9u3Gba3TVbvElnsZUy
         T9OOMKr5WxiHkNxLY8EqGUGUQzRNiBeOOnEu/99TrW5z7FndCM+p/1kjacLgarN7PGj7
         iyRQ==
X-Received: by 10.43.9.68 with SMTP id ov4mr443694icb.22.1363938289177; Fri,
 22 Mar 2013 00:44:49 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Fri, 22 Mar 2013 00:44:29 -0700 (PDT)
In-Reply-To: <CALUzUxq1gJY_gSQt4iffrVzawx6Qk4=BWnPoCsZqFeHUpkgwCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218777>

Tay Ray Chuan wrote:
> On Wed, Mar 20, 2013 at 8:44 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>>   remote.c: introduce remote.pushdefault
>>   remote.c: introduce branch.<name>.pushremote
>
> Perhaps we should clarify how this differs from remote.pushurl in the
> documentation for it, in git-config and/or git-push. Maybe even
> include the design decisions behind it from [1]. :)
>
> http://thread.gmane.org/gmane.comp.version-control.git/215702/focus=215717

Actually, it's quite obvious when you think about it: remote.pushurl
doesn't allow remote tracking branches, and this is a very serious
limitation.  If anything, the documentation for remote.pushurl should
be updated to explain that it has a very narrow usecase (will do in a
future patch).

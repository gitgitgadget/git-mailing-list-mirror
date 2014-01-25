From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/9] About the trailing slashes
Date: Sat, 25 Jan 2014 08:14:42 +0700
Message-ID: <CACsJy8BPS95+34chr4rfSTAcQNVHJccu9SYih2fiNxB_3eRy=A@mail.gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com> <xmqqk3dprxr2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, pawel.sikora@agmk.net,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 02:15:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6rqK-0004xN-VF
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 02:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaAYBPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 20:15:14 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:48416 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaAYBPN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 20:15:13 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so5423435qcx.35
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EhaSouo7SEWZw1gYw6/pkewy5e10kGo0JHo9duadj4I=;
        b=DKQ5b7v0nVBsYWjInJHIhbm8GLAMRmGOTNIyCBQ3aMf8hPUMs5SAFdE0xnydULviIX
         JcsDOc23fSc6JXs/mCHl0RQnyvr8lZo8FROcrHmasSZ48wva34IBovd+og0FzYTT2JX5
         NSR8j+PsM6w/c7wa8gJeFBbt2X3Se86LAsSuMT5o4tb2dtuYr+BE9O5buWBLeG3cXazu
         5cmN7wGVwBAjqx6b01ryG3aEmjmCD9nAGpyS2X/yyCVXedl2bE2CuKJHKUmdm7UCAQfu
         e+NYeY/02Lv4H8CmfGl1H0YyYpqjD0b2N3qrtY89yTj8RTlP7h1qA65N4u57coZU06QA
         DHBg==
X-Received: by 10.224.167.84 with SMTP id p20mr25348766qay.24.1390612512735;
 Fri, 24 Jan 2014 17:15:12 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Fri, 24 Jan 2014 17:14:42 -0800 (PST)
In-Reply-To: <xmqqk3dprxr2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241056>

On Sat, Jan 25, 2014 at 2:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> How does "git status '[b]/'" behave?

It outputs "b/" (like "git status b"). I think that's because
common_prefix_len() stops looking at the first wildcard char, '['. So
common prefix is empty, just like "b".
-- 
Duy

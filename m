From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Remote hung up during `git fetch`
Date: Thu, 22 Nov 2012 11:52:30 -0800
Message-ID: <CAJo=hJs5PwLxwtBoYb+ZLmY=ts9U=UhDPmKXW7KY2BFNpBJfDQ@mail.gmail.com>
References: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
 <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
 <CAJo=hJveYb09uhZWsKWKYor5Jcuz+wZ40F3wnsR3Hy8bcxeb6g@mail.gmail.com> <CAMvDr+Rv6Krmjto6nQL18GnEj-+qCFPYgp7jDQnLs-ybamM0FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Yichao Yu <yyc1992@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:54:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcqV-0005go-5o
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283Ab2KVTxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:53:44 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56822 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837Ab2KVTwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:52:51 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so5953997qcr.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mT1PP4cmS/OlFy5rx9jRc6wdYJt9LJkn8F9VPr0/Dik=;
        b=JqEYbHm+Yjtjf16AIQVbI1nA5/+7pFRwQYhy3V8mQk32BUHI8zSsaPfyhNcJSYke+4
         Wyjt0PaFU8luG4YvMlctRD4FR9Phb7baFFjKNhKAYC6wHBYKCK+qJgTtw325wEIuMyuv
         nSWVs8ETSMSkUgJTsImmH2o1qeZnHAoBv2jlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=mT1PP4cmS/OlFy5rx9jRc6wdYJt9LJkn8F9VPr0/Dik=;
        b=Fi+ceQE+BBUUWj6aV8bY6dTEB54gvz3N+inqdmgoY6eFkA0aGZN1xMqpmSB9B8TJzb
         T9w6oovaUhCeiY1QKMq54K6S8Kehg8mdBKc9sQnYu8jm00JmpVGCNxuAZ7Tket0WyMrC
         xOqaubym/TdzK07fLS33G6aLKbDSMQlrTQq0dEToJ+oYc33rXWIAtWKlz5ZpidbJVoVu
         V4kkml5/OD01YsDNdoZn8tZxauy9Ose0T6xu6c6xm7FH8z1AZd7FfRXF+yCVc0sesUUk
         giynQC3yFOdO9+EDm0ApE9T1wNRyXtVu06w6YrRnV8vKhOZo02m92ot4OOsWx6qO7jcW
         olyQ==
Received: by 10.49.63.104 with SMTP id f8mr1761648qes.29.1353613971024; Thu,
 22 Nov 2012 11:52:51 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Thu, 22 Nov 2012 11:52:30 -0800 (PST)
In-Reply-To: <CAMvDr+Rv6Krmjto6nQL18GnEj-+qCFPYgp7jDQnLs-ybamM0FA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmpD2Fuu3pafT0Sv+aAffYODxrce/Y9XAlEaf6wu52DXGqIKFIvg4Q5LvKwfBnt/idpaoO0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210204>

On Thu, Nov 22, 2012 at 11:44 AM, Yichao Yu <yyc1992@gmail.com> wrote:
>> US holiday today? The list traffic tends to be down during holidays.
> This silent?.... 0 email from the kernel mailing list for 10+ hours?..
> anyway.... nvm...

Check your spam filters? I am having no trouble getting email for the
Git list. Traffic is down, but there have been several messages within
the past 4 hours. E.g. this thread among them.

> packet:        fetch> want 2d242fb3fc19fc9ba046accdd9210be8b9913f64
> multi_ack_detailed side-band-64k thin-pack ofs-delta
> packet:        fetch> shallow 65546ab097b023886a60df4cbc931d4cc362b98e
> packet:        fetch> shallow b80d60e1c3854460a1f01d4110da5ae98f30f9b2
> packet:        fetch> 0000

I think this is the problem. Your client told the sever it has the
Linux kernel shallow cloned, but its talking to a repository that
hosts git.git. The remote server doesn't know these two SHA-1s
mentioned on the shallow line, as they are from the Linux kernel
repository, so the server just hung up on you.

Basically this is an unsupported use case. A shallow repository can
only fetch from the place it cloned from. Anything else working is
pure luck. It _may_ be able to fetch from a clone of that same
repository at another server, if the clone has at least all of the
commits the client already has. If the remote clone is missing commits
(as in this case where it has none!) then it doesn't work.

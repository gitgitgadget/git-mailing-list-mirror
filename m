From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Sat, 26 Mar 2016 18:18:55 +0800
Message-ID: <CAKqreuyb1D7_D9iGWAqnLFc9ERsmEM-nu0LWdg1P4u7+aV6zGQ@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
	<CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
	<CAFZEwPOa3i9XTF-5ZWZXvXfAzpyFojz57JBy4_WahF0Y4Q9DWQ@mail.gmail.com>
	<CAKqreuyN--AjjhTcTx1+Baec=j-6TJPj8Rwoxre86TJp2UMGDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 11:19:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajlJB-00058E-06
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 11:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbcCZKS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 06:18:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36800 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbcCZKS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 06:18:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id k128so2712134oig.3
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Xvr7xkvwbBK1Do/vs3HiDvQiUBXZcWjqKgPbtBQ/0e0=;
        b=TbpK0Kwf6ONNDkYTwU1EYLaLn9NCoYOyNSm3Yiv8D1VAtCkq7kXijpQVe7yZc52lyf
         F5AH4V7e/+E6fhH9zJRZN4gIyE4OCLNrEjnlini6H+hMgjy9d629VY2CW7cEQm26VyjW
         oGl3ienfN6gT6gYgORfnZD+o+2RHSyXrJZGsIVUjDwc8DbgdxEQ7tCV9RiiP3hbczm0B
         xNS0wX08AKUph22ppeg14DLQncJ2weykT96V9ewPYv6GRYEXGTDtuD9Hhpo0ApqWurgJ
         l7/6j9x9ivlL7rNwHSfMyIWhIf1PN6xOeYyCUr3hV3gVA2RirxhuOXJOa3yN9DnPpeqh
         +awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Xvr7xkvwbBK1Do/vs3HiDvQiUBXZcWjqKgPbtBQ/0e0=;
        b=bjsFG1k/H76BhCAPGtzG1yj3PtNNi5JjhwB4uaJQdZn/JmGMFT9wTzJn4viy3z/v/m
         Sh8fM7MTgif2PByWceaneh9WjTDTWARaWccB26Cr/Dwys6GPMQCpJelVoqZXoxFeFXQC
         GnM4efU3iiIvJJ7PceitlRgLHiJ0DuB+sVfBVmvU+P/ds/gxrk36E6jj+wXadPdj6u2S
         xLS0OEOk8KPhbiSZZcY9Pyfg9lLqCLtX8dOXMwxWMY6a3wDLtgsrXIKP/s2OhXnAUIXK
         l1zhecOm5m8WtKtjiKl0rRDLvU7TrL6J5IAFskAFeba8tGwapP8QJ4zzzV8jgdpdPr+0
         YiiA==
X-Gm-Message-State: AD7BkJLyYQ1bR7tqSqYVg3G5/I1wCCOl/o/ci5mUDNgej6hsNJUfXg4vGATgkqf7SZBRqHtDkISupTWJQ/OQkw==
X-Received: by 10.157.44.66 with SMTP id f60mr7692194otb.163.1458987535562;
 Sat, 26 Mar 2016 03:18:55 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Sat, 26 Mar 2016 03:18:55 -0700 (PDT)
In-Reply-To: <CAKqreuyN--AjjhTcTx1+Baec=j-6TJPj8Rwoxre86TJp2UMGDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289980>

To make it clearer:

1. there are so many great mail clients, why not let these experts to handle the
    dispatch of mail?

For example, as a One-time-password user of gmail, I have to generate an app
password for each terminal device I'd like to send patch on.

It's more important that I could not use my favorite mail client which
has contact
list, familiar interface and more personal configuration.

Why not let one program just do one thing and do it best?

In my opinion, `mailto` is a suitable method. git is one of the best
version control
systems. So it forms basic structure of the mail according to the
patches and passes it
to the best mail client. How amazing.

2. But this workload is not enough for whole summer. I thought I could do other
    interesting things based on the `mailto` link.

mail client is a straightforward choice.

In fact, I meant to implement an interface more friendly to new users.
no matter how
it is implemented or what it is based on. The first time I send patch
via gmail is not a
happy memory.

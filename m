From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] submodule-parallel-fetch: make some file local symbols static
Date: Fri, 25 Sep 2015 08:40:38 -0700
Message-ID: <CA+P7+xoPtpt_=1vf4OKaDSt5E4AYkPapkUp94-f=WaytbHdv0g@mail.gmail.com>
References: <5605650C.2000809@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 17:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfV7U-0005Hz-DN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 17:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbbIYPk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 11:40:59 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36851 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663AbbIYPk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 11:40:58 -0400
Received: by ioii196 with SMTP id i196so115113545ioi.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rl9WaipOgqs5CfPlpgecqKJKJ+I+3eHA94lBwl6qZ6U=;
        b=gO2owZgYPyfos+zN0tBAAmvnQ7Yew6vs7PDQHgY3iYKK/0UHcJFNIe/I1BCLPQN7kx
         n4SnF7iYJF9VVsRq4BJfXKVLR5vnGYgv4u8aJhaUgCZth9cN4//DPFylvGkAZEZg+WSs
         wknUr3w64N6D0VcbRx7GcWJPJ/vw7ib+XXHQC3M2GHr7n1F3QoTThmFeUtmRYlk0Llac
         FPq2x6ZeVA5moCghdNPYAGHK9W8Srt5Ojxw+5pB/A+n8w7oR0VdM7TFrVYvd9K3E7DaG
         DRUIwZW8odmNLkKqoemByYXbUapb+ADdXhpwrkwhwZMDK//1XJ6reGKSkFYmccdF/mnV
         alWw==
X-Received: by 10.107.130.220 with SMTP id m89mr7133161ioi.146.1443195658020;
 Fri, 25 Sep 2015 08:40:58 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Fri, 25 Sep 2015 08:40:38 -0700 (PDT)
In-Reply-To: <5605650C.2000809@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278662>

On Fri, Sep 25, 2015 at 8:15 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> [Note these issues were spotted by sparse and static-check.pl]

Any chance you got a link to docs about static-check.pl? I've never
heard of this...

Regards,
Jake

From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Fri, 16 Oct 2015 10:42:45 -0600
Message-ID: <CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com> <xmqqwpumg480.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 18:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn864-00028o-4m
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbbJPQnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 12:43:07 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38242 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbJPQnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 12:43:06 -0400
Received: by wicll6 with SMTP id ll6so19643772wic.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cVSbotT++c96SmK+huV6NwcEyHVYSu1SoHk3k++ZVss=;
        b=LLChIELQoF99t5ibEed0TnrVA+bhaszD3Prmu0AmUH7BuNMmsZD9u/HuFQeXNcRgBi
         e7y8xryf+DOEMwVar/XMrvwnYNVHQtslRTh6X+GzFdYnacx8qBQHiN0/nqQ9LUgfQGIs
         aBZ6MCWqHz7Yg45gRwE3STlig/qQReb6eJWFofc/YCWnjvVKmu0QCH1+Jd4++LgChkD/
         M0siiilRQ5vZUiEzc3IBHXy781h9C2mgCd3nCBDcvXbsFtZJLjwrPxAbALuuo5Ji6yvF
         MTox+K0m5h8NyArZf5LPjqe+qO95gHmfk6hkOdfBvz8arTVO9TkxeqRLxHMqqmUHa+/8
         ahZA==
X-Received: by 10.194.123.193 with SMTP id mc1mr18316132wjb.154.1445013784759;
 Fri, 16 Oct 2015 09:43:04 -0700 (PDT)
Received: by 10.28.16.211 with HTTP; Fri, 16 Oct 2015 09:42:45 -0700 (PDT)
In-Reply-To: <xmqqwpumg480.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279751>

2015-10-16 10:36 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Makes sense, as all the other <placeholders> in the usage string are
> bracketted.
>
> Does it make sense to do this for contrib/examples, which is the
> historical record, though?

I didn't know that contrib/examples was a historical record. The last
patch I submitted, b7447679e84ed973430ab19fce87f56857b83068, also
modified contrib/examples.

-Alex

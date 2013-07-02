From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 2 Jul 2013 14:42:59 +0530
Message-ID: <CALkWK0ngwvQzL1cMGL5pWJoJHLYBHV2kUU=i3YiWt5V_uVLz7A@mail.gmail.com>
References: <20130524012324.295dec77@hugo.daonet.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utwee-0005AD-CU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470Ab3GBJNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:13:40 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57644 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab3GBJNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:13:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so11376054iee.20
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EyEnyGj5is1+caSlOoj3oYu4XlX+KNJH2IIk61neD6E=;
        b=k6FwK/EbVGxzOf2WO/9S/mlxFyUEAIIVbIMnx8aV4iNiELa5bJDGDxpb6rGHx+c+7n
         yO/9Vp3Ni3sdww2wYUdq4BFxhR02iXqFBX77Ox1/0ONVaLwgJzjin6yBph/YCzS9+oFD
         yMfjsCf54u/+DLbjnBA7DOXj1ix7LjJXPaK7L22FlJEOvKebrDwUp258wYFMzPzWxYGS
         WCcLk2wccrQKBd8zdiI6TD7iKOHSmHp86jdzRDp5CZAQrotTQQYVihxcilAEVIstnx5k
         8mR0io5n8QaoL79Vmalwf3jACbfYTlS7EdmUJbU19KXYHpG8Fj7oIxKNhyfyS0E8SjR+
         rAiw==
X-Received: by 10.50.72.73 with SMTP id b9mr19055857igv.50.1372756419823; Tue,
 02 Jul 2013 02:13:39 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 2 Jul 2013 02:12:59 -0700 (PDT)
In-Reply-To: <20130524012324.295dec77@hugo.daonet.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229383>

Alois Mahdal wrote:
> This [has been reported][1] to this list about half a year ago
> but with no response so I'm  not even sure if it's been
> acknowledged as bug.

Yes, this is a bug.  However, it is not at all easy to fix; so I would
recommend that you contribute a documentation patch/ failing test for
now (hint: patch emails get more attention that non-patch ones ;)

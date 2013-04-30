From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 00:24:58 +0530
Message-ID: <CALkWK0ns5xvM6otRe2X+4=q_KSO7U74ZVX4PQ32mFmNMdg8B+w@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <517F6E40.1040606@alum.mit.edu> <CALkWK0naGx6Vrb3_iZbXefQqmwOhaTSRXxBT6K-cheiUwr3Ptw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:55:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFiL-0002eO-4z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab3D3Szk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:55:40 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:34455 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab3D3Szk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:55:40 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so740746iab.22
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6U8RkYbSuRTOy+oOJwDS4gOcLFnSZ7NbV5NacIF2ALE=;
        b=lhd3BcNHq6Pgb1wPwjfD8fFYCv1QdxB++I6+yjfJ5owTdQOPdw+nQXJgh9UNodhHTg
         PQeeBH0O6KNZEp1k+gY3gbnGjj8eoRXei17Qiea1XY+CHz+z+QezC3WI6CX3VeB7FzE5
         b3R/h/sbPg0n0Nr+B/Hy4JuoYWqLPs5jX0HYA6FokeVwPThrnUngQTLYjXNUJlKSlCbr
         jEDysJ1Mo2MLilBYl6GIiHzPqMeQvf5zX3bb3ydF5d3rqYpL0y7TkFqMIbIMKuf5F8do
         r3/NnmXga4dqgpb1lMqpeZs/VxsvJPx5Ru3AA5tuquWup4IFBMgC2valtaZOOOmT3qAM
         rAGQ==
X-Received: by 10.50.57.200 with SMTP id k8mr11122732igq.44.1367348139562;
 Tue, 30 Apr 2013 11:55:39 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:54:58 -0700 (PDT)
In-Reply-To: <CALkWK0naGx6Vrb3_iZbXefQqmwOhaTSRXxBT6K-cheiUwr3Ptw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222990>

Ramkumar Ramachandra wrote:
> I'm not
> _exactly_ creating a synonym for HEAD: @{u} works, not @@{u}.

Turns out this is actually a parsing-bug in @{u}.  @@{5.minutes.ago}
and @@{5} work just fine.

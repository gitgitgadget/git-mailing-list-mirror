From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 14:57:28 +0530
Message-ID: <CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
 <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com> <CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuTu-0005rR-K9
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab3EPJ2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:28:10 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:57037 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3EPJ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:28:08 -0400
Received: by mail-ia0-f172.google.com with SMTP id y26so2463253iab.17
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=d4QeInEogxv6/A3dWmOY+oKm/l+iohnocZ7LbSpc2D0=;
        b=sJou8botIygOGXTLfEGleNoqVXNiUsOgk4mSjEHtjLv+rgxCRVz/eh38wS94gS8aei
         arPInt8Uu0ZgFxyfxaQ2Y3QQYUVtsgtfmV2yra86CHnqU6Ji++00sgpotAunWiTuSjEJ
         2EyZSlCPptgtDn2I0QYFx/jFc09Bo73qc2+jKyj3hiOGxSPMxizV91TOW92tODB1/Wvt
         a9p7E9rwzopTKuI3+gipjfYd39xAfyXqZ2PIEcvevc2KNGW97zIE1kxdETDejy0a7Uie
         wKrqA5YBwIvH/8aLiQ4q85S1M9OcbQwZmI+Qo9ZEFIK5XbJKSc0FvCyP9javeXcrTFsC
         dppQ==
X-Received: by 10.42.123.66 with SMTP id q2mr22168052icr.12.1368696488437;
 Thu, 16 May 2013 02:28:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 02:27:28 -0700 (PDT)
In-Reply-To: <CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224522>

Felipe Contreras wrote:
> % git checkout -t -b devel master

Interesting.  Have you considered changing -t to inherit the parent
branch's remote?  (Would everyone like that?)

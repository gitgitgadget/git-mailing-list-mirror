From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Fri, 18 Sep 2015 10:08:04 -0700
Message-ID: <CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 18 19:08:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcz9B-0005zN-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 19:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbbIRRIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 13:08:25 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36150 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbIRRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 13:08:24 -0400
Received: by igcrk20 with SMTP id rk20so22484884igc.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GSxNGqOkSsI3/W3JPW2rlUYxSCoswkNGAvJ0u65LVaY=;
        b=H6EfOeFYxuOMvZWA3ZDrqrHG2SY/Kv3LwzsTYILTuT2dwC6FTfhvrihaGi8A9a5EiY
         oy/hCbAu+DuuW3nJCddhzsNHARhoYhM3HoefBFoGRSS+EBSx6NanQRq5x7tMNXooeXVt
         rVxTM1Oxi0ID/0ZyP9J7BJWloph2G9Y+aox3eTm0CD47X8kocp7fupQ/BG0R3C9ZZU6z
         +fP7Y9VmtQjBWakjqcC4qm2tPW4bUFU17PYDgET+lkxrqbd32mYV5U4yM5o2Zbi01IyR
         yVemWSZO0NIAvSp4os8PVo0ghJ89NtvvsW8gQ4CWwA4AxwA7Z/JYHzg4rWJTvHgNGrhx
         sc4w==
X-Received: by 10.50.178.145 with SMTP id cy17mr35137938igc.92.1442596104293;
 Fri, 18 Sep 2015 10:08:24 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Fri, 18 Sep 2015 10:08:04 -0700 (PDT)
In-Reply-To: <vpqk2rnirz0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278209>

On Fri, Sep 18, 2015 at 9:59 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I'm getting it even if there's a tag and/or a branch pointing to the
> same commit.
>
> Any idea what's going on?
>

Any chance you accidentally made a branch or tag named HEAD?

Regards,
Jake

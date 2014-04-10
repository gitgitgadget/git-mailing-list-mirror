From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Thu, 10 Apr 2014 18:03:37 -0400
Message-ID: <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com> <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 00:04:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYN56-0004ri-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 00:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759123AbaDJWET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 18:04:19 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:63564 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbaDJWES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 18:04:18 -0400
Received: by mail-ie0-f175.google.com with SMTP id to1so4577178ieb.20
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mKSbq29KP3+e7NdnxKe6z/tIWA7/ys9mrw+R2CPdHlQ=;
        b=jj5A9SvlSnPsQhzMPWPsbOecgJcjTY5UOFovKdgcp7z6VmC5Lfk7A9pWr6YY3b5ZNy
         ykKopmK8Kr2hH48bU/Mw7RBwNgjR6dq89qsnLSfK7hVt6Z8wCJYsYEIBxhZL3ymYHgad
         Cd1FXtIstcPPcsG91iyIeX2STJ99WmGkB7GQsoEljNY4i2AxF/Xoqdhd2ZnTzSpVPSI2
         twexad9N6qODzf9g6OL0DBvQUQA1j8kMqouVxmmI+mQJXc/otYnF5MI7gJAOgLdqt+1t
         vcdauV05YBW0ErDNLPK0VXtF6/6rUIwlVB7r5U8fDwS6b+Fmv9wulMhC2ORWuJrfGk4H
         t4yw==
X-Received: by 10.50.79.138 with SMTP id j10mr11221513igx.47.1397167457290;
 Thu, 10 Apr 2014 15:04:17 -0700 (PDT)
Received: by 10.64.10.42 with HTTP; Thu, 10 Apr 2014 15:03:37 -0700 (PDT)
In-Reply-To: <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246059>

Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Please write a commit message, preferably showing the new git-branch output.

I noticed that this only picks up a publish-branch if
branch.*.pushremote is configured. What happened to the case when
remote.pushdefault is configured?

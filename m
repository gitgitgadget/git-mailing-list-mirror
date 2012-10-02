From: David Glasser <glasser@davidglasser.net>
Subject: push.default documented in "man git-push"?
Date: Mon, 1 Oct 2012 17:25:13 -0700
Message-ID: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 03:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIqwJ-0008FN-6C
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 03:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab2JBAZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 20:25:37 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42562 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab2JBAZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 20:25:35 -0400
Received: by vbbff1 with SMTP id ff1so6023834vbb.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 17:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=d1UUXH/RwlMRotSoGCP5UbFzsryyDgIC6P4VEtkSJSU=;
        b=fOtEF2EpB8J3NwenZ3kMMEOQ1OtUgBKJhy7IDLeZvKVGxDMm2/iYc/44q2IjeLYKpd
         6Cx1SYiwKjNBMJhAuFBrxJPr0UstwB67U7TJvuiyzO+jHpUmdfAEplGxsTcL5tKmCOP5
         rX3p0UpoNLPIdaP0PUxfwypmKTPtLx9GjuGEgu6+eXhTNhWkctXmkTyFOeyUkdEAqQ3e
         t7hgt13ayh8HFMi7vwSopW9J/ARdLO+2OECl7GqVIHDgC3MN0UuD4C3XqD+xi7VTzz1d
         p0Dm3aPGK+3ZOvXd2DUFxJAgr45f+ZniW2Yj873BFY3HBwCaikHMDYUAFMsfX1iJFhhg
         G0Ng==
Received: by 10.220.220.7 with SMTP id hw7mr1160435vcb.17.1349137534067; Mon,
 01 Oct 2012 17:25:34 -0700 (PDT)
Received: by 10.58.69.100 with HTTP; Mon, 1 Oct 2012 17:25:13 -0700 (PDT)
X-Google-Sender-Auth: NgNbJQTcY9QpTBtpkuv4cyU6Msc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206780>

Is the newish push.default documented in the "git push" manpage
anywhere? I don't see it mentioned (and there are several references
to the "default" behavior), but maybe I'm missing something. Is it
left out on purpose (ie, config values aren't supposed to be mentioned
in command manpages)?

--dave

-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/

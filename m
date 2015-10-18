From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Sun, 18 Oct 2015 11:15:59 -0400
Message-ID: <CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 17:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znpgv-0008T3-A2
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 17:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbJRPQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 11:16:01 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34011 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbbJRPQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 11:16:00 -0400
Received: by wikq8 with SMTP id q8so20120874wik.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=zVp2/VtdHGBhQlVvj3Jg6N7+/xnsx+RS0qMe5rPrijc=;
        b=nU3rv0X0eekh4GkAzG10v05jn+6zBsZh0bcR0N6t1VhJmjHt2Jr5mZn0ZWcjZafyrM
         WDKOsOVKNIhauUSToD9Mb9vr7tgbtAfAAw2E8Gsjfvwxjf4gpnXBtJkFgvgCdkC+SUif
         N2IzdKeQWfNEK8tGXFSowXLs1yq+XTr51JNcGqSl173g8dA5t05HshBAOC1BLaj/99sc
         A2bH1sjNiKESg8hP6juvyc7UM9MoKCdyVLYKbo5AcrvVeHBeRl17x6BHiYgFzpfwymOO
         Sk/SH9DiqwjsGRO5vKFzB3zyMnmTXyRnxxyv+QB8SByA3XfKaSWYeemPAXxFQQcj5vup
         Y35w==
X-Received: by 10.194.6.66 with SMTP id y2mr30264182wjy.82.1445181359767; Sun,
 18 Oct 2015 08:15:59 -0700 (PDT)
Received: by 10.28.210.68 with HTTP; Sun, 18 Oct 2015 08:15:59 -0700 (PDT)
In-Reply-To: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
X-Google-Sender-Auth: cZ3RsWxl1VJFmYyOBCCH6rS_VAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279811>

On Sat, Oct 10, 2015 at 12:45 PM, Noam Postavsky
<npostavs@users.sourceforge.net> wrote:
> I noticed that git-credential-cache--daemon quits on SIGHUP. This
> seems like surprising behaviour for a daemon. Would it be acceptable
> to change it to ignore SIGHUP?

ping?

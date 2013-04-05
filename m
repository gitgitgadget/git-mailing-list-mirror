From: Jed Brown <jed@59A2.org>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Fri, 05 Apr 2013 07:16:17 -0500
Message-ID: <876201qijy.fsf@59A2.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com> <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com> <87y5cyqhya.fsf@59A2.org> <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com> <87ppyaqcie.fsf@59A2.org> <CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com> <87li8yqayf.fsf@59A2.org> <CAMP44s16NcTBLWuUR9bb6KaspJYYcfsWVyF9NVO4gxP-gXr4WA@mail.gmail.com> <87eheqq6dk.fsf@59A2.org> <kjlr4o$jil$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
To: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWGi-0002u6-5g
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765895Ab3DEMQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 08:16:21 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:65496 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab3DEMQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 08:16:20 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so4132926iee.25
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:in-reply-to:references:user-agent
         :date:message-id:mime-version:content-type;
        bh=Ik31D2brfm1Bo3Q2SABPjuFhKGd5DGxc1qErjlXPz6w=;
        b=U0T+CbSJL3DdruViMfwnbyorkqy7wpZFq1Lfy1j3qfMwoEaYKQzUBQ6iKeA9phRbql
         Y7td/QspWC6bhWZoOLZzw8GRHaY5wWTFr0qhOBeO2Xj5B3vq1r1VdnLZ6lk9PVh3ggNc
         qjfFXKL6tLskbSvvvFjJWlQ69eoRlWnIo6SXgXKpe456fiJDoJAcfavJNuoNUKBVNXKz
         qOrggYAneVZlRrtWrl+YjxaV9uUXOzYAGAtO6+Msp5HdmL6huFMzY5QywfHN13CFye1a
         V0Ht9EG2f9fqdnU1G/eEZm0GVBg7BczPI3o9kUnGrr3PvS4qH7kvBF24Ymeu5aLSDe98
         ee4w==
X-Received: by 10.50.13.175 with SMTP id i15mr1450161igc.75.1365164179988;
        Fri, 05 Apr 2013 05:16:19 -0700 (PDT)
Received: from localhost ([38.69.41.96])
        by mx.google.com with ESMTPS id p11sm2074469igr.4.2013.04.05.05.16.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 05:16:19 -0700 (PDT)
In-Reply-To: <kjlr4o$jil$1@ger.gmane.org>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220165>

Joachim Schmitz <jojo@schmitz-digital.de> writes:

> Jed Brown wrote:
>>
>> Really?  If there is no Hg Team, why bother with an Hg upstream?
>
> Huh? the counterpart of "every user" wpuld be "some users" and not "no user" 
> or "no HG team", isn't it? 

I'm not sure what you're getting at here, but the whole premise of a
two-way git-remote-X is that the users of git-remote-X have less
influence in the project than the users of X have in the project.
Usually this means that the project workflow is whatever the X users
find comfortable rather than whatever git-remote-X users prefer.

If you are the sole publisher to a remote repository, sending pull
requests to upstream, and if they are comfortable with pulling bookmarks
(much more likely if they use a pull-request model rather than a shared
repo), then force-pushing by default is more reasonable.  An imperfect
analogy is Git's push.default=simple, which is more friendly to
beginners and to those sharing a remote.

From: shawn wilson <ag4ve.us@gmail.com>
Subject: Preventing unsigned commit/merge/tag
Date: Tue, 31 Dec 2013 12:49:01 -0500
Message-ID: <CAH_OBicyrd=H1uG+_5-Jz=gK0fLsPbKKhkypWDG5yNb0umnhiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 31 18:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vy3RX-0002Yw-9W
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 18:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab3LaRtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 12:49:22 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:55343 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3LaRtW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 12:49:22 -0500
Received: by mail-ve0-f176.google.com with SMTP id oz11so6431208veb.7
        for <git@vger.kernel.org>; Tue, 31 Dec 2013 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=FR7RrvWq5swZhrsFD3v70R4T3wWRALz17MEUB+UWZmI=;
        b=wLcied0NLaQC2fEwD1m4Ypn8vTHvH7Gh8whGf5w2rrNinnYhDohKyB1U3QPtuoBdSY
         Dy/CxleAXrTpXOfAUjXuEO8UItJRQma1uC/iHv4a2Z+ckEXUeshV8hDOIkpdzJ1DhWHt
         GDRxUbiwm8U21f/biB1K5bzqQ9M5TvZVWDNmr4x0+7BbqxYmZea2XxqL6V8wVke+G5y+
         g7YZUmNOxnCkzjCK/OzJRn3YWs/xA0ljO2HnNaMmoQpuDmv5628D9g8BDCkGVFo0jI2s
         +8uJJxa6Pz2pkuGq6z2AE0FahTX0/M8A8g60Dn5083jMKg7a2q9mw2nusNckAccgIT4K
         9cqw==
X-Received: by 10.221.7.132 with SMTP id oo4mr7408537vcb.31.1388512161455;
 Tue, 31 Dec 2013 09:49:21 -0800 (PST)
Received: by 10.52.32.74 with HTTP; Tue, 31 Dec 2013 09:49:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239841>

What's the best way of doing this? I'd prefer this be a pre hook on
the server that rejects and the user has to rebase and fix their
stuff. Though, if there's some way to make it easier for users not to
mess up (other than an alias for everything which I'll probably do
anyway) that would be useful. Any ideas?

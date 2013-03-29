From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Reading remote reflogs
Date: Fri, 29 Mar 2013 23:25:28 +0100
Message-ID: <1364595928.30202.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 23:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULhkH-0005Pm-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 23:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab3C2WZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 18:25:33 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:65065 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084Ab3C2WZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 18:25:33 -0400
Received: by mail-ee0-f52.google.com with SMTP id d17so376613eek.39
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 15:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:content-type:x-mailer
         :mime-version:content-transfer-encoding:x-gm-message-state;
        bh=3VKqUNsbANrBok2RThUeCqcjDjA1DJxaTWTsRW2PTZo=;
        b=Qc/DSqCn9ng9qVp8HRg1pEtHZqbWDgWvkWwrPw6DIyLZZTMglKA3FQy2f17MD2rmoW
         zr+lJ2fuuhYMqXjUxEdsCKUqJdxn+WESPOgm6l8d71JjMaVB3+ogAtU0hT10Qadz2pPe
         aDOUUD7rTc9pyUjedlOJ6J1FFOOhvUav2mPidLIOuFZhtlJrcBgTX6TDcaeHKxD1Brwc
         sCsIXRNhc+fP+R1ueRmoPSBgKDo8dfK/mm/37QNUJ0PGDdPuw5beTCXmTLR6fVVzb9/w
         qL8zDD3inYbjTZ/1JgNQrJlqy3F9dNgymJ7I2RfyMAsDAwtJvEFMiT3nKKKI9KFI6Jei
         yrrw==
X-Received: by 10.14.173.196 with SMTP id v44mr11923780eel.29.1364595931879;
        Fri, 29 Mar 2013 15:25:31 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPS id u44sm6689502eel.7.2013.03.29.15.25.29
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 15:25:30 -0700 (PDT)
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQm9fii5LTRqNKQfus5jgwQIz2KYL60gH/oBgYLvqh0MKQdkdbze5s+ZG4O7uWJV8jvpNuNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219535>

Is it possible to somehow fetch the reflog of a remote?

I would like to delegate some post-receive actions to an automatically
mirrored clone of some repositories. Mirrored repositories don't
maintain a reflog, even with core.logAllRefUpdates = true, so to be able
to know what was pushed per push, it would need to somehow know the
reflog of the origin.

Of course a post-receive hook can send this information downstream, but
I'd like to keep the origin 'dumb' and not do that.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net

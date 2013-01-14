From: Chase Tran <chasetran7@gmail.com>
Subject: CFURLCopyResourcePropertyForKey error
Date: Mon, 14 Jan 2013 00:06:53 -0500
Message-ID: <CAM95X3aQo5JjyhC44ospEtR2+dFFwdCXGJMj9XFGncdQNhHTQg@mail.gmail.com>
References: <CAM95X3Zguz1ajaCPuztExS+2dAYBnmndkcis90aa5Mk_9+26ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 06:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucGS-00015E-CK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab3ANFGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:06:55 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35443 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab3ANFGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 00:06:55 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so907720wgb.3
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 21:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=TgoVx/U3C/ZW2N6PENsvqYIpo3JttYu6NKZPSy4Pwss=;
        b=YKllCWvqAyY7+UHyKOl5/rmuVvorey1yfjKwjS/APi4P+2j4kxKt8IofFtCe+byv/Q
         jXVnk7MUSe3gUxZraOGsANQTIvyIw+6j/cqx/1UTNCB00trmNhp1CMNxwmuSdERrKuQ4
         WyluEK5tz8hl+iTviMgtQSvdanrfjLmPxQuSKz7dk+AGGascHtahL6vGUn8yBUoMIM4t
         uBUeWG/nY5KrIkQiwB6U5cwypmq4TNEhCQDhuxg5bzifwEuRJr7FAprmqYi1kGmRM+so
         Y8N6ubIvo0R6dPDyZYvWko+7fL6bPhiGJ3bJU7nOmwSUWaIesB6/Q9qPrhKs1W+yU/Xv
         RaYQ==
X-Received: by 10.180.77.35 with SMTP id p3mr10228714wiw.18.1358140013516;
 Sun, 13 Jan 2013 21:06:53 -0800 (PST)
Received: by 10.216.236.72 with HTTP; Sun, 13 Jan 2013 21:06:53 -0800 (PST)
In-Reply-To: <CAM95X3Zguz1ajaCPuztExS+2dAYBnmndkcis90aa5Mk_9+26ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213431>

I just upgraded from Mac's Lion OS to Mac's Mountain Lion OS, and when
I run gitk i get the following error:

2013-01-13 23:16:30.206 Wish[5201:707] CFURLCopyResourcePropertyForKey
failed because it was passed this URL which has no scheme:

The issue seems to have been talked about here
http://stackoverflow.com/questions/11785126/cfurlcopyresourcepropertyforkey-failed-because-it-was-passed-this-url-which-has

I then upgraded git from version 1.7.11.3 to latest 1.8.1, and issue
still persists. Does anyone know how to fix this?

Thanks,
Chase

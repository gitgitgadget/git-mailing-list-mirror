From: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
Subject: Re: "git send-email" thru Gmail incurs few minutes delay
Date: Mon, 8 Feb 2016 05:15:55 +0200
Message-ID: <CAM_ZknUrVOyCdM32qbxOD_JVfKoqUdeo5Hywyxo3b1KfG=XhEQ@mail.gmail.com>
References: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
	<CAM_ZknWNZFxhz8ELf+sc1X3gO=H3F+GYuNkornhU9qouffj6Hw@mail.gmail.com>
	<CAO6TR8UGwqtsXSoYkxgjMy34rrkHAFJ+ALf0ufSaA8uDrDmxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrey Utkin <andrey.od.utkin@gmail.com>
To: Jeff Merkey <linux.mdb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 04:16:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aScIy-0000Vh-PV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 04:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbcBHDP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 22:15:57 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35862 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbcBHDP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 22:15:56 -0500
Received: by mail-io0-f177.google.com with SMTP id g73so182796705ioe.3
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 19:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corp-bluecherry-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kn8M5nTd5LDZBys8hO4BGhLTgPvggsB0iu6IRrmMSJo=;
        b=YbrOyS4j2PPLtv9VeKn8o/7eH7aEQTltkrM9VZWo8NoV8DttxlSvtPWfkl9uD3VrKJ
         q3/qw7RZK/mhVcrkJXT5HktZaMB8+oosohZDbeFPjdsgQHlPoKNIMpJwedCZXiJx5An8
         SaD0IY/zegzS8Y565mcUD6MYKnnz27SKxfHOgxsHq0DcNEBXgM78ENGn2X3pxYjvJ1wZ
         rMFqaWcO2tZ3asjhSzCRphq3kdzNJbsxcyenwvebK+z93a7YluuueYio1leTWuuej+Is
         cnYjN6IX6wt+y36tiLmu9/P+KNnyatjkW1et3eCR264zmKpWZCUimVNTObFXM8lh+kTz
         W8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kn8M5nTd5LDZBys8hO4BGhLTgPvggsB0iu6IRrmMSJo=;
        b=VYRYnZLUM5QPMZbcxaKs5UiUhWD/63WC3aApb/+l1aQtKqenDgRK4xuH3332Haunt5
         5aSCz43ARAF/K1HvHAsuUUw+h2IhXdHT/tcQvWBcN96Aes9c5saQNtA2cwhb2/D53nvX
         vuWEnRTKqfJwxX+GDd8OUeHgFKxdYM6LapKrd9VYe8BRCm9m7lAkbc0Qi72puKbd0HWf
         DBjllZ1qx5xGITqVbOecblfwOj3yUfdmetrYhBWUFgG+CHgObeN93nUFH99RED4opDDF
         ASeTyMI6Wiof1+UEAWsVuVsUVJgEiPbZENis88+1IVDXX8qEcKxQ8nFvQuED7nywylIG
         gcNQ==
X-Gm-Message-State: AG10YOS4RyMdelInnHMF/WEtwUhEqFVvmpAFxBanZVjuUasM26v5aGLEqDI4TksoHL1mpZtMgc1UK5+0hKLxLq/I
X-Received: by 10.107.134.208 with SMTP id q77mr28869827ioi.34.1454901355787;
 Sun, 07 Feb 2016 19:15:55 -0800 (PST)
Received: by 10.107.6.206 with HTTP; Sun, 7 Feb 2016 19:15:55 -0800 (PST)
In-Reply-To: <CAO6TR8UGwqtsXSoYkxgjMy34rrkHAFJ+ALf0ufSaA8uDrDmxqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285744>

On Mon, Feb 8, 2016 at 2:42 AM, Jeff Merkey <linux.mdb@gmail.com> wrote:
> Try this page.  Some good gmail config info.
>
> http://kernelnewbies.org/FirstKernelPatch
>
> Jeff

Thanks Jeff, but I believe there's nothing new for me. I have
successfully sent my first kernel patch a long time ago.
Also my gitconfig sendemail section follows exactly the gmail-based
example from git-send-email manpage.

-- 
Bluecherry developer.

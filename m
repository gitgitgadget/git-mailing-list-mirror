From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] blame: display a more helpful error message if the file
 was deleted
Date: Thu, 28 Jan 2016 20:10:19 -0700
Message-ID: <CAMMLpeSkBxUwH1P=rROVVXK=Z+3V=9mfhqxp8gcx9_D6eU3dTA@mail.gmail.com>
References: <1454036971-26287-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: tklauser@distanz.ch, Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOzSO-00014A-3X
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 04:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbcA2DKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 22:10:40 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35419 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcA2DKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 22:10:39 -0500
Received: by mail-wm0-f44.google.com with SMTP id r129so50815101wmr.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7csGesQkg+JGV0dI6rmJV4XROivGer8KLT+QRUJCnXU=;
        b=y8iR5SWNqvzB5js0uTrwiqREllDqPB+movCuCO4VFOq3F654c4M6k+gITv/7Fn6BAX
         N8C3INUlk/kGHlahvDnBwtz59C1mDkddreyVzbVAv5mhcw4l56SiKN9m3jcKM7HT8kuP
         bQObykH2V94k5oTWoTMaKIShKg7iTNVvD87BhRqPCA9d31K+VCUuHvJE2pe+nvmcVHIv
         yO+HjC5k8sjYtJBA22aoIehg8GUE+vtbBLO2mEGJ1e2aUUdYubswiawt6EyZWjH2WrAQ
         QxLxtpcqSBj/ZFC/gJoUTTeBNVIg1MqZ0FyzCRuAkXA+0oajsLDoQbFqjeHZdBvGUEr6
         IvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7csGesQkg+JGV0dI6rmJV4XROivGer8KLT+QRUJCnXU=;
        b=FN7ikCb3L4KV8o8XXtHg6G+rHLTageoE7CNUjcDdpjmOTBJnhPLf+97q90mSpIWgZx
         F0mHYvlCRHbSi4lctOcZPONxmO3zejEOTa6bc9jGzfA/hDaf5IQmJxPuqDRhtrepNoOz
         DLJVizJOtv84FNhbwtqsX9ViuWgiy2+dHCQzJ+4B3/xPnV0n9b9eGhqKvaR8d5cblhYW
         TDgUX1jfARgBw6kdVK/d6uotKsrhUH5IYsf59wFNgYEem+PhRdhpdWcPlYcwU7ME3TOS
         2ywV9jjw05VZFT+0UA/2vs+ef0dSMovhGHnN0Xb9oe+dMMSARHKmXc3brawInUfiXw+7
         lbbw==
X-Gm-Message-State: AG10YOR8LYGWFPPx6MQGjugQ+xmTYTL8NLDHleaGw9hFQcShWflh2kjajyoqqu6zEFbMVZAotKgPIcruxCshzw==
X-Received: by 10.28.150.215 with SMTP id y206mr6031557wmd.8.1454037038696;
 Thu, 28 Jan 2016 19:10:38 -0800 (PST)
Received: by 10.28.73.212 with HTTP; Thu, 28 Jan 2016 19:10:19 -0800 (PST)
In-Reply-To: <1454036971-26287-1-git-send-email-alexhenrie24@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285056>

Sorry, wrong patch...this issue has already been fixed

-Alex

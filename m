From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.5.0
Date: Mon, 27 Jul 2015 23:39:38 +0200
Message-ID: <CAHYJk3S-gSg3bbbv5JoxoRfkCLi9p_rOM8Z3v3njdcRYgS4cCA@mail.gmail.com>
References: <xmqqtwspgusf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Jul 27 23:39:53 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZJq7h-0006zX-0L
	for glk-linux-kernel-3@plane.gmane.org; Mon, 27 Jul 2015 23:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbbG0Vjk (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 27 Jul 2015 17:39:40 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33767 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbbG0Vjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jul 2015 17:39:39 -0400
Received: by igbpg9 with SMTP id pg9so111111757igb.0;
        Mon, 27 Jul 2015 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JF4isCM56coppNYUgP7BxcQbmUG5aqLBmqxma0Y8528=;
        b=BlKlwcw5ZTqyMeIMTIjuRII1qVaYT8G2PMxNy7rx0G+YVumrqNBOAOMyTDBdpHhmQ7
         knQe6RkGoNb+MqdbsEO/b8hOYU71w2oawqA2qNa0M/EJblSG9Tf96MzcV0ccZVHESqKN
         5+TRtvssdaSETAY6UKdpnubnElw0XWvRzaZEl0qLkrHvBj6AV5vR5yOiu27tU7UI4wA5
         ceUkHZHll8kHZZv7Yvjx7VCMxsMtHW2S3mABkN7wW93oeYZOM2IhTUsMad2/+7VKjdtw
         B0u09QvbXhaih0dY6Otw5wujK2jIMTUDz1ki/nZOMC5VVffpAKuU0yMPbmIce9Wjjwhn
         p8Zw==
X-Received: by 10.107.15.18 with SMTP id x18mr53088920ioi.167.1438033178478;
 Mon, 27 Jul 2015 14:39:38 -0700 (PDT)
Received: by 10.36.7.196 with HTTP; Mon, 27 Jul 2015 14:39:38 -0700 (PDT)
In-Reply-To: <xmqqtwspgusf.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274713>

On Mon, Jul 27, 2015 at 10:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The latest feature release Git v2.5.0 is now available at the
> usual places.  It is comprised of 583 non-merge commits since
> v2.4.0, contributed by 70 people, 21 of which are new faces.
...
> Git 2.5 Release Notes
> =====================
>
> Updates since v2.4
> ------------------
>
> UI, Workflows & Features
>
...
>
>  * A replacement for contrib/workdir/git-new-workdir that does not
>    rely on symbolic links and make sharing of objects and refs safer
>    by making the borrowee and borrowers aware of each other.
>
>    Consider this as still an experimental feature; its UI is still
>    likely to change.


It might be helpful to list what the replacement actually is in this entry.

-- 
Mikael Magnusson

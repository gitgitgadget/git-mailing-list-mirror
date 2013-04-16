From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 20:09:48 -0700
Message-ID: <20130416030948.GJ3262@elie.Belkin>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <7vbo9g15po.fsf@alter.siamese.dyndns.org>
 <vpqbo9gqcvl.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 16 05:10:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URwHV-0005Po-8e
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 05:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935551Ab3DPDJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 23:09:56 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:37399 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935212Ab3DPDJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 23:09:54 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so85651pad.25
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0DoWun2TdkrGBLYxEe8RAQEYweeiIKZQ6nYBGzAX8UU=;
        b=j0MjM+TTz8agNJWy3gvfFG9+ZCjMmez7oKABM9JxW0A7XK6/VYX2X5rARlu6WMC6VG
         lxMgg2BaOfCg3/R08TvOOsz49xoOcv9jaG42uza6+2YSZrAPelrkIEtYlOlaATfaVrtn
         bD9anZtMuD+gTD2hPLN+1vQd66swinV44mkXyY83usZNiQMUGOQ2ZhAIjq6Brq8ortHr
         u/m4/BeniFu0SZMgmxWgQd5jvsrI0flPqC9y1yvQVc463OaDLsB/SbJfw9Qm/CBAlFJj
         8pTCXEajJNfq+g1GgMEiJnNVGm6Lfhf8TnElBb31Rf/aEe0OSqup0hmJ0hYHD+Bz9d6P
         ZbzA==
X-Received: by 10.66.7.228 with SMTP id m4mr1028592paa.173.1366081793310;
        Mon, 15 Apr 2013 20:09:53 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wz9sm148249pbc.5.2013.04.15.20.09.51
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 20:09:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqbo9gqcvl.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221351>

Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Yes, that is why I said for pull-merge, --authsquash is neutral-to-better
>> and pull.autosquash is harmful.
>
> To speak from my experience: I find myself typing "git stash && git pull
> && git stash pop" relatively often.

To that end, maybe "git pull --stash" would be an easier to type option
name than "git pull --autostash".

That would also avoid the question of "What is automatically going to
happen here?  Is it going to stash only sometimes?  Is it going to
automatically stash what I pull?".

I'm not a big stash user (except "git stash --keep-index" to prepare
to test changes in the index), so I can't say much more about the
details.

Thanks,
Jonathan

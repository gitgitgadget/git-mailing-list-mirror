From: John Szakmeister <john@szakmeister.net>
Subject: Re: A better git log --graph?
Date: Thu, 8 Jan 2015 06:59:05 -0500
Message-ID: <CAEBDL5XgVAKp0AAxtKPx20BTkO-F9P62=5MxHVdtBVWTXoNRTw@mail.gmail.com>
References: <m8jfg5$dsp$1@ger.gmane.org>
	<95FA7666-4031-48FE-B9F7-DC8BB969426C@gmail.com>
	<54AE6C77.8060303@thregr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Yuri D'Elia" <wavexx@thregr.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 13:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9BkA-0001Ez-30
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 12:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbbAHL7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 06:59:08 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:36825 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbbAHL7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 06:59:07 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so8681148lab.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0iL6NkDd4R1D+6586i6/K+S6Qd6+Nsg5G3XrlOhhKTQ=;
        b=vhazl2k/q+a3xmnU2GZAtY7L0y8WYCPzsnH8CdcnhAw1ykkdkoUwx13IaB1ptLC7qq
         G+WttQR17A5hXYQgE/oS5XdJy2taoX7GRCMP73pQw8e4dWy9G1rZd5Q2xOGQbg55Wc9k
         hvfc0OGiXbqNrDQIj7iqB5MJoAXRfxoFH4iaqju5hb7flqGq5PWWNtZKrqwzE1nSoAVh
         3sn06SLsZMPtpHoBgUbCrAkXA6CkCvt5rvRwxJCY8wM7/cB0rYAj9KiW4WTkCidujWKS
         lA49cWgGIuh0ilfNBKW4OPPq2GCP4xVPpe4gAnxWPU/NsHYVvDvVi/Uia0FGe8mGncSa
         aucg==
X-Received: by 10.152.43.49 with SMTP id t17mr13106827lal.52.1420718345777;
 Thu, 08 Jan 2015 03:59:05 -0800 (PST)
Received: by 10.25.166.75 with HTTP; Thu, 8 Jan 2015 03:59:05 -0800 (PST)
In-Reply-To: <54AE6C77.8060303@thregr.org>
X-Google-Sender-Auth: YE86JlW0QH7iXupDEToBmU33aW8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262193>

On Thu, Jan 8, 2015 at 6:39 AM, Yuri D'Elia <wavexx@thregr.org> wrote:
[snip]
> I usually never use frontends. The notable exception is "tig" when I
> want to get a feeling of the status of several branches and/or "blame"
> some files. It haves a lot of typing. That being said, I tried gitk, but
> assumed it was also parsing --graph layout.

Try "gitk --date-order".  I find it gives me the picture I really want
to see.  I've aliased it to "git k" in my gitconfig because I find it
very valuable.

-John

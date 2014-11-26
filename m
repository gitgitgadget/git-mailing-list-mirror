From: Woody Gilk <woody.gilk@gmail.com>
Subject: Re: git file listing is inconsistent
Date: Wed, 26 Nov 2014 16:01:51 -0600
Message-ID: <CAGOJM6KokBxxaWn=j03CBEp0B5yjWWyMxS=H6KhXEW0r-OPjLw@mail.gmail.com>
References: <CAGOJM6+DTSn2qa-KTWceqyraaugX_YVZhirkdc+t+cDfFB4OyQ@mail.gmail.com>
 <20141126215520.GS6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 23:02:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtkfX-0000A3-Il
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 23:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbaKZWCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 17:02:34 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46074 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbaKZWCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 17:02:32 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so3488948iec.22
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3nBle/GGsHuNOBP4hWEE/QzQhEX9M3BgM/KnMgA7Rbs=;
        b=AqiJ0ZBw+mUcFJDcrthk0Zkg2VLyRv7sMVp291cy6N18Viddzjvci6P5UyR/uK7qIa
         7tnpRZoXaUfKOu6z18gi4mRsYbdqaKZqsFdKqFDqTqEYUW8lqYjNVFJ8jnl9Um3ipCFp
         f9TyHX7Pe/7SY/B0lNM1jaA9MSTXKTlAhD1gdrckouUa9hIoz/4LdqtCv6w4pCkfo28x
         /Nv9EOAhiHdj6m23GAGqVE7QuDhfKH8gBb+g6zI6Lm0SWw/m/VY7a0BMhHIFEnqB5afE
         8OCYm2mOAEZzOKGppMWlzcjLlBNHu444TfqRrGtMKogyQEJi2lDjh+0H0YKjTAcfXM3f
         sn0g==
X-Received: by 10.43.73.71 with SMTP id yr7mr6368620icb.32.1417039352070; Wed,
 26 Nov 2014 14:02:32 -0800 (PST)
Received: by 10.50.85.18 with HTTP; Wed, 26 Nov 2014 14:01:51 -0800 (PST)
In-Reply-To: <20141126215520.GS6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260314>

Jonathan,

On Wed, Nov 26, 2014 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Actually, 'git grep -h' tells me that git grep --name-only is already
> accepted as a synonym for --files-with-matches, ever since

You are absolutely right, it was a typo (and then not RTFM the
resulting help) on my part that caused the confusion.

Nothing needs to change here. :)
--
Woody Gilk
http://about.me/shadowhand

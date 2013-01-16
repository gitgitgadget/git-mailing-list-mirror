From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 17/19] fixup! reset $sha1 $pathspec: require $sha1 only
 to be treeish
Date: Wed, 16 Jan 2013 10:08:59 -0800
Message-ID: <CANiSa6hyWGyn5-UGF6_3KPw7ut6TOqZU+b=xLH7DBpa+tW8sZw@mail.gmail.com>
References: <1358228871-7142-18-git-send-email-martinvonz@gmail.com>
	<1358359235-10213-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXQR-0001se-Am
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab3APSJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:09:01 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61456 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab3APSJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:09:00 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so3103802iej.32
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=h0J0ssubNY+4kJrJZlQIA9INi2LyP9HXoSTntoixTmU=;
        b=gXz1XDq7WGD2QKvqUxv35Fb1tK8gOZGSxOzygj62u58K++Lu3DnhnGLpiofmy04I3G
         nItVoKV99t3YdHC/uXk7b0bbPLXQLJvCUEwH9DzpdnnYo6S4MFUblBflKGXT2b05Z0+z
         dWnflDTlNmf4aHYXN/wgwtG/1wta02sHYgqVKImU+1kIZOlgTYAFp113MiP9zTReSIN0
         n98y7GDJsvULAyFLv6Q1c898oSotvddFlZV7Ey+Cf9beoVwbAqTFf9K+4+HsX7LzBbkb
         pwd8Fo4IAIUQzQtDCiV+ou2UeIL2btDEGQ8VRTJ3QYDlMjPxF3BkyUYLO5mKxK83jr1s
         mT+w==
X-Received: by 10.42.153.70 with SMTP id l6mr1253592icw.50.1358359740023; Wed,
 16 Jan 2013 10:09:00 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Wed, 16 Jan 2013 10:08:59 -0800 (PST)
In-Reply-To: <1358359235-10213-1-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213786>

On Wed, Jan 16, 2013 at 10:00 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> ---
>
> Sorry, I forgot the documentation updates. I hope this looks ok. Can
> you squash this in, Junio? Thanks.

I see the series just entered 'next', so I guess it would have to go
on top then. Perhaps with a commit message like as simple as the
following. Let me know if you prefer it to be resent as a proper
patch. Sorry about the noise.

reset: update documentation to require only tree-ish with paths

When resetting with paths, we no longer require a commit argument, but
only a tree-ish. Update the documentation and synopsis accordingly.

From: Bernd Jendrissek <bernd.jendrissek@gmail.com>
Subject: Re: git diff vs git diff-files
Date: Mon, 13 Aug 2012 18:06:04 +0200
Message-ID: <CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	<87fw7qhm31.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 13 18:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0x9g-0006By-PA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 18:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab2HMQGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 12:06:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54525 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab2HMQGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 12:06:05 -0400
Received: by obbuo13 with SMTP id uo13so7047285obb.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=25d49US7mvlyjwKM4qyuIKYGtb/ujMYQKxeekAMXzyQ=;
        b=TBhpxAAJp/ZNsLY3B2RlJYT9Fa6tZ203evGchY7tIF1PCvATsMMJveohVzYW4/Zbxq
         /SyPZBsA0g800PUayz53oubNvmlamafxzdvxr/gXp0tgjunzKVj+gNVZhqCWNqFihRUp
         +8YoNfc18Yy/W5lUaLe7P0FE1sSvXEZg8VojyXYg6KLkf1UbmBkuCw4Duin3g+97eg2C
         gvu/+BBC08/5ngjENaDiWpb3ieFRnx32fGzk6rMHCyEWL2zeY9pnlyhbEFvvXGa6Zeip
         pJwSv6nm4BxTdOTI8nDupk9USB2nDPpW808oXaS7r1zLxxVVsn+7M7iqhGLXi72pJNZ7
         8jug==
Received: by 10.182.144.104 with SMTP id sl8mr12946958obb.74.1344873964245;
 Mon, 13 Aug 2012 09:06:04 -0700 (PDT)
Received: by 10.182.46.165 with HTTP; Mon, 13 Aug 2012 09:06:04 -0700 (PDT)
In-Reply-To: <87fw7qhm31.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203340>

On Mon, Aug 13, 2012 at 5:02 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Can you share this repository?

This weird behaviour doesn't even survive making a copy (cp -a) of the
whole repository, so I very much doubt making it available would be
illuminative. My disk's SMART data seems okay. The weird-quotient just
rose a bit.

Besides, .git/ is 60MB and my upload speed is 128kbps. A bit inconvenient.

> Or at least the pre- and post-change
> files, transferred in such a way that there won't be any whitespace
> damage (your snippets above show obvious damage).  You can use

http://www.bpj-code.co.za/downloads.php/bugs/TwoStageAmp-output.net?text
contains the output from git show a5ee1e7. Leave off the ?text for an
application/octet-stream download.

That file (with the Q1 line present) is consistent with the earlier
commit that added the file. It's diff-files that's lying.

> Do you have any diff config that could be of interest?  A textconv
> filter would be an obvious example that could produce the above, but
> perhaps you could just look at

Nothing that fancy. I have just diff.color = auto and user.* = blah in
global config, and similarly benign config in the repository.

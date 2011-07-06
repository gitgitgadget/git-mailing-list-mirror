From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v7 12/16] mingw: import poll-emulation from gnulib
Date: Wed, 6 Jul 2011 11:06:05 +0200
Message-ID: <CABPQNSb8UNTA05=mKK-DyGHXo3n-W_i1CanL9duO8X15JOqE6Q@mail.gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com> <1288834524-2400-13-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 06 11:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeO4K-0002W4-4i
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab1GFJGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 05:06:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57572 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab1GFJGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 05:06:47 -0400
Received: by pvg12 with SMTP id 12so5856547pvg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LozmpiHkf7njT6OfH9AFke7z381EY8mUYFkfUis5jMI=;
        b=YHlKhld6to5wrdFT6V4ufBkE+Qp8aK9hIC3ot1C/V/216XD775se6P9RdGVzxvRDED
         rfwPa/T7FRX8ZXn0MqWx6BGaU4VG7CepfBLeKdk+66/DG0A5kaebjidIdEPaFYBxY2xa
         Z0SQtRyR1uy71D6dISADxFNh7sG/aOfr3EipA=
Received: by 10.68.49.234 with SMTP id x10mr3657130pbn.424.1309943205230; Wed,
 06 Jul 2011 02:06:45 -0700 (PDT)
Received: by 10.68.43.198 with HTTP; Wed, 6 Jul 2011 02:06:05 -0700 (PDT)
In-Reply-To: <1288834524-2400-13-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176666>

On Thu, Nov 4, 2010 at 2:35 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> copy lib/poll.c and lib/poll.in.h verbatim from commit 0a05120 in
> git://git.savannah.gnu.org/gnulib.git to compat/win32/sys/poll.[ch]
>
> To upgrade this code in the future, branch out from this commit, copy
> new versions of the files above on top, and merge back the result.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

It seems there's been some white-space damage when this patch was
applied (some spaces have been dropped, they were there in the
original); it doesn't match the imported gnulib source code any more.
Unfortunate because the commit message claims it's verbatim, but
probably not a big deal.

I'm in the process of patching up gnulib, and did a test-update of the
gnulib code. The large diff baffled me a bit at first ;)

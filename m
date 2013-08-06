From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [TIG][PATCH 0/3] Refactoring of the log view
Date: Tue, 6 Aug 2013 00:00:19 -0400
Message-ID: <CAFuPQ1KKAM4s7h4oiUdfZ3UZXNZG7jkXYi=P38aSjJNSGayaNg@mail.gmail.com>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Tue Aug 06 06:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6YRx-0000bv-0E
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 06:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab3HFEAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 00:00:41 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:43853 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab3HFEAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 00:00:40 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so8063432oag.36
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 21:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ljiXqVS5YNsGJv5FUtsbk0jwCc8y7HNpWjG7Aa79Hxs=;
        b=byP47o2rXqhwTf9MKxIYN82pIZv9+QWUWMVLD4XOA9X3qZQGRce3V6zKZ1kI5pGZRq
         HwbJ5ywDJa1s6NcbfMM3bkylT5j0v6XNlICCilCnDMfcny4j5zjmLIyTV2fZhEMSsgpf
         GoT6URyRBppzI3NOsS/AxidifGgZGnVLglawcEFO6xkchd7baY7bvnZro5tGdA3q6G/7
         xP1MnV7prTcC+ZRXV1LZzUTQVO4JEA5nlpo472n/nUMxIXa+iwkLHiLuUMU8H/pVWJhl
         AMvUHuoqDlcB933wv63Qrv0O5YxZEPPlQdK9cjDUa+THxJgBk57lEdDpWQnCgCVqEOzT
         Iq8A==
X-Received: by 10.60.117.34 with SMTP id kb2mr16706516oeb.54.1375761640041;
 Mon, 05 Aug 2013 21:00:40 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Mon, 5 Aug 2013 21:00:19 -0700 (PDT)
In-Reply-To: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Google-Sender-Auth: qabIp91CvSYlI_HvrLJieduXY5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231716>

On Fri, Aug 2, 2013 at 8:23 PM, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> These set of patches refactor the log view to provide a behaviour that
> is quite similar to, say, e-mail with Mutt. The key improvements are:
>
> - The current commit is inferred based on the context. For example, if
>   you focus on the commit message of a particular commit, the correct
>   commit is inferred automagically.
>
> - Scrolling the log view when the diff is open shows the correct
>   commit on the screen, rather than have to scroll up and cross the
>   commit line to display the screen.

Thanks, great improvements. I am still considering whether to queue
them until after the next release or include them.

> I have decided to revert 888611dd5d407775245d574a3dc5c01b5963a5ba,
> since the behaviour with the updated scrolling pattern is much more
> consistent.

OK, makes sense.

The next step will be to find out how to highlight the diff stat in
the log view. :-D

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-status: Use "-sb" options by default?
Date: Sun, 11 Nov 2012 16:20:14 +0530
Message-ID: <CALkWK0mjbZtvMrCnf1Du1aTiPPq10wmiTJAf=AW8ECwPiYzBwQ@mail.gmail.com>
References: <1352545457.32390.YahooMailNeo@web160304.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Timrod <jtimrod@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXV7p-0001Cy-E8
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab2KKKug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 05:50:36 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40157 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab2KKKuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:50:35 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3538758wgb.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VtX+zMy9RGyOYrrgANaOgcQekvr1YimlTNbbf+W376s=;
        b=iz31WusYW33596/HlYjjsubjIQoDaw+yNNbsB/kR8zQJSrLWQEYR2XilvDORtI8+vK
         g7EUw4Da1xj1SoE//J2A8Bc5C+cvbTjKIX8yEefcFrrGeVeSFapcBp8FUYhJ1Yah1lmF
         GvEmU2HHzhWk/5N5/2QzEQjgqcfksOmGA8F2RNRfNiPPenlekYYjhs5bnw3QYMsAFhrr
         1SCqVXKHaWAIFlmEYV8QNideWAB3oZO05TuU8HdsWo4VFvK9YMEeZG3zoL4ydGveOvS0
         syLr9Liy9vNkxK2R9YVW1kZczXflN+i48K2IbNntpJr0zQJurV7HsBiBAnNPK0sJ3onA
         +Q2w==
Received: by 10.216.200.163 with SMTP id z35mr6460430wen.53.1352631034440;
 Sun, 11 Nov 2012 02:50:34 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 02:50:14 -0800 (PST)
In-Reply-To: <1352545457.32390.YahooMailNeo@web160304.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209336>

Jason Timrod wrote:
> I'm looking for a way to make the "-sb" options to git-status the default somehow.

I've aliased `git status` to `git status -sb` too, and I think it's a
very sensible default; who wants to see

  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)

over and over again?

Maybe a status.shortWithBranch is in order?  However, I don't know if
we can have one configuration option that turns on both `-s` and `-b`.

Ram

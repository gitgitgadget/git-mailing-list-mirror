From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC] submodule: fix handling of supermodules with relative
 origin URLs.
Date: Sat, 19 May 2012 07:45:42 +1000
Message-ID: <CAH3AnrqXbUuKKWzAf9_xHtu-c5sYGRf5dj+CqOmOmesnwh8=pg@mail.gmail.com>
References: <AH3Anrr6mLVedBPcgfVwy=5KRjUgdp5W8P0DQ3qaX_UjH-npDw@mail.gmail.com>
	<1337343220-26717-1-git-send-email-jon.seymour@gmail.com>
	<4FB6A9CB.5050702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri May 18 23:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVUze-00076w-B6
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 23:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968052Ab2ERVpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 17:45:45 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59443 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967680Ab2ERVpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 17:45:44 -0400
Received: by weyu7 with SMTP id u7so2071481wey.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mXBkUKwi5NgyVh5dsZ22xqfZRHaefoNywkf78Um+Pgk=;
        b=TaDB59UbLqpmNZ5uabX/gREeH2hlFg/8KcFFGVMFTquyzfs3pjq9Cw2IzJxboISHny
         81QDcOlgIC92nMLPIJwpwxYF/ndoTIo0YLVXGINhpmduddUzCsvXdzx3Q7WN2Mw1tuMO
         M8KG/9WC+K+KMy3CYIWTmOqVEBAVGRyPpeikpina9JcCHYnzv2glFRmXFt5qGcJLu7L8
         iJpVbe52a7l29gbuZZBmMZZ7es7AC4k4aQ9m2aQQ5bSr2nvitWtNJtp/IZlIT86+72v/
         t2nUeCZi97F2hphN+rJ5/+OpSd+DdxdRrKG0XthTtUt9iTnMp5+SC2DpseS1zIxpcO5V
         jgWQ==
Received: by 10.180.86.197 with SMTP id r5mr5115314wiz.21.1337377542892; Fri,
 18 May 2012 14:45:42 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Fri, 18 May 2012 14:45:42 -0700 (PDT)
In-Reply-To: <4FB6A9CB.5050702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197976>

On Sat, May 19, 2012 at 5:58 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> This version of the patch does break some existing tests, but your
> follow up suggests you already found that out yourself ;-)
>

Actually, that was just by reading  the patch and noticing odd-ness. I
realise now that I snuck in that bogus edit after I had run the tests
which were otherwise clean - d'oh.

>
> Me thinks up_path should be set in the case below, which is the only
> place where it is used.

Ok.

>
> Isn't sm_path already set correctly here? I think this line should
> be dropped.
>

Yes, good point. Thanks.

>
> Same here.
>

Thanks.

>
> Other than that the patch looks fine.

Thanks for the review - I'll add some tests for the new behaviour.

jon.

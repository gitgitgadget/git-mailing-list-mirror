From: John Szakmeister <john@szakmeister.net>
Subject: Re: git-draw - draws nearly the full content of a tiny git repository
 as a graph
Date: Thu, 30 Jan 2014 05:05:44 -0500
Message-ID: <CAEBDL5Wc7KT7FJ2f8bSouTGGCVdjm5TChrauQWrWj1k0ajFyQA@mail.gmail.com>
References: <CAL44uTjD05k4T+wN+TF1oyS162x6OB67pL0MidG5zDYs7qu+5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Flo <sensorflo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 11:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8obI-0007nT-BO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 11:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaA3KL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 05:11:56 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:38910 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaA3KLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 05:11:55 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2014 05:11:55 EST
Received: by mail-yk0-f177.google.com with SMTP id 19so14751046ykq.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5TXNkEuuaXMbm/OtXJd0V+Zkn5BOMQTYudvasncaFII=;
        b=FXdIVgDLxXdpRL3nlY12XCdltDThBisMoh3LDJc58PJjatSEaMBGJNzDC4AV3PNMOa
         Aj7vm3A4fOyguPdHSW+2kNIJ7xcE2N0uy/a+Et48BT+U00RuMwnmqmdywjUeHA3n6HnD
         Kaeecb8nY8xCNq1SSvb5i8DocBwe429pexMgIO8yk4w5/kw7PglJ6B5Zw5cyW8i1ug8y
         zlM74f7Q/Sn2b2hMZPwYgnDWksMp4VA4xjS/JugUTk0pLrNdWkyvrMmWrFczhKtmGXSF
         tHJP4X9qkDChqOP2eErlgzZ5Kk4N4QLi7mUTpp1Clg+qCciTXhR9LTdRR+ZF461MXlcz
         0w+g==
X-Received: by 10.236.51.71 with SMTP id a47mr12373273yhc.22.1391076344686;
 Thu, 30 Jan 2014 02:05:44 -0800 (PST)
Received: by 10.170.220.2 with HTTP; Thu, 30 Jan 2014 02:05:44 -0800 (PST)
In-Reply-To: <CAL44uTjD05k4T+wN+TF1oyS162x6OB67pL0MidG5zDYs7qu+5g@mail.gmail.com>
X-Google-Sender-Auth: iW74zOn9z61PpAZn-BbVFzKbiKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241264>

On Wed, Jan 29, 2014 at 4:21 PM, Flo <sensorflo@gmail.com> wrote:
> I just want to present a small tool I wrote. I use it at work to have
> a tool visualizing the Git basic concepts and data structures which
> "are really really really simple" (Linus' words). That helps me
> teaching my colleagues about Git and answering their questions when
> Git did not behave as they expected.
>
> https://github.com/sensorflo/git-draw/wiki

Very nice!  Thank you!

I tried it on a couple of my test repos that I use when teaching
people and it appears you need to munge branch names that contain
hyphens in the generated dot file, or dot fails to parse the file.

Otherwise, it's a neat tool.  Thanks again!

-John

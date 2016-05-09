From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 20:11:13 +0200
Message-ID: <CALR6jEhR7cAGTnv=VQACrSLh0CEW37oPb9gZ5W+dwz7H8irodA@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	<CAPig+cQS32O0jxJkWRB2r5vQw3LHVeD_vK+3O9Q3ominO38S2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 09 20:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpeJ-0000PY-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcEISLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 14:11:15 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35462 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbcEISLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 14:11:14 -0400
Received: by mail-yw0-f176.google.com with SMTP id g133so257508424ywb.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DcI00L2QqR5E2LV8pbhW30X3jhgep4TvTE/865yQaIQ=;
        b=FQaS2PnUR/rR6jG+bYb+vp3BRmOdGwqXC80EjsZID0Bua+nfYqQOIjQlROc3lnbZw2
         GVph7cG8mC3aATuRB5hMdvtZUJNintAO9fmpH20V1XCS1AukMeySoTQIZUHB5dIXw8C/
         iB5OqCbG0qnANUdQNhdJXM0QLiauU1W5m49j7F7T5j2ibAp8oWY1uAMVXdDsCMNDqzFH
         5zZyBrdV1WjNcwjMusV1i3BPDFuSyFI3PpEYqyLIreS17Nszx5HVfeDQ8Ua7CKfGWL7I
         1+lMbiTXU2YhdGK7BmiCCzJWp8YbFW+PCcopa9Uwmcv9ZbRqenzS6T4YrVgdemMoRpel
         HUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DcI00L2QqR5E2LV8pbhW30X3jhgep4TvTE/865yQaIQ=;
        b=JA2sfr/UlByMfMAM8syOfGrBnYGtwCCdPwb4ir16ZvNmZ9Xu2gY42IDDz2/VxiCLZp
         PvJ7AR3l23cyi+tYdf69pbwhBBKe1CQVK/xRUAL0izrc4JOzoR3Pky7mC+twVuqbDzQ0
         heeKCeyHfhYvuMI1Hu1upCogL3yrj2LMAg8Y1Uftr8jgk1L54Mtd1c35iyefKH3eH5p4
         hceIokK7Isyy1JP3ZekpbknBuR30wtngctGDcgPFzVy5JvBxjqfT6Sp4fz6EAyjHMlcd
         dxhDE3VVMhuTcPo/BEK8kifVS8ddFlIAI/ihyY0KXMA2TKivuqW0ac0SVOQMA6P7TCoc
         KYGA==
X-Gm-Message-State: AOPr4FVCDotrqDtj7XSsR3zYInqihYBuUma+BL2iZXbTXMGKjZgRoeFDfNTjd94eehgsEgIZgoFBm8DFDUcUXg==
X-Received: by 10.129.124.8 with SMTP id x8mr19980405ywc.200.1462817473977;
 Mon, 09 May 2016 11:11:13 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 9 May 2016 11:11:13 -0700 (PDT)
In-Reply-To: <CAPig+cQS32O0jxJkWRB2r5vQw3LHVeD_vK+3O9Q3ominO38S2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294033>

I'm currently concentrating on finding problems with my setup... this
is already a tough job :-)
I'm a git beginner, and Documentation/SubmittingPatches would keep me
busy for a week.
So anybody feel free to submit this thingy.

Armin

From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Wed, 13 Feb 2013 11:21:03 +1100
Message-ID: <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Q6g-0001gK-1u
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 01:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759221Ab3BMAV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 19:21:26 -0500
Received: from mail-vb0-f42.google.com ([209.85.212.42]:32850 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab3BMAVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 19:21:25 -0500
Received: by mail-vb0-f42.google.com with SMTP id ff1so437851vbb.15
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qUGWKmgCs389GBFkLnlvHQEgWd8J5t7wN84RYeI2Clw=;
        b=zd9ZrWXMr89LJipYEY+fIbymsH4APaA19UJgRG68XRCzF0mg+rUHhAxsW7pyOQJWkM
         MW1RrdLvTikrA0ZDiJm3VFUydx4xoRd7tfAqGafKY+eLQgifu34gHrC4tKFBUC9pjnYL
         HLhdaAWZbo2xcK9EBZpkTm0xRNAaUCzV4hLYO0whr6+BwaljgHNSfK2l3A31MHk7a6N7
         ZJnBE/9qrqcgOPdHmE3ZQuvha6LC3mDhp6KNIrJbRkq5iDVOmYepn1j4o3GTD7O5j/pa
         gBdJ3XCLHTxlNTY5bkbG/qxnObLh+tUb1XRAjZlKvaGCVxDVRfgeATJFIPDTPg8nmJrV
         lAUA==
X-Received: by 10.220.156.75 with SMTP id v11mr26854664vcw.1.1360714884726;
 Tue, 12 Feb 2013 16:21:24 -0800 (PST)
Received: by 10.220.107.82 with HTTP; Tue, 12 Feb 2013 16:21:03 -0800 (PST)
In-Reply-To: <7v621xdql8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216231>

On 13 February 2013 11:06, Junio C Hamano <gitster@pobox.com> wrote:
> * jc/add-delete-default (2012-08-13) 1 commit
>  - git add: notice removal of tracked paths by default
>
>  "git add dir/" updated modified files and added new files, but does
>  not notice removed files, which may be "Huh?" to some users.  They
>  can of course use "git add -A dir/", but why should they?
>
>  Resurrected from graveyard, as I thought it was a worthwhile thing
>  to do in the longer term.
>
>  Stalled mostly due to lack of responses.

What do you need to progress this?

I have been bitten by this before (the 'huh?' reaction) and think the
previous discussions and patch look reasonable. Does it need testing?
Further input??

Regards,

Andrew Ardill

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Add Travis CI support
Date: Mon, 12 Oct 2015 09:07:38 -0700
Message-ID: <xmqqpp0km5o5.fsf@gitster.mtv.corp.google.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 12 18:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlfdZ-0000pc-3z
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 18:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbbJLQHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 12:07:41 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33462 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbJLQHk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 12:07:40 -0400
Received: by pabrc13 with SMTP id rc13so22681115pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vm5wxmK8vM72tGaQQkAt4Zi1P2409yIa4W2jcbiqkww=;
        b=MANdTd8kZcGp3er1tv3jpA4vvu+Bx6tyicwNGbRVRPVqW0iLZZ4wBsqdILiTBBhFb/
         lXNYD/exzQPXTVD73CtvBJu2eW5m+6/dsWcNYRg7R2MEnBvmU8UNBqVQ2a0ig9DMCl6H
         AjsATpIc+Qh/2Cqe7x5GIsamxD/k1EuHycCOM8WMSIjDQ36TqH9guxq0R3fIiCt78Fcb
         D3Q6LAKscuxJ2wwXsHWjHnE540E5tX6D8zdZn+lHc3BR56Uo3N3f6Gr2tBmL8e6Vtv+t
         HRjinv/IASI5MmriyM23kRKxb7ZTb8HXrnPDBAnM+m2qtzviJKx0QiQ3PKcvEq9HGW+0
         JsuQ==
X-Received: by 10.68.68.205 with SMTP id y13mr24151117pbt.46.1444666060117;
        Mon, 12 Oct 2015 09:07:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id xz5sm19179912pbb.12.2015.10.12.09.07.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 09:07:39 -0700 (PDT)
In-Reply-To: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 11 Oct 2015 10:54:59
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279380>

larsxschneider@gmail.com writes:

> Lars Schneider (3):
>   Add Travis CI support
>   git-p4: Improve test case portability for t9815 git-p4-submit-fail
>   git-p4: Skip t9819 test case on case insensitive file systems

Can you make this two separate series?  It seems Luke is happy with
the p4 bits and I think it makes sense to have it as a separate
series and apply sooner, while those who are interested in and well
versed in Travis to help polishing the first one.

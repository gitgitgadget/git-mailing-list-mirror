From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Sun, 26 Jul 2015 00:08:40 -0400
Message-ID: <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 06:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJDFA-0003FK-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 06:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbbGZEIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 00:08:41 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33385 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbbGZEIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 00:08:41 -0400
Received: by ykfw194 with SMTP id w194so47089414ykf.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CZI2nVrRkPaSTaQxQGKVWmiRW+m0tGoE00G+aUCIn9Q=;
        b=XAjsjwDU1/V8nMsBzcf9UgmcTNjRhCpF8WtGanWzJecnDUqpFlTB+52Zbw0McCldp3
         qWKLsOg3zYuY3GrAd+eLknj0rEfnEK1Xuiz9kY5VibdZB4m+nEt/4c2FWFsjTzBtFn3+
         9efJVs4rF9KDAt3wQYFdWum0PvOoZ1lWDeV2jYfV39o7QUfiN3zZk94Kl3+UzsymYZCu
         /vGuuvUbZLNE7y8DFhCw58mA3t/TO/Fwxgc8vbIswTxqTtWrVeX7MvpFWeq0auuJHrEV
         khp/oVVZoBRP974/CU9lou7mP2NN4oRVTnnAB1ubSdXxBgLsOL+JoKDF37KW722tAKoP
         iHwA==
X-Received: by 10.129.50.140 with SMTP id y134mr23130526ywy.39.1437883720202;
 Sat, 25 Jul 2015 21:08:40 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 25 Jul 2015 21:08:40 -0700 (PDT)
In-Reply-To: <1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: C-R68hfL2wXMWz7C-pb92lFGZyo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274625>

On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a new atom "align" and support %(align:X) where X is a number.
> This will align the preceeding atom value to the left followed by

Do you mean "succeeding" or "following" or "next" (or something)
rather than "preceding"?

> spaces for a total length of X characters. If X is less than the item
> size, the entire atom value is printed.

Isn't this a pad-right operation? If so, should this be called
%(padright:X) or %(pad:right:X)?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

Also, it is helpful to reviewers if you include an interdiff at the
bottom of your cover letter showing the changes from one version to
another. You can generate an interdiff with "git diff branchname-v4
branchname-v5", for instance.

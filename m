From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Tue, 14 May 2013 00:15:45 +0530
Message-ID: <CALkWK0nygD7dpwZkXYMuXHhVZpRzb968wAYq-xZrj=y7duL1ZQ@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-5-git-send-email-artagnon@gmail.com> <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
 <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
 <7v61ymop61.fsf@alter.siamese.dyndns.org> <CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
 <7vppwun5zk.fsf@alter.siamese.dyndns.org> <CALkWK0nmDopEVArofKt42u5JHRBXmGiHP051jhMxtaihWLu95A@mail.gmail.com>
 <7vli7in2wq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 20:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbxlW-0001ms-O0
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab3EMSq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 14:46:26 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47374 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3EMSqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:46:25 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so13127592iec.34
        for <git@vger.kernel.org>; Mon, 13 May 2013 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZNX5GSz04FUr1KWYB0ouDoT8ggLjAC9rePDTj3SYpU0=;
        b=A3rku4V333+qIIAVpV9m3O0/UdcZX8uPBFdfZHkRo8ZmElntkkRw55TGUcwdDRy2zu
         XpVD8Kqtuxj8hx43S6/kW43J9Z5l0FamYYWzLwH7UziGisAr+OOJwkCk3OlQV7CHiNeJ
         8XleacNyiJihWJiZqXXBQNHI9Knn0RGROLISE9o7aO4EDEk3Phfs7qkHXkxiIE5iFna4
         iNFfJyXsWtgtaUONoeFQaNEpZggUsmg0Y9DGOE2OuGJX6aCupm2ELFjnAS/uNofB85OT
         Q1gbbWAZaWqCugCf25ayMFoef/ts/f8lDmvoGFZvosl3WVw0ScLgD1D5YxQO/yAsFlj+
         gGlQ==
X-Received: by 10.50.33.19 with SMTP id n19mr6149920igi.44.1368470785490; Mon,
 13 May 2013 11:46:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 11:45:45 -0700 (PDT)
In-Reply-To: <7vli7in2wq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224188>

Junio C Hamano wrote:
> That is not a valid question.

I was just asking to see if you could think of something.  I just did:
named stashes (each one has a different ref/ reflog) for internal use.

Sure, we'll go with the -m -e approach.

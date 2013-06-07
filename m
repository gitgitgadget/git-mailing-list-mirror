From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sat, 8 Jun 2013 01:17:28 +0530
Message-ID: <CALkWK0mkQqopPBrmO1e20nN_kbNLgcR4cA9z7nOfA4q_2GxvMg@mail.gmail.com>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org> <20130607000006.GA25731@goldbirke>
 <7vli6mwx07.fsf@alter.siamese.dyndns.org> <20130607193444.GB31625@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2dy-0007JP-VC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab3FGTsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 15:48:10 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:61091 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab3FGTsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 15:48:09 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so11965650iej.29
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Fcx4dKFZ1CLfc7vbAw8+p9Ln4682yv9QeimFy1VKlxQ=;
        b=yH1y1Pvue34WG5JJncmxUYf9QRMihgGuZb3zmh9S0gk+zgqOYuAoU/FhDdqFsRyylY
         1mVuhjIMvp/x+jB+1fnm8IHyX7q+KW6E2NdbORaYB/oI6QQl20b7jdLqRH8vbrP4wik+
         raVTpKEKw3DASTxMxyc4g2Lz3O30uHODrEvs/H6PZWSJ3rHErWS/kyye98DmOhta/5ZQ
         wMfGvDm+UZHvxTaOP5rU7flKqYXpxB69IS2bhDjedJMjaNRclYR6Yc2L3noyZfLveqtX
         QSO1LpXvqVNLTmH+LXqjjrA7qyTzzKyx9saRcnFF64gcaII2oLv7vuMYG+Egqmn2lnTD
         1xwQ==
X-Received: by 10.50.171.161 with SMTP id av1mr61177igc.104.1370634489061;
 Fri, 07 Jun 2013 12:48:09 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 12:47:28 -0700 (PDT)
In-Reply-To: <20130607193444.GB31625@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226690>

SZEDER G=C3=A1bor wrote:
> because nowadays __git_complete_file() is a wrapper around
> __git_complete_revlist_file().

What?  It was never anything different from a poorly-named alias for
__git_complete_revlist_file().  You have already agreed that
__git_complete_file() is a horrible name, so why not deprecate it?
Whom is this confusion benefiting, and how is it any "cleaner"?  If
you're arguing about expanding __git_complete_file(), don't do that:
just write a new function and give it a proper name.

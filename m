From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Tue, 31 Aug 2010 21:28:17 -0500
Message-ID: <AANLkTimwGYM-nJTks+E5ez_hGkmE=fcutPKfd8_kfEvs@mail.gmail.com>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com> <AANLkTiktRqX+fhFW3mN_b5tnbKzDJY86fLpKVth7RpY9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 04:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqd4F-0006JS-Ni
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 04:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab0IAC2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 22:28:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56158 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0IAC2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 22:28:45 -0400
Received: by iwn5 with SMTP id 5so6372338iwn.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 19:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=DNj4EuqIGZU223fInfaXhN6hcKvqYHZX94bA1EGDbcI=;
        b=SEIOmJk+dre00QoYcecaf9U5tS9X4VswM5BNVU/3LezGY06g4eE+1SKzqQvGUC6hah
         XVBY4S7A+t+NvnVWMW4gN2llYlX1SyK14JMza5QLaQNgufNnDgEbDFaD7c5epon6Lm0C
         e5n+Pd5pMpRpIWF+rAFMOwnSxmvie8z5pENyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rDoQVAuYY+19gusYrxHFw2VAPgZJL/q4CjHu7X2MmK9OsJQIUgF5260qWPo17WobWi
         ibl0i6ZQk/5ghErF03SzIwMP8a6pWnXEAQ8RPhd3C6JTo8YiVIY5pjIK2OZBKfrFSfO8
         mAzt6OIxBae43rerOdaN6+BVQnXFViiOj8EpQ=
Received: by 10.231.145.1 with SMTP id b1mr8211996ibv.69.1283308125074; Tue,
 31 Aug 2010 19:28:45 -0700 (PDT)
Received: by 10.231.139.160 with HTTP; Tue, 31 Aug 2010 19:28:17 -0700 (PDT)
In-Reply-To: <AANLkTiktRqX+fhFW3mN_b5tnbKzDJY86fLpKVth7RpY9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155003>

Heya,

On Tue, Aug 31, 2010 at 17:12, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> The version could be 3 if extended flags are used.

I suspect you are the person to have most recently messed around with
the index, and given your corrections above, could you perhaps pick up
the patch?

-- 
Cheers,

Sverre Rabbelier

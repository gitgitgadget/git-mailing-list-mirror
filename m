From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: stop hard-coding 40-character hex checks
Date: Tue, 18 Jun 2013 12:33:22 +0530
Message-ID: <CALkWK0=_Ac+dQV23xiXty3peWdhn2iFzgSPb7LYDFmoCzYhxQQ@mail.gmail.com>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
 <1371317906-3991-2-git-send-email-artagnon@gmail.com> <CABURp0qs7uPkczmS8EC-iNgCVh2eTaeCKsh7NwVuS4j92jMn+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UopxZ-0004sv-BQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab3FRHEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:04:04 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44902 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3FRHED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:04:03 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so9274895ieb.30
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qOeihHHno+nZJOQe9iwgjlvlHhMy6RjBmaVDgTJhjQc=;
        b=VUvr+CtT+xTnCBVS36edRNfec3Pq/IvwiaF+croiAOqXK6mjp9HKcO0pIXF7K9p3O1
         IQO7pXfV3hbtP7VPJGHtvIb2eAAMy/rLwo+pIJqXxaLd/xv6EI599cVxHq71/dVpjHbb
         ujQR8ZTnq8Lz7dlDhI4xLWvna8Tj7yybX9wSWUiDUq87yzfFgdAOzsU95IPg2BlrMOWd
         aXz3rPsZS8pCPHPmxQqtS67LFBi2fhP+HXa2O37GiVDEltpdgzQSPZyWgsldZ9b9jxBC
         sib8JKaYVpvAsWw95NWHGJ86SVAgKrgRJ5NlG2i/vLL9fpLj8vX0lDEfpqUliEk6FLXU
         rEXw==
X-Received: by 10.50.80.9 with SMTP id n9mr6949954igx.42.1371539042810; Tue,
 18 Jun 2013 00:04:02 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 00:03:22 -0700 (PDT)
In-Reply-To: <CABURp0qs7uPkczmS8EC-iNgCVh2eTaeCKsh7NwVuS4j92jMn+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228162>

Phil Hord wrote:
> I share your disdain for the bare '40's in the code.  But I think this
> code is less clear than the previous version with the magic number.

Please read the cover-letter: I was just toying around to see if this
was a good idea, and Junio points out that it's not.

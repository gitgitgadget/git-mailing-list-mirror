From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 15/23] http.c: new functions for the http API
Date: Sat, 6 Jun 2009 09:08:23 +0800
Message-ID: <be6fef0d0906051808k19a5a4acu29713c5e84fac4d7@mail.gmail.com>
References: <20090606000550.17d48ace.rctay89@gmail.com>
	 <m3iqja5rvc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkOv-0005zQ-04
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbZFFBIY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 21:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbZFFBIX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:08:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:39914 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbZFFBIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 21:08:22 -0400
Received: by wf-out-1314.google.com with SMTP id 26so825343wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LYS+7ut3sIc3p3eYMQbl8ZZ3Eufi2h8pry1FeSzIQl8=;
        b=FNyPJedK77226wrfE4BZDYj9f+2juceBaxeFgNj8Tpxrc+jogx8aFk5p12h0BVVNJi
         X1pKkz4BNkK2Q+3vqUA5K0mY9opUxQ1zLpYLXhED8EscmoPd/ZVDCufquUGKgHqoJ4aJ
         ruwkN7M4Ibpy7i7fnlNCDammpjYoCNjnmYQ0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FcY+7zUZL8lj9+ip2XDqzWYcmaY8O0ly3Z3vmvQoOqOXfQdxMM52Z+M5VHIqtfRrki
         QjILo1YTTO/f1p2iugO+N+rswLHPm/ASBUO/YdbqcmRz+ZGWz9yoFtRVBcRbb9WGtE6N
         Yp8XzHAwrca7cz28ekz3XY+kxKeXAEquizxT4=
Received: by 10.142.70.11 with SMTP id s11mr1517538wfa.42.1244250503846; Fri, 
	05 Jun 2009 18:08:23 -0700 (PDT)
In-Reply-To: <m3iqja5rvc.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120857>

Hi,

On Sat, Jun 6, 2009 at 4:50 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> So what is the title of this patch:
> =A0"http.c: new functions for the http API"
> or
> =A0"Two new functions for the http API"

See my reply to patch #19.

> Or perhaps it better be
> =A0"http.c: Add http_get_strbuf() and http_get_file() to http API"

I also add http_error(). Listing out 1 or 2 functions in the subject
is ok, but 3 is a stretch, IMO; I think the reader can know the
functions added by reading the commit message.

Perhaps you think an enumerated list of the functions added in the
commit message would be preferable?

--=20
Cheers,
Ray Chuan

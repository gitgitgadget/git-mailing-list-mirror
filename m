From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 1 Jun 2012 13:43:35 -0700
Message-ID: <CA+55aFyqN2OJkSKVLERtMr-P6OKWEfjrS6eP8OtDyoZB0mmR3w@mail.gmail.com>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org> <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
 <7v8vg63lri.fsf@alter.siamese.dyndns.org> <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
 <20120601203836.GB19987@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:44:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaYhW-00047l-Fc
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 22:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab2FAUn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 16:43:58 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62242 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab2FAUn5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 16:43:57 -0400
Received: by wibhj8 with SMTP id hj8so1019642wib.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8GOmtLx1TgPBbMvXZUbXhqnZ3mY5EI6pGQLvP8KmldI=;
        b=lh61gJdbqffXZbLVC1v6/u7zh2Su3da3/8yaoHPvSSvUeaPWQBbeyr/I2mFfu7WFvi
         gkKLl8LOcP2Vs4pI81SvdzEO+3VhPSXc/AQblhrcpY2yxqNnYrUSKTMNRigDWLRUuxmw
         1e/6ZfDbl7kEYt3chaTrznNZOE73SaSyq5YzOl5I5YHJ4deOzJcBNxWQlsfQDCr9rD0n
         aDBe5Gumv+uoO4iRE9Xm4IuNJOH11jYgAYgdToYRHTb7Q7z9fYYT0phVSTsLkxMyoac9
         e2t/gSwquhelmYSr4bu2hjwoHe4EGe1soM3XyyKA5SaaLHPKKEMiNOBjBxuzF03PFfWe
         e1vg==
Received: by 10.216.197.4 with SMTP id s4mr3182701wen.181.1338583435908; Fri,
 01 Jun 2012 13:43:55 -0700 (PDT)
Received: by 10.216.225.99 with HTTP; Fri, 1 Jun 2012 13:43:35 -0700 (PDT)
In-Reply-To: <20120601203836.GB19987@thunk.org>
X-Google-Sender-Auth: AzVd-DaoKC2ZHbr2pxyT1zLAQr4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199021>

On Fri, Jun 1, 2012 at 1:38 PM, Ted Ts'o <tytso@mit.edu> wrote:
> One other thought. =A0One of the reasons why I used "dev" and not
> "ext4_for_linus" in my git request-pull command line was because that
> several months ago I had created a branch called ext4_for_linus, and =
I
> hadn't gotten around to deleting it, so I figured I'd just use "dev"
> instead, since it was non-ambiguous.

You can always just use "tags/xyzzy" to disambiguate..

                  Linus

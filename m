From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Does anyone use git-notes?
Date: Thu, 26 Aug 2010 18:26:27 +1000
Message-ID: <AANLkTi=jNPtvpO_gVKyS0U_0qRLtKZ84p=B+8zStxvkX@mail.gmail.com>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 10:26:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoXn9-0008OU-Fw
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 10:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab0HZI03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 04:26:29 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55157 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0HZI02 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 04:26:28 -0400
Received: by qyk33 with SMTP id 33so1451472qyk.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ajEWGGqbn/acJknybVgNVBjo098nFu4QxatedNxlM5s=;
        b=FFU6ep3GhGyF/fXZ3u8vHmqLST33z6v/Wi8cnbjQBnb0UawwYpWz42i/PAQ38MCueL
         /zNFZnBnHxP0qWPmwEXgggDRAd1wtdLR87U7RagfqTazpoup7SeCqlyhnKjqDE4ZtBAb
         xE5YChTwmyv9FNEKxekelzG/x7ViznLEo3u84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O8q9yEQvIPZEhEL9si2dhXjwIE3IinNAFHigcTHfy5pg2L+pSu/Ghq0064NIKa+d6x
         RO6Qyf/+BgdXm6K/Ans0dtqgOjqaIorZkXM7XkGC4w//eIhe/wrBTqUG6QjUPxJ9nU22
         M/b/6fMA2GxBfmjHcFWvjHk8ok/RVCj+FKaa0=
Received: by 10.229.239.7 with SMTP id ku7mr1372862qcb.189.1282811187173; Thu,
 26 Aug 2010 01:26:27 -0700 (PDT)
Received: by 10.229.114.222 with HTTP; Thu, 26 Aug 2010 01:26:27 -0700 (PDT)
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154532>

On Thu, Aug 26, 2010 at 4:15 AM, Scott Chacon <schacon@gmail.com> wrote=
:
> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis. =C2=
=A0I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anythin=
g
> practical. =C2=A0Can someone share with me how they use them and what=
 the
> cycle is?
>

I use them to store test execution output.

By post-processing, then diffing such notes, I can work out what was
regressed or fixed between two commits.

jon.

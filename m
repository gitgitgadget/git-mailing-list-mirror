From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sun, 2 May 2010 04:17:20 -0500
Message-ID: <20100502091720.GB1854@progeny.tock>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
 <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
 <1272790255.4258.11.camel@walleee>
 <7vaasiwtvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: wmpalmer@gmail.com, git@vger.kernel.org, peff@peff.net,
	raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 11:17:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VIp-0000Yy-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab0EBJR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 05:17:26 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:55450 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab0EBJRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:17:25 -0400
Received: by iwn12 with SMTP id 12so2025066iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E9tITmqJ4L1mNGsySyb4oe5oovj+otNFYwXmQYQIm3k=;
        b=IFcF3WO3o2YzFNdNSSFvqTrUVUrO53Szzeikbfdo7ZyjzqcF3rx3Og6B0IU9bvHA4R
         Rk3thqgd1BmBIloo6XSu08Pr7HRAlUQPfXL9aCLahAffFRZuGI7MNJw4lWj9eM+iM4if
         dFI+CKl5zV0Rx12N7I90qwfzlTWhgUhJfgNj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HYSo8tCHCVpAvA4iiVNqjqU4RK7R0Xim1SpLfV6cukxXAeyhseW5zAKe/3y/kuVfJM
         M+n4wreShGY67iuMf1d45dDQWLcT+ZEgF1J0zAE4WiCWumhuwtYCn3Agp6t+cjoOY3N1
         +IsUZK5KijLitEZnGfMeAC1NcHuDGVhn9fdvU=
Received: by 10.231.182.206 with SMTP id cd14mr1014095ibb.39.1272791843846;
        Sun, 02 May 2010 02:17:23 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3290041iwn.12.2010.05.02.02.17.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 02:17:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaasiwtvt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146152>

Junio C Hamano wrote:
> Will Palmer <wmpalmer@gmail.com> writes:

>> If the current behaviour is actually intentional, we should at least
>> update the documentation to say that %H is the "full commit hash",
>> rather than just the "commit hash".
>
> I think it was obvious from the context that lists %H and %h next to =
each
> other, with description without "abbreviated" and with "abbreviated" =
to
> them.  The description for %H should be rewritten as "commit object n=
ame"
> and %h "abbreviated commit object name".

=46WIW, this is why I suggested updating the documentation.  I think th=
e
=E2=80=9C%H becomes %h in the presence of --abbrev-commit=E2=80=9D beha=
vior would be
more useful in practice.

But I am not fanatical about it.  Maybe this functionality should get
some other letter and I would just not use %H.

Jonathan

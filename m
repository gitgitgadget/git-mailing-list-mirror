From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Column output
Date: Wed, 9 Feb 2011 07:13:45 +0700
Message-ID: <AANLkTi=WKnj8M2Uh+ACSay1STgOhWAjQbmspYSja3y0+@mail.gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com> <20110208224745.GA14190@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 09 01:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmxhP-0003t7-U8
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab1BIAOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 19:14:19 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38880 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab1BIAOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 19:14:18 -0500
Received: by wyb28 with SMTP id 28so6350461wyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 16:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=j8uDrtIdF/He9aMN0vp9EMO8Zg/62Alu9Np4YXWHO3w=;
        b=HHfs2wWMHgaH2GUfKezfUKXgJfJNxuMOSqerq8IQllZVZ3rpRZdjFyLLVWPtqRXAEB
         F5D3ZSgfCPYl54kGO2Gqi8csi7bMjqgVvHuQRwh13U5n6dRflJUpcBD8lUyGo1/3SQ2F
         PHp7zlLtPxWWf5d6OQg1vCWnbO9F6CKb4jifg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r6fRoPD4NZ81C+ftkvO1/7GC7m3XvdmYwMmZK8L2M+c730C0W8VgHA4tAwVYjwI89t
         9huNIvzSRNM4aGIIyLfh50UGquVWLTrdpU8jL5rRdovdvsrI8Zg0MqF2Gn5xpOmiL3St
         SSbomjvMFcXGAUw8xZBsVFrG2IFz2iJ+8D1ao=
Received: by 10.216.186.144 with SMTP id w16mr16471013wem.13.1297210456020;
 Tue, 08 Feb 2011 16:14:16 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Tue, 8 Feb 2011 16:13:45 -0800 (PST)
In-Reply-To: <20110208224745.GA14190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166376>

2011/2/9 Jeff King <peff@peff.net>:
> On Tue, Feb 08, 2011 at 10:22:14PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> In short, the series is very simple: give porcelain commands column
>> output, just like good old "ls". There could be a few more candidate=
s,
>> I believe Ren=C3=A9 Scharfe mentioned other files in "git status".
>
> I don't really care for column output myself, so maybe you have a goo=
d
> reason why my idea won't work. But why not use the BSD column program=
?

Solaris did not have one last time I checked. Windows obviously does
not either, but I don't use msysgit so it does not count.
--=20
Duy

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #01; Sun, 1)
Date: Mon, 2 May 2011 12:28:26 +0700
Message-ID: <BANLkTimXGChZ+3UAHqqgOGcDt_wGH9XLHA@mail.gmail.com>
References: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 07:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGlh9-000690-6L
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 07:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1EBF26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 01:28:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab1EBF25 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 01:28:57 -0400
Received: by bwz15 with SMTP id 15so4344104bwz.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=f3GWkhvovodbQmuk790Y/7TLbPqNKVMSKYkcVajf0C8=;
        b=p04TupRVf3MWIOPP258nvIGNdGiTjnEm1sUVErK6RvmyCNxLaDk/zwitkmo8wJFELF
         KnhSYABS3RS6c+DDWKAxb3F1dkIciuTj+HUP6dAKs7q1n0nOGxAmR6u7deq0/KKuo44m
         XW1Q36AtSiAbt9wrx04tPnjoF314GptBGmcfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I93EWbzR7v/jOlyeuRjJvnsU5o0ZSKTcWnZrMdjHgNW/QB9o8QWCK/+a0LQx4RaAcB
         JTOhwgL+hNwzke2CYKNmKpqH8ifgqe98UjI0/BiH8N7F1LFMQSSNR7NZ+ONx2rsR8BMY
         tQCp5HkfXxxv1z9+EDl23Hmd3hhCAx8idlANs=
Received: by 10.205.83.199 with SMTP id ah7mr994832bkc.146.1304314136118; Sun,
 01 May 2011 22:28:56 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Sun, 1 May 2011 22:28:26 -0700 (PDT)
In-Reply-To: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172562>

On Mon, May 2, 2011 at 6:55 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * jc/magic-pathspec (2011-04-06) 3 commits
> =C2=A0(merged to 'next' on 2011-04-25 at 788cd46)
> =C2=A0+ magic pathspec: add ":(icase)path" to match case insensitivel=
y
> =C2=A0+ magic pathspec: futureproof shorthand form
> =C2=A0+ magic pathspec: add tentative ":/path/from/top/level" pathspe=
c support
>
> Thanks to Peff, Duy, and Michael for helping to whip the syntax and t=
he
> basic semantics into a not-so-horrible shape.
>
> Will merge to "master" by the end of week #2.

This needs some tests. I'm going to add some unless somebody does it fi=
rst.
--=20
Duy

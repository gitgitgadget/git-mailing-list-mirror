From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2011, #08; Fri, 21)
Date: Fri, 21 Oct 2011 16:47:35 -0700 (PDT)
Message-ID: <m3r5256h76.fsf@localhost.localdomain>
References: <7vzkgu6jrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 01:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHOr9-0004wi-WE
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 01:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab1JUXri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 19:47:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45139 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1JUXri convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 19:47:38 -0400
Received: by bkbzt19 with SMTP id zt19so5397023bkb.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=t7Ai2R4L2XFida1gfIVbRmQ99gTJAWVhPBH9D+yPeRI=;
        b=ixUVyxdkuOt5CGrseDYVO1cQF0u6za41UaoEmNqJA3j0Gif3fiKNl440xuW2pFFYd+
         m2eh2RZJWbIz/Gxv6IyfuqymoKID6vXB7oqlY5HsatubyApX/w3coA2RUIBtS5AdmlUU
         /PX6PaC8r5Ip11fmQbdga9qURhizcJl23n9lM=
Received: by 10.223.63.75 with SMTP id a11mr27788816fai.9.1319240856817;
        Fri, 21 Oct 2011 16:47:36 -0700 (PDT)
Received: from localhost.localdomain (abwe57.neoplus.adsl.tpnet.pl. [83.8.228.57])
        by mx.google.com with ESMTPS id c13sm25060402fai.3.2011.10.21.16.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 16:47:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9LNlAEc002092;
	Sat, 22 Oct 2011 01:47:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9LNksLT002087;
	Sat, 22 Oct 2011 01:46:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vzkgu6jrf.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184093>

Junio C Hamano <gitster@pobox.com> writes:


> * lh/gitweb-site-html-head (2011-10-21) 1 commit
>  - gitweb: provide a way to customize html headers
>=20
> Looked Ok.
> Will merge to 'next'.

Nice.
=20
> * kk/gitweb-side-by-side-diff (2011-10-17) 2 commits
>  - gitweb: add a feature to show side-by-side diff
>  - gitweb: change format_diff_line() to remove leading SP from $diff_=
class
>=20
> Fun.
> Will keep in 'pu' until the planned re-roll comes.

I think this needs some more work, not only re-roll...


BTW. the bottom commit could be I think replaced by mine

   - gitweb: Refactor diff body line classification

Anyway, thanks for putting it in 'pu', it saves me trouble of fixing
whitespace issues in patch :-P

--=20
Jakub Nar=EAbski

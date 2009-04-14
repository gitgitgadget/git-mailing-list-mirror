From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes 
	misreading
Date: Tue, 14 Apr 2009 16:41:53 +1000
Message-ID: <fcaeb9bf0904132341s777ca697p1930df10eb1ff37b@mail.gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> 
	<1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> 
	<1239185133-4181-4-git-send-email-pclouds@gmail.com> <7vab6rkl5f.fsf@gitster.siamese.dyndns.org> 
	<49E3448B.8010602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtcMy-0003bK-US
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbZDNGmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 02:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbZDNGmK
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:42:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:15484 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZDNGmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 02:42:09 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2513791wff.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5BM2R5w+qzXSMI1D7B84INyJeEXCe9+VeWnhWZvaIsA=;
        b=eLdAtrhOxOX2VTA3mSDbApD6/+gKDjxnTveDPCI01G2S3vZB6aGT113/2J3JRgpjrP
         jDqtlLMBWk+uh6RedYM5mdIulBkSAl4x32QLQGhfXnSZiqsOad9HEQUWDM7tQQLuwrHU
         ICv1KFzatdQ7is4pXU+m46xAlaNKyU7LzfjK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EMchZqnPwhuRY6KYVPN/h0w9ypyqLV0WmSmXp6kQ76xyxYk/UCohv0fvz16W8zcxXy
         K7R1XsMSWbj3OMQh3JTfD6CairevUhPXObzyFI/zYblzn2ddwb6PdvRy07kIMGYvIaP1
         BlcVhfcctyBBWwuWEbT31EtTD6uSBD3sF0qko=
Received: by 10.142.212.21 with SMTP id k21mr1329829wfg.160.1239691328131; 
	Mon, 13 Apr 2009 23:42:08 -0700 (PDT)
In-Reply-To: <49E3448B.8010602@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116522>

2009/4/13 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Also, the last sentence of the description may be taken to imply a
> mixing of attributes from work tree and exported tree is done, which =
is
> not the case with the patch from series 2 (and shouldn't be). =C2=A0P=
erhaps:
> "With this option, .gitattributes files are read from the work tree
> instead of from the exported tree."

I'm at work and haven't had chance to read other mails carefully. Wrt
to the description, it reads from index too if it fails to read from
worktree. So perhaps "With this option, .gitattributes files are read
from work tree (or from index if they are missing from work tree)
instead of from exported tree.", unless you want to introduce another
"attr direction" to read from work tree only.
--=20
Duy

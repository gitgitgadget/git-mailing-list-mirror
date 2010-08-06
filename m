From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH jn/paginate-fix 0/12] Re: git --paginate: do not commit 
	pager choice too early
Date: Fri, 6 Aug 2010 14:26:52 +1000
Message-ID: <AANLkTincgypcb3Bq8KpFXv9guBO+xQKJ-TkuGEpk9W62@mail.gmail.com>
References: <20100626192203.GA19973@burratino>
	<7vpqzacs3h.fsf@alter.siamese.dyndns.org>
	<7v630hyf5r.fsf@alter.siamese.dyndns.org>
	<20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 06:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhEWJ-00007R-N1
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 06:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190Ab0HFE0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 00:26:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54181 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab0HFE0y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 00:26:54 -0400
Received: by yxg6 with SMTP id 6so2726743yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TUYIAvxpGI6nypm7o+SE8Aik5HL49PPbo04Ve0/+IZw=;
        b=WAYbfT/A0ZjXiKTuO+Ri2jjG6VOiArBJxiMmVavmt+t0Qx/8zmLObyD16FMiPsZm17
         gcGzVw0iw3MUWx1cRlRlOV79lmqnFmCsbAIYl058VHUBnmg8yQH2iI/6bFs0hgrZYj03
         MaaX7+GR34MZhoObM4yOB+ujAM7sNgU9AH174=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=temVg9Xgq0283aReF8SSE7gw72IXLi52Zw10O8TiZUFwhTD4rHqWHDGYdzt/48YIod
         lZNnXK2envBswdrlmhvEtyszEfT5p/NaFNJ7YUrTY71nrkw5BgJQvb/LarYPcx5SUx7q
         qi5WPoqWlkzAmRdl+5t3I9t7ms786pIwqHDR0=
Received: by 10.150.53.21 with SMTP id b21mr13517438yba.353.1281068812747; 
	Thu, 05 Aug 2010 21:26:52 -0700 (PDT)
Received: by 10.151.26.12 with HTTP; Thu, 5 Aug 2010 21:26:52 -0700 (PDT)
In-Reply-To: <20100806023529.GB22369@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152763>

2010/8/6 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
> =C2=A0git wrapper: introduce startup_info struct
> =C2=A0setup: remember whether repository was found
> =C2=A0git wrapper: allow setup_git_directory_gently() be called earli=
er
> =C2=A0shortlog: run setup_git_directory_gently() sooner
> =C2=A0grep: run setup_git_directory_gently() sooner
> =C2=A0apply: run setup_git_directory_gently() sooner
> =C2=A0bundle: run setup_git_directory_gently() sooner
> =C2=A0config: run setup_git_directory_gently() sooner
> =C2=A0index-pack: run setup_git_directory_gently() sooner
> =C2=A0ls-remote: run setup_git_directory_gently() sooner
> =C2=A0var: run setup_git_directory_gently() sooner
> =C2=A0merge-file: run setup_git_directory_gently() sooner
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/144000/foc=
us=3D144110
>

I was waiting for jn/maint-setup-fix to graduate before pushing out
some more patches then I got side tracked by the subtree clone.
Anyway, thanks!
--=20
Duy

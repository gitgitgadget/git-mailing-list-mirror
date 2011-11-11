From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Thoughts on gitk's memory footprint over linux-2.6.git
Date: Fri, 11 Nov 2011 18:04:27 +0200
Message-ID: <CAMP44s2tjeQAq+WuAepwvcY74X1af_pPjH4PSbe-Q=OuuAucWg@mail.gmail.com>
References: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
	<CAMP44s1cZc5OZ0L0zG-Wu+QVpu7xv4-JtWTBtPvnjO7sUFeM9w@mail.gmail.com>
	<4EBD2EFF.1010000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 17:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROtak-0003et-Hk
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 17:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab1KKQE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 11:04:29 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51576 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab1KKQE3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 11:04:29 -0500
Received: by yenr9 with SMTP id r9so3270762yen.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hjchXL61chVwcBo5qvP0q8Z9nqRUPxM5NKTNx3ofU0E=;
        b=Z5H7wpF31Pnw1BQRDXDSgjUaAr9QqK46moWT2s3t+3BVAc9C4CylZ5obX7KhTTdeUA
         +t9gTJ9G2DsHKh8VnELP5d/dJYfAHi9yO8ZRg5WAE8UCJTXLASzioG+LmQvSrDaR9rUp
         5XyNdbZF8TkIsuAG+z3AuECGQJADeo22V2y6k=
Received: by 10.68.0.193 with SMTP id 1mr8172264pbg.110.1321027468262; Fri, 11
 Nov 2011 08:04:28 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Fri, 11 Nov 2011 08:04:27 -0800 (PST)
In-Reply-To: <4EBD2EFF.1010000@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185272>

On Fri, Nov 11, 2011 at 4:19 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 11/11/2011 13:44, schrieb Felipe Contreras:
>> It would be nice to have --base option, and show only the commits
>> <base>..<branch>.
>
> What's wrong with
>
> =C2=A0 =C2=A0 gitk master..branch_1 branch_2 branch_3 branch_4 branch=
_5
> or
> =C2=A0 =C2=A0 gitk --branches --not master
>
> ? (I do that all the time.) Recall that 'master..branch_1' is short f=
or
> '^master branch_1'. It is sufficient to specify the negative ref, ^ma=
ster,
> only once.

Ah, nice! Thanks a lot :)

--=20
=46elipe Contreras

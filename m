From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make install error
Date: Thu, 28 Jan 2010 09:48:36 +0100
Message-ID: <81b0412b1001280048y6f91ad25t5c636f959630825@mail.gmail.com>
References: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
	 <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kap4lin <kap4lin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:48:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQ3P-0001Ti-J4
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 09:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab0A1Isj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 03:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253Ab0A1Isi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 03:48:38 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42513 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0A1Isi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 03:48:38 -0500
Received: by bwz19 with SMTP id 19so339643bwz.28
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 00:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rAdXHPU8ckmPhOv2hIEIcxlsIKmyX+kCHd47J4KPsPE=;
        b=gOvBBxAc7L7zGC9H9CTzRD0iLUeGkSm+YbEFfv3yuTCOSXB15JZQFo35vXjHgiDZjH
         5PcelS63oFAZYo7jm7pyGhfpsCgBtgC83UPiJ0fpvOlQJcZLI08xBVpsTk+C+cknrhW1
         mblVUKFqyaYiBkxVNHYbxWR0txdf2VKHD84ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K9FXaYnuweZ9mSz3Lb/u1RhVsWWwtlOQ/+EhZbyVp5ceBG7+2nc79X4Zfz1EoHCFMs
         6/0nfIVTDvBEP97wKfOP9TSTp35od9deSARyfzVPDG27ybjR9gm+At/QNg5R1/TiReZi
         XmNyFlydN7Vxos9sC3exzUOMUgZj6yT3ru6rU=
Received: by 10.204.33.196 with SMTP id i4mr715810bkd.155.1264668516695; Thu, 
	28 Jan 2010 00:48:36 -0800 (PST)
In-Reply-To: <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138228>

On Thu, Jan 28, 2010 at 03:53, Junio C Hamano <gitster@pobox.com> wrote=
:
> kap4lin <kap4lin@gmail.com> writes:
>
>> (cd blt && gtar cf - .) | \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cd '/scratch/kap4lin/usr/share/git-core=
/templates' && umask
>> 022 && gtar xof -)
>> gtar: This does not look like a tar archive
>
> Perhaps "unset CDPATH".
>

BTW, will "cd ./blt &>/dev/null" also help and prevent this problem fro=
m
happening ever again?

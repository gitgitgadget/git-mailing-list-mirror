From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 7 Feb 2012 20:07:12 +0700
Message-ID: <CACsJy8ArYYjX2VqPbpg7qU8ZbK0m_Cm-cQ35_ZZahrYAZJ7pow@mail.gmail.com>
References: <20120207070628.GA24698@redhat.com> <m362fjklb7.fsf@localhost.localdomain>
 <20120207104100.GA24828@redhat.com> <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
 <20120207130204.GA7600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 14:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rukm6-0002aN-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 14:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689Ab2BGNHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 08:07:45 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:35472 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642Ab2BGNHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 08:07:43 -0500
Received: by werb13 with SMTP id b13so4992952wer.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 05:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0med0is2dkosBtye6xchU4DK4Zx1loOQU8i5C+xaHqY=;
        b=VebqRMzaBfTWZzAtgaUt+/Mo41G9upsM9CjlQHIJOR8/ekUTvMvfJ5sAH4Ax5yEWIm
         n4qYoiLq++bksiKVbLGeYMh6Lt7TgFv3qJKOraxlcjuMPpNMnM+Uj/mzEknAW6divobL
         gopNNFgqWTMzPfyAaAr9gaS+QhCc1wAJrDEK4=
Received: by 10.216.136.17 with SMTP id v17mr8529209wei.26.1328620062570; Tue,
 07 Feb 2012 05:07:42 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 05:07:12 -0800 (PST)
In-Reply-To: <20120207130204.GA7600@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190173>

On Tue, Feb 7, 2012 at 8:02 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
>> I tried but it was ok for me. I think ref processing at local probab=
ly
>> goes wrong and does not request commit from HEAD. =C2=A0If the repo =
is not
>> confidential, you can zip it and send me.
>
> Can't unfortunately :(
> Would some verbose logs help?

You can try cloning with GIT_TRACE_PACKET=3D1. bisect should also help.
--=20
Duy

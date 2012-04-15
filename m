From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/5] completion: trivial cleanups and fixes
Date: Sun, 15 Apr 2012 22:42:56 +0300
Message-ID: <CAMP44s0EPgS8MX4B7Wc4XW+S+JeJiuo63Rv-KiP=q0YTMbtd7g@mail.gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<20120415132002.GB2544@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVLo-00017p-DH
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976Ab2DOTm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 15:42:58 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62097 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2DOTm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 15:42:57 -0400
Received: by eekc41 with SMTP id c41so1131787eek.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LsAPKvYBdJtX86eNdxy4mXBL8jAf2xpDM2VCBI4hDww=;
        b=knK3T06+gtxyu/7HaYbxeXscBU2Yssrkz4/N/VuR9uqTei2M8VhL6VOrN2qyEmaRcq
         WK3J3OHN0SrrCcCtRjvYX3sbwZs9/k9Zkra9aN9k6YKGGGREii0eMUXdvjzIDw1sL5k8
         SoJbt5YRARCwkQaFfQRQUcE/q6MCCwPx38bCUF4zknL48qlOBOkL2dm/0EVGkDhLZd7x
         yK6vG0bIaeHUdGLNZwliauI6g16Z1fiOg18Bw1HZtcd/OvqghFSlNdh5aWG+e2W6Fw8D
         hsWjQPfKvYX672Xub2Ed/+YQQ7CZ64lYIIdYkeMZBftBda/yQYboK1PwUOMUdmawV4n4
         csxg==
Received: by 10.213.108.147 with SMTP id f19mr603977ebp.162.1334518976322;
 Sun, 15 Apr 2012 12:42:56 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 15 Apr 2012 12:42:56 -0700 (PDT)
In-Reply-To: <20120415132002.GB2544@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195576>

On Sun, Apr 15, 2012 at 4:20 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:

>> =C2=A0 completion: trivial simplification
>
> Improves consistency. =C2=A0The changelog line isn't precise enough t=
o
> remind me which change is being mentioned when reading it in the
> shortlog, so I guess I'd prefer something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0completion: simplify by using $prev variab=
le

OK.

>> =C2=A0 completion: add missing general options
>
> Likewise, a subject line like the following would work better for
> me.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0completion: --info-path and --no-replace-o=
bjects options for git

That's too long, and I think it's less understandable: for git? Of
course it's for git, for what else could it be? :) maybe s/options for
git/general options/, but it's still too long.

I'll leave it like that, anybody else can change it if they wish.

Cheers.

--=20
=46elipe Contreras

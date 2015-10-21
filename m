From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5516-fetch-push.sh fails with current master (74301d6)
Date: Wed, 21 Oct 2015 07:21:27 +0200
Message-ID: <CAA787rnSwJLb7_eWUqFsBVWyhPVLG3OL0WqzzBm0umTUwbd2Jw@mail.gmail.com>
References: <CAA787rnfwVgE=40WF6co4cfMi0gNa8oT7dL-Wy1Gnto_gEF8AQ@mail.gmail.com>
 <CAA787rnog5BorqYcs3noKRsd5Rkbh-mm2sENEn1XywzKhgen=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 07:22:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zolqf-0005kJ-9z
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 07:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbbJUFV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 01:21:59 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34009 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbJUFV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 01:21:58 -0400
Received: by lfaz124 with SMTP id z124so15605926lfa.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 22:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=Devyo9i2U53DW6V1pu2fqzI1/lEUVjeaTToZ0kLVAH4=;
        b=oETtoBtGVfgxf+IsJmfWev9nzIbmkFkBygIYaSIqtVJJKqxsx0g1tVf05knzrEfOe0
         DhVGGolVJbRyInizLRmBXO25EnXSX03GMC4Bi5XX04WEkR4+xHZ0JOzpRdlFTxkzcFJi
         omdhd+5nXlDZqtmo3fR9d+SWS7P1yaoThLooIRgkm1FMLePlv8GWH156iEc6m8wX0wVG
         DEbXxZrr9u4jPTYzSSV5+hxppR0gQ+QPFbbwkB3a4mam/FP2kWnjE2qeDj5/wF6kOTee
         aqD6DJG5sEFE3tDr+nwVDFGxjEQmGzIarFSRusNoEev68xJJaapdAngNiHRFvOqbdP34
         w7fw==
X-Received: by 10.25.24.162 with SMTP id 34mr2573713lfy.84.1445404916871; Tue,
 20 Oct 2015 22:21:56 -0700 (PDT)
Received: by 10.25.25.137 with HTTP; Tue, 20 Oct 2015 22:21:27 -0700 (PDT)
In-Reply-To: <CAA787rnog5BorqYcs3noKRsd5Rkbh-mm2sENEn1XywzKhgen=g@mail.gmail.com>
X-Google-Sender-Auth: ISakB7Qu2mzgpSfVcpCv19Oy7bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279967>

On 21 October 2015 at 04:01, =C3=98yvind A. Holm <sunny@sunbase.org> wr=
ote:
> On 21 October 2015 at 03:40, =C3=98yvind A. Holm <sunny@sunbase.org> =
wrote:
> > When building from current master (74301d6, "Sync with maint",
> > 2015-10-20), test #75 in t5516-fetch-push.sh fails

Hm, seems as I'm unable to reproduce the failure. That's strange, I hav=
e
an automated build script I've been using for years, so the build
environment is unchanged from the previous builds. I'll investigate thi=
s
a bit and come back if there's anything newsworthy. In the meantime,
sorry about the noise.

Regards,
=C3=98yvind

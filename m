From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH v3] log: forbid log --graph --no-walk
Date: Sun, 15 Mar 2015 09:39:48 +0800
Message-ID: <CABwkPcpRG0d23OCuoktRdXt9nyA3RtmxGkqkoQ-wApzZvtfYDQ@mail.gmail.com>
References: <5504D5A2.2070405@norn.io> <CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com>
 <5504DF62.4050104@norn.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, me@ikke.info,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Manos Pitsidianakis <epilys@norn.io>
X-From: git-owner@vger.kernel.org Sun Mar 15 02:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWxXU-0004WR-51
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 02:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbbCOBkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2015 21:40:12 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33590 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbCOBkJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 21:40:09 -0400
Received: by pdnc3 with SMTP id c3so22238854pdn.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nOJzaQwayj/d1pKdOku+TpAVpVt9W1OaJpB9MyC2ymY=;
        b=SdFPOHZP04nM8mHE8DRhqVpdgp4A1kU4SDt7FDYusvO+nAbYnaviTeCrwrfy1imBjQ
         CCbgJ3i8wsO0+w+MHWyJKnvbznvcetc0Etj1o79CKDZBWJ+iO2z38nokXmp5lwDMo+If
         7/ktEv+7YiW1p5c6Wai65C45BGw3kaibrEGj9BaNVksuyzk01URN0yhMkKu4ujSmtEdx
         js7krJkQx1TM9toltaiBUQ77UBxBnMAqwfBIxwh6gYaLki9pC2epan8c/6W+jW2CDGTS
         Pt5V2XkyUCL7OMt1CZ7OLXkKdKnTpJxneAgA6e47TjcSFiJDqTmoxCNI5fKjBx9JEGFw
         WPtA==
X-Received: by 10.66.101.7 with SMTP id fc7mr87022787pab.26.1426383608999;
 Sat, 14 Mar 2015 18:40:08 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Sat, 14 Mar 2015 18:39:48 -0700 (PDT)
In-Reply-To: <5504DF62.4050104@norn.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265475>

Because "revs->no_walk" gets set when it comes to "git show". You can
find more information on [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/264921

2015-03-15 9:24 GMT+08:00 Manos Pitsidianakis <epilys@norn.io>:
> On 03/15/2015 03:08 AM, Dongcan Jiang wrote:
>> it seems that your patch could not pass t4052-stat-output.sh.
>>
>> I think it would be better if you could improve the specification fo=
r
>> this change in Document/rev-list-options.txt
>
> Can't grok why this happens. What exactly is happening in
> t4052-stat-output.sh? Is it testing every possible combination of git
> commands and arguments?



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China

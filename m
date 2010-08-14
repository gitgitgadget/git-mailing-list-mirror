From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] log: test for regression introduced in v1.7.2-rc0~103^2~2
Date: Sat, 14 Aug 2010 01:19:24 +0000
Message-ID: <AANLkTi=Na_K=9oXM7iyeKodWXyXuSy-0UL792igTEjEe@mail.gmail.com>
References: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
	<1281748247-8180-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 03:19:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok5PN-00040F-KR
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 03:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755Ab0HNBT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 21:19:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38540 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728Ab0HNBT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 21:19:28 -0400
Received: by ywh1 with SMTP id 1so1176437ywh.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 18:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rriKsQfD+g/ruOveEWdAiK+39tnmt5IpBpmyNGSIY2M=;
        b=kveh6ierqTGlaJZ/Gw5o9GKpz1I7pA+PsQZxrSye6P8dj0cK+Att86HA4KpNaSnBJP
         ij3Fh7//JY78InpmbKS4o4LTX6DjI9rtG/ZFqPYloswzs/PorHMpcI4sPTgcwpQiZWq9
         PZ8HVYV1Z7cyNFEGQdrVKywcPc2FQGDJtfSbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YcuRzqA5jTYtqo2ldcsr4Q0KiXOxqpgP232CukVaais2wwl9uKkhFYQW9qy9n9Uu7o
         cY9xSk7QmTlzhEPEvdBv5vvPHhQ7guIMTi1Oam6q03s3/QWvl52PhIGtoT8F8gFqIryi
         O7DNnJA7dMHWxMfdaNLmI1F/iLxchzKH6Dy8c=
Received: by 10.231.169.10 with SMTP id w10mr2380937iby.106.1281748764614;
 Fri, 13 Aug 2010 18:19:24 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 18:19:24 -0700 (PDT)
In-Reply-To: <1281748247-8180-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153540>

On Sat, Aug 14, 2010 at 01:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Add a regression test for the git log -M --follow --name-only bug
> introduced in v1.7.2-rc0~103^2~2

AKA "we didn't have any tests for log's --name-only *at all*".

From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] perl libs: perl -w + use warnings is redundant
Date: Fri, 21 May 2010 16:55:56 +0000
Message-ID: <AANLkTim6Gcx3wCZoM0D7Vd1z9tnNqwtmPLDf1OjD8LiT@mail.gmail.com>
References: <1274453455-1941-1-git-send-email-avarab@gmail.com>
	 <1274460741-9674-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 18:56:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFVWA-0006PY-Bj
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934209Ab0EUQz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:55:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44703 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934149Ab0EUQz5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 12:55:57 -0400
Received: by iwn6 with SMTP id 6so1385175iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pt4etsF7bqpEtnuoW8M9v5GzV3KyVtHp/yGLji0/C30=;
        b=Z/JMD0nuqBwpZYkFLNra5Rahey4Me5vghJR1NtPvA7DSHSLyOIBeUrPDBzZRO6Dp1e
         y0giz/hdtWqiZkNNpI2SMnWRN86tiN0PNFcnszarDse7C1xyx/Sy6V+mXyCu1sExdfCH
         lBXUxj6EsV16d78RFgFtZoyjLiL8UWT++abRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v89trp6XWbgJZWt2PAcD6Wb/TFL6INQVLNme9VTDm5JJVX8LZpjI8+JiPESEGRzEdc
         uhzwyZScvWGlHwqe0zNHl1Wn3sHl3fJBjYJfnJ4fFq7wjR5+QB526qMlNOGsMMkoNPef
         ncKRdzItKbVR2FjJvP1hf/vZB6jkOagrmsA5A=
Received: by 10.231.178.132 with SMTP id bm4mr1285989ibb.62.1274460956398; 
	Fri, 21 May 2010 09:55:56 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 09:55:56 -0700 (PDT)
In-Reply-To: <1274460741-9674-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147484>

On Fri, May 21, 2010 at 16:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Turns out that I missed a case or two that could 'use
> warnings'. I.e. used three-arg open.

This one should have had a [PATCH v2] subject line. This is really not =
my day.

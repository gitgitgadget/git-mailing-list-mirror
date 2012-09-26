From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: git die message written to stdout?
Date: Wed, 26 Sep 2012 21:11:33 +0200
Message-ID: <op.wk9bljau0aolir@keputer>
References: <CAHtLG6T5nHw-47GdRHsXNCeArKy5X5XUmHxLnj50osKoUQa+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGx1O-0000YB-MO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209Ab2IZTLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 15:11:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61201 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758186Ab2IZTLh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:11:37 -0400
Received: by wgbdr13 with SMTP id dr13so757500wgb.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=dOUTEIybCFdl/YzY4USvxxvKQl1Bn/LwqDDDO6/wnY0=;
        b=ZdyOmgBHQU6lgNJW1RamhjoKQWCIj4VzXFu0v/xPhfG30n9pS2ve5Vf8RgsNuFwC/Y
         nbVQFuYLWImwQziweWeCvaSEvhy9FMtVxeYa1x/uvd8e0uAfSC1EVXOkrPcQ2cNonYDr
         bdnWJQRanVg4Se+mtCRpRzyfHHuTA+TLzBv/bdMQ5rnUSNmKAagTLRbiz/oa/cNlB7z2
         dPTFbeh9vPeZ1yu9Ae8skahn6a6Nv4q7giW+bMhp0x8oh/qBS72Uw9gnW4ydMJHuyeaV
         bcp6WOcLBvNTx0q3idiWiHhV/LcHGG48eiYZULa5+fTrXG/n+2oRuptnKb0ovjSzAn+G
         PDTw==
Received: by 10.180.8.41 with SMTP id o9mr3375022wia.3.1348686696151;
        Wed, 26 Sep 2012 12:11:36 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id ga2sm8585146wib.2.2012.09.26.12.11.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 12:11:35 -0700 (PDT)
In-Reply-To: <CAHtLG6T5nHw-47GdRHsXNCeArKy5X5XUmHxLnj50osKoUQa+dQ@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206429>

On Wed, 26 Sep 2012 18:01:39 +0200, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3coo=
li@gmail.com> wrote:

> Is git die() messages written to stdout?
> Should it be written to stderr?

As far as I know git die() routines write their output to stderr. Do yo=
u =20
have an indication that that might not be the case?

=46rans


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

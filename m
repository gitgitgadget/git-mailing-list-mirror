From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: parse authors file more leniently
Date: Thu, 10 Sep 2015 14:08:54 -0700
Message-ID: <xmqqwpvy0yop.fsf@gitster.mtv.corp.google.com>
References: <5613050.3arVUQYvEz@granit>
	<03f07c11135aef9e04a26e5b1018d726ba2fab5d.1441887195.git.git@drmicha.warpmail.net>
	<20150910180810.GA22112@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Till =?utf-8?Q?Sch=C3=A4fer?= <till2.schaefer@tu-dortmund.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 23:09:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za95e-0001Cx-0z
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 23:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbbIJVJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 17:09:00 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33761 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbIJVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 17:08:59 -0400
Received: by pacex6 with SMTP id ex6so53400434pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=iJU3r5cw0FpsCYhEzzB4QJv5pJjRaserU0I0MB8qh5Y=;
        b=Rwmf1hCxTQB4F2AliiC92IBruKMqKKt02zpI1mBbdDHFc4g7SvMoAsKIwYztA3teuK
         /IR8cT72mQTltJIctiakaZHjA4NIok4eN9jCiQG9DWAT2SagnYWlO5+VP0SCcVtTfONl
         BYVj0kI6vO4Po2ptsTsACdtAdMuo/CqM+M/xrPH0lJHarsquWGGS95ti8U0+reJkI5rU
         nA5jJHr+xUB/WuEb/qx8FdGLtsF+bLQhvHT6eAkRd2cqUBR2hlugoXmNC4ghEzjE6UYa
         X6PN1jZdD4NEdxu8oOa9dbsiEh4Fi70dTXpBzld8Lrpcpo+42rTnWuwY2wSMWW1BYcrs
         4FyA==
X-Received: by 10.66.193.162 with SMTP id hp2mr52779379pac.108.1441919339377;
        Thu, 10 Sep 2015 14:08:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id ej3sm13746861pbd.13.2015.09.10.14.08.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 14:08:58 -0700 (PDT)
In-Reply-To: <20150910180810.GA22112@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 10 Sep 2015 18:08:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277639>

Eric Wong <normalperson@yhbt.net> writes:

> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Instead, make git svn uses the perl regex
>>=20
>> /^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.*)>\s*$/
>>=20
>> for parsing the authors file so that the same (slightly more lenient=
)
>> regex is used in both cases.
>>=20
>> Reported-by: Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>
> Thanks.
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>
> And pushed to master of git://bogomips.org/git-svn
> (commit f7c6de0ea1bd5722a1181c6279676c6831b38a34)

Thanks, pulled.

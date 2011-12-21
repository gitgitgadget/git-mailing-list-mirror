From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Makefile: Change the default compiler from "gcc" to "cc"
Date: Tue, 20 Dec 2011 17:33:07 -0800
Message-ID: <CA+55aFz-eHtttcE=WrkTTOz24Dz0iK3nTaNRWv9t5y185tNuew@mail.gmail.com>
References: <1324424447-7164-1-git-send-email-avarab@gmail.com> <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 02:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdB3m-00065U-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab1LUBda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 20:33:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56095 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1LUBd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:33:29 -0500
Received: by wgbdr13 with SMTP id dr13so13412176wgb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=aRKQF6twM00QNSdVfREWH3ZETLhJAhbUHqUynBR99n0=;
        b=mFIp43rFTVRb1EzIEHKmaKMGvMfs9xwK0XwgJmrYgp5zlqjfR9m7GDAWojR97xZyup
         JRrBoI1ZSic+GYzXM+7sXlHEyQONN9b1qXt+XuexgH9Pgiw8/vPGAG0Hb1vCUPrLvHh1
         WVWRmcNEtoFyAUfKNtJNPjq8PqA6WeorePhA0=
Received: by 10.227.60.135 with SMTP id p7mr4308675wbh.16.1324431208207; Tue,
 20 Dec 2011 17:33:28 -0800 (PST)
Received: by 10.216.172.213 with HTTP; Tue, 20 Dec 2011 17:33:07 -0800 (PST)
In-Reply-To: <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: hdtktW1wFjQEaOf2thB-YScXY_E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187546>

On Tue, Dec 20, 2011 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Would this affect folks in BSD land negatively?

Probably not.

The people who might notice are the old=time crappy commercial unixes,
but they are all dead by now. The kinds where 'cc' isn't even ANSI C,
it's K&R and you needed to pay extra for the "real" compiler.

But if those people still exist, they probably haven't figured out CVS
yet, and still use RCS or SCCS. Their brains would explode messily if
they tried to use git.

                           Linus

From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Match lightweight tags too in bash prompt
Date: Wed, 1 Dec 2010 11:08:06 -0200
Message-ID: <AANLkTik3GS6By4=k2oV77jUkyF5570qc56jgWGG9+gZr@mail.gmail.com>
References: <AANLkTikeH=MODho_GsZP5VPQmt2NOoHyfw2pbt4yqGkt@mail.gmail.com>
	<AANLkTi=0+s164XkWHho1++hvnTCAFg5=GGfMbHF4ugTE@mail.gmail.com>
	<AANLkTinoZbSqwtiRwZ5+FZyn=6y7usgFi6p-JVUUTM5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 14:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmQJ-0001Xt-FG
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 14:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab0LANIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 08:08:09 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41737 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab0LANIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 08:08:07 -0500
Received: by bwz15 with SMTP id 15so6092913bwz.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=T7VlYhb0bEwwAZ44ydnGtOOg6iCaGmEoMCz3utvJYug=;
        b=Tr/X9hQbgr2rhPmBKaa9PQYOoiJStm3tvF9NQQoF/NAllpt2lqHapKLDLk4jaZsPQt
         qdVOaIc2nKl9cTyY2P3yujVW84PVVXT1bsGRYro64GkgQmiERk+Gzmg/AXJeJJ6G4iSV
         lT7tUPi7S9J4Wj5FSnGaxhtkA7vgIPyqjGEkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FuhNMLdcG3YB6pYhvXwVTGhN+J8wyIYHfl50GA21vcZKhZ8dxduetljz3HXh4Wiq3W
         YgRp/n11nCTPeC0nI9urC2Cd+67WleJFckeFnRNvbCL7fkeJ/GmfvY5/PRhq/EWIYHJD
         //VgHI3A7rGcaXCvHg3Zvkh7oaDbGeppzp7uA=
Received: by 10.204.62.17 with SMTP id v17mr2449282bkh.67.1291208886207; Wed,
 01 Dec 2010 05:08:06 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Wed, 1 Dec 2010 05:08:06 -0800 (PST)
In-Reply-To: <AANLkTinoZbSqwtiRwZ5+FZyn=6y7usgFi6p-JVUUTM5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162510>

On Tue, Nov 30, 2010 at 9:16 PM, knittl <knittl89@googlemail.com> wrote:
> On Tue, Nov 30, 2010 at 7:04 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Fri, Nov 19, 2010 at 7:43 AM, knittl <knittl89@googlemail.com> wrote:
>>> From 1fea30e0167681917b4f40a3cb2cde9a90706011 Mon Sep 17 00:00:00 2001
>>> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
>>> Date: Fri, 19 Nov 2010 16:40:02 +0100
>>> Subject: [PATCH] Match lightweight tags too in bash prompt
>>>
>>> provide `--tags` to git describe
>>
>> Missing signed-off-by-line.
>
> i mentioned the s-o-b line already in my forward-mail ;)
>

I don't see it. You mean the From: line? If yes, that is not the
convention used here.

You have to add a line:
Signed-off-by: Your Name <you@example.com>

Take a look at Documentation/SubmittingPatches

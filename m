From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Sun, 28 Feb 2016 17:49:21 +0700
Message-ID: <CACsJy8BA49owewikfa_LpMQ5A+2DqWLtMUPck7qRrSzv+BQU_g@mail.gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
 <CACsJy8CjOkNuEg=QRTATQLkYzMxpf5zryMXERZu6Zn59VDUB_Q@mail.gmail.com>
 <17AFC0E6-FC83-4BD4-9C19-43A6B9103866@gmail.com> <CACsJy8Dc1dHp7kGgz_pY1uoXum-k3gnzD0AHFsaLQzuZihUKcw@mail.gmail.com>
 <47DA71B9-5A00-48E4-B7A8-6C678F597627@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 11:49:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZyvF-0005fW-KR
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 11:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbcB1Kty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 05:49:54 -0500
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34035 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbcB1Ktx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 05:49:53 -0500
Received: by mail-lb0-f195.google.com with SMTP id vk4so4068850lbb.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=syB2tqG36vp2PtZ2TzrO8fiHIkEfQ15Z2a4d14ui/+A=;
        b=X/3DA6JYP495WCdf+noK/9xELsnVn9oG1Pu5AkCyjtjOxqb3DfnjsKmXSAzB4Ta6rw
         6TYM9yfoCFtXIIiLhTDrJXwS0Hgx6k1t+xOzsvqFYFRaVmWrNVlVWgMKpHbnP3l9pfbA
         6CXeyigSLJ2TueTureoa1CcIdsZfypkP9rnIKBHsmQC005duRjquffBGlWknZfqpC8ch
         7pyw23IZMKuJyDGHhwxnRZ0MP0kQaHrJgeDXI/h21b8uOlE9VBdj6b4qoVv9LpE/fRzx
         rO4A1HqepiC7APa25i0s2XvRoF+vsXd3oQawH3LfA7ObPa63/7OpxF/Qdic6bsiJoAUJ
         b6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=syB2tqG36vp2PtZ2TzrO8fiHIkEfQ15Z2a4d14ui/+A=;
        b=MAJArgL/cU39JdyDbAoQc7ebaNSEDxhw2k2giET1GvxJyIAfqJlNyMrarsCyDljo2M
         dv7AofZDDdighzt1+9kUioMoXRaRWXgKF7/AzIAFVlJ/OUpVjf8ibLzYd6T4OUJOxdi+
         WOmvy8/rHBStTFEbzGAgLoosaxhNZIsyoyRbjNxsabKhFuGOv8fb6DhGxIDvEyi/uNFa
         Sr1S39wlaPN+twkiGC8NuJF/Q1vCahOHGxqwdbcqWBqus9Q9KzSpn92seOMuJmGs5T4P
         Qk/yzEwkwhaFg/PUoPqb96mB5r6KW+3pdsh36DMtMfsjQCMMjL36olpuHhar06pUQU3f
         o5bw==
X-Gm-Message-State: AD7BkJIRkJByew7lV43tVFnAJzdgA4Ql0thTKyKCerxJjWr5dwmhDJfd1gs/B1Ac7Z3+sdDOGjgVapwQrcoXNg==
X-Received: by 10.112.209.99 with SMTP id ml3mr3565988lbc.26.1456656591302;
 Sun, 28 Feb 2016 02:49:51 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 28 Feb 2016 02:49:21 -0800 (PST)
In-Reply-To: <47DA71B9-5A00-48E4-B7A8-6C678F597627@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287767>

On Sun, Feb 28, 2016 at 5:35 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 26 Feb 2016, at 10:33, Duy Nguyen <pclouds@gmail.com> wrote:
>> Probably misunderstanding. I meant something like this
>>
>> CFLAGS += -Werror
>> CFLAGS += -Wdecl..
>> CFLAGS += -Wno-form..
>
> Oh. I just realized the patch made it already into master. Do you think I should submit
> a follow up patch?

If it's already in, it's probably not worth changing it again.

> I also wonder, do you see an advantage of one style over the other or do you want me to change it for consistency?

If you add a new option at the end, then you only add one new line.
You need to add '\\' to the last line with the other format. It also
makes re-sorting a bit easier (but this point is not applicable here
because we need some special sort order, where we ignore "no-" part).
-- 
Duy

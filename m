From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work again
Date: Mon, 20 Jul 2015 16:07:18 -0700
Message-ID: <xmqq1tg2xwbd.fsf@gitster.dls.corp.google.com>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 01:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHK9d-0007FN-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 01:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbbGTXHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 19:07:21 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33296 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbbGTXHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 19:07:20 -0400
Received: by pdbnt7 with SMTP id nt7so37608259pdb.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BHlnwr7Jzhdjj2vgHw/HpG+OtrWxSlZXrLgqlwwGgr8=;
        b=hHD69ijp1z8/n6oG4mIWEX6M7HmTs6DAvoC/pw2tAJolumRcga/z9AKgYTIbii8f9z
         94JvQjhDh/DCqeoFaVGpekcOE0woMFN8V1pbWKvgP0x/X+me68/oXlN58s5KWi2JgWiT
         jRWilLBoNt8xTySp0f0L86z5rB29zT6zDrR5RoZfRoS9FlHNzH37e46SOrhD3xOGHZxh
         pxOYpBLbnyx5PO5fJjcxjfC7w5fjSCE49uUGBNTyrOlOjxcCMXfuw45/FLi9HtZ19IKX
         rGm7bB0A41UA18hV8W09qzvoEoIOfYGbdJXWam5GXtoDivFjdJnvCYgjiFJ2vcmL0qOd
         x+/Q==
X-Received: by 10.70.91.171 with SMTP id cf11mr64400816pdb.141.1437433640422;
        Mon, 20 Jul 2015 16:07:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id bf5sm23847920pad.43.2015.07.20.16.07.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 20 Jul 2015 16:07:19 -0700 (PDT)
In-Reply-To: <1437432846-5796-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Mon, 20 Jul 2015 23:54:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274361>

Philip Oakley <philipoakley@iee.org> writes:

> This updates two patches in the series based on Eric Sunshine's comments.
>
> Patch 8b updates the commit message to make clear what was going wrong.
>
> Patch 10b improves the perl code.

Is v2b like saying v3 or something else?  Does 8b replaces 8 or
updates it (i.e. comes between 8 and 9)?

> Junio: would a full re-roll be appropriate at a suitable point?

Probably, but I'd like to see people try it out and give positive
feedback first.  This part of the tree I can give no input or pre-
pushout testing at all.

Who are the people involved in this part of the system in the past?
Does "shortlog -n --no-merges contrib/buildsystems compat/vcbuild"
tell us anything?


> Philip Oakley (2):
>
>   engine.pl: ignore invalidcontinue.obj which is known to MSVC
>   engine.pl: delete the captured stderr file if empty

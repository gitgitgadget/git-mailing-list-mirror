From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 22:19:07 +0200
Message-ID: <CAHGBnuM6sgegeq0AXTcS7QNX4_X3GYNf--srq0HH0K_owG3JQg@mail.gmail.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	<20150723180846.GB18686@peff.net>
	<xmqq4mkupss7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 22:19:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIMxV-0007KO-FW
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 22:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbbGWUTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 16:19:08 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34484 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbbGWUTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 16:19:07 -0400
Received: by igvi1 with SMTP id i1so19640142igv.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d9VPsif+yHJtlkGqn7TQkzMkDtPgC+1xDkavOia8n/w=;
        b=lx09P2owpSaMyMa6ACL46yKo7aFEJe81iSwHYKK32wNnoVycas/TsYN8Q+TwfX12kT
         IfkAP7MW/ttyuk5J/VjbUPKQqJVRFs5FxZvAhP1B4xucsSR4OFr84KLyxfP09Yzz0F56
         8YUVznamqXMQ0UGn6f2xxO918OowsIEgjNwXhoeiXfheMppbfHVBr1W/7MZuC2njBEqL
         pjEktOUgq52YFS4jxF0Qa2JEXTowI7staupDTvfeAwTHXVYx5yiFc1/cxWb7ir7nfwqW
         IMYM0xnp5KnfiNsLp2wFDve1TXLQBIBRlbBT9ukDlHIoHuxKiFxHCfTikchtW6T01t1N
         2HrA==
X-Received: by 10.107.46.96 with SMTP id i93mr15934979ioo.102.1437682747096;
 Thu, 23 Jul 2015 13:19:07 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 23 Jul 2015 13:19:07 -0700 (PDT)
In-Reply-To: <xmqq4mkupss7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274524>

On Thu, Jul 23, 2015 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I haven't dug into why that happens, but possible ways to fix that
> are to make "--quiet" output all (making it consistent with "-s") or
> no (making the command totally silent) output at all ;-).

Exactly, and I chose the latter to add some value to --quiet instead
of making it an alias for -s.

-- 
Sebastian Schuberth

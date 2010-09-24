From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 09/16] t4026 (color): add missing &&
Date: Fri, 24 Sep 2010 22:55:08 +0000
Message-ID: <AANLkTi=SyN6H7RAuDW2zPekMdxwWkY+__v4df2Lj_Z3O@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-10-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:55:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHAh-0002Yy-H9
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758352Ab0IXWzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 18:55:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60922 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab0IXWzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 18:55:08 -0400
Received: by iwn5 with SMTP id 5so2742147iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nv+OoB9bHzxtxAcNz3j6WSjseqKJBY88MFtz31f33n0=;
        b=BQBCtH/K8Slo2fdJiaEYfKNIIq6PkeDJtrIet1XMnLS6Cqtc/hJFYRtxGjmgugmb8o
         f0YIARuMyt1X0vnRStK2Cph2RbEFgBdWXl1BcG52S2NCv0ISF7flAeDf5yxiKuHClLdS
         jcVVVfosmbTSuaF9UKvvB8Fpks7/hDqoQYMig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J+5OkzbtaK/7TYp4MGSPiW33JIutSftTJQAQn2GiSkszKWINWJ7xlQ5FmXcIS62JLH
         ElXA59Hr1UUlwCbfWt0vpIquGorGb5cbdltBWfo5bOiwLSaKHI7bb6+soFV7TzZWMW8N
         vMyqj1FR/LTJx9JZTdtXgQEndHKYNtRSWUIM0=
Received: by 10.231.193.135 with SMTP id du7mr2759355ibb.176.1285368908091;
 Fri, 24 Sep 2010 15:55:08 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:55:08 -0700 (PDT)
In-Reply-To: <1285366976-22216-10-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157096>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:
> FIXME: Is it intended that this git config --unset fail? =C2=A0I had =
to add a
> test_might_fail as well.

Presumably this is to work around the user having diff.color in his
config or something? Should we be leaking like that?

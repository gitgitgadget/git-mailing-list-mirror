From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] parse-options: make OPT_NUMBER's argh explicit
Date: Wed, 3 Jun 2009 12:35:27 -0700
Message-ID: <780e0a6b0906031235q1438b76cyba1172556c94d1d0@mail.gmail.com>
References: <1244015367-16998-1-git-send-email-bebarino@gmail.com> 
	<4A264DFA.3090309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBwFe-00053N-SH
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZFCTfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 15:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbZFCTfq
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:35:46 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:39359 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbZFCTfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 15:35:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so281973and.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xRwawt0bTTcuaDS7rd0NZRtX4Jn3hsViJl4leFwywm0=;
        b=TnqEwoYTPQ75S1F4Nt9aB2g/ykxmnj0ULsck9nAgHkBuNeSLIRYoP/9HixC0ueYNqG
         teAomN94RwqGdMwU7pbRuUhN+9uG3cRThEZ/lYvIWSbZoLqfP4V/YBUbvBSuGQQlGl0u
         eaZvJUGGYcPCO289rtCBkxUhNkZpMQaY0h5bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xPd/ShqMvN9PFaQ8z+lcNcD4T90c7YAiHmzc8KZuBzQQ58//+LW9KSiFLhcqSO6BNs
         W6UAQCLqL1YHYCR2vvzuN86Kcp1HSwQMka5gOzxPkn4tl7c4urmqZRwIMTQ8xGc/XbZP
         xYsacHinkAhj7soV4IajThO6dorMUMnAo/eRM=
Received: by 10.100.228.6 with SMTP id a6mr1659043anh.15.1244057747250; Wed, 
	03 Jun 2009 12:35:47 -0700 (PDT)
In-Reply-To: <4A264DFA.3090309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120632>

On Wed, Jun 3, 2009 at 3:18 AM, Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.=
ath.cx> wrote:
>
> Nice code reduction. =C2=A0s/NUMBER/INTEGER/ in the commit message?

Oops. Thanks, I'll fix that.

>
> By the way, can the switch be replaced by a simple check for
> PARSE_OPT_NOARG now?
>

This looks possible. I think just set PARSE_OPT_NOARG as the flag of
the appropriate OPT_* macros. I'll have to grep the tree for custom
uses of OPTION_* though.

Should that be all squashed together? Or maybe that could be a follow u=
p patch?

From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/4] enter_repo: do not modify input
Date: Tue, 4 Oct 2011 19:01:22 -0400
Message-ID: <CABURp0qEQdjLsUxQkf3jSAHU80NOZEqm9iEksZKST_JfK590Qw@mail.gmail.com>
References: <4E8B8DEA.1000606@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 01:01:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBDzf-0003Ng-Vv
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 01:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672Ab1JDXBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 19:01:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50493 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933137Ab1JDXBn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 19:01:43 -0400
Received: by wwf22 with SMTP id 22so1574907wwf.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D0yJ0qnE3ysce6Vj/rmyY5PmsfSAtdYtJIsqzCUCHiA=;
        b=LLBG4xnLEx25aiGINZJDWZoQsViY7l40La1+U7M5IRImatrdu/qiXJw0h1nHD6olXb
         xbiWMCKuywugqpPrcgcp0fuWUjf4JZT+OrqUEK3Xz8GCiwbIVir11XHm6MBlwPxdmSbY
         ZaHwksJmTMUlbeF62OWP4iwxXsBMIf5tmLcjY=
Received: by 10.216.133.129 with SMTP id q1mr2239601wei.87.1317769302101; Tue,
 04 Oct 2011 16:01:42 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 16:01:22 -0700 (PDT)
In-Reply-To: <4E8B8DEA.1000606@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182812>

On Tue, Oct 4, 2011 at 6:51 PM, Phil Hord <hordp@cisco.com> wrote:
> From: Erik Faye-Lund <kusmabite@gmail.com>
>
> +++ b/daemon.c
> @@ -108,11 +108,11 @@ static void NORETURN daemon_die(const char *err=
,
> va_list params)
> =A0 =A0 exit(1);

Blast!  Borked again.

I'll re-work on this and try again tomorrow.

P

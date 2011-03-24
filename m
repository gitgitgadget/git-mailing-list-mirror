From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] exec_cmd: remove unused extern
Date: Thu, 24 Mar 2011 11:39:01 +0100
Message-ID: <AANLkTinhknijHo9Qo=rqik3ksjT27AVSLhcac-tGByx9@mail.gmail.com>
References: <1294696849-1428-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 11:39:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2hwu-0000SX-4M
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 11:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab1CXKjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 06:39:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63052 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab1CXKjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 06:39:22 -0400
Received: by fxm17 with SMTP id 17so8267230fxm.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=ep6uMxpDVgB1EQPlvNsg/kqIJitHOs2jA+e+g29XWsM=;
        b=gml5ffSl1dfpLPcLpOeIcmbikBnSGSfoR+I78UMXTnumo/gw7/N+MWtFyGDmz0wMWr
         QjQFjdF+DpOCRPNZkSp7NEJw66foHNNa3WyDvdwhI5Umq+nrmONgGaVdKzfQlJ/6TmFa
         8/lcRh1B90W/Q+7R/SoSM4el9Y8COYKfHzXLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=JCdblqk4izm1xzifnmFHhOE4h2r9QC16Ophzfkna9DnoYaj/QhotDgczRZOhePMV+C
         Mt/UNTxnRxrR1EQ0IUEYhzD8PlR7SOg8UwUi17eeWl7QXw19tUuG2xb2Kw1DIa5gjr74
         oa4o0EUldnfKsU2OMPM+j1qpZ7kkTXnG4Q1jU=
Received: by 10.223.15.141 with SMTP id k13mr4394361faa.30.1300963161047; Thu,
 24 Mar 2011 03:39:21 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Thu, 24 Mar 2011 03:39:01 -0700 (PDT)
In-Reply-To: <1294696849-1428-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169910>

On Mon, Jan 10, 2011 at 11:00 PM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> This definition was added by commit 77cb17e9, but it's left unused si=
nce
> commit 511707d. Remove the left-over definition.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> Just a left-over definition I found while looking through some code.
>
> =A0exec_cmd.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index bf22570..38545e8 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -3,7 +3,6 @@
> =A0#include "quote.h"
> =A0#define MAX_ARGS =A0 =A0 =A0 32
>
> -extern char **environ;
> =A0static const char *argv_exec_path;
> =A0static const char *argv0_path;
>

Bump? Or is this just too insignificant?

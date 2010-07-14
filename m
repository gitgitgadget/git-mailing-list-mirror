From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for 
	user-friendliness
Date: Wed, 14 Jul 2010 09:04:49 +0000
Message-ID: <AANLkTil4XkVXM-96Jb7UOpH2CZBmtXEf7eEIIgrsqhg5@mail.gmail.com>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
	<1279076475-27730-5-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 14 11:04:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYxte-0006bn-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 11:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab0GNJEv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 05:04:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43536 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab0GNJEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 05:04:50 -0400
Received: by iwn7 with SMTP id 7so6806617iwn.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3ZPWQIMise7MS3Sxis9SHDXL5PpdK/PDMF+4DCRL3bY=;
        b=ZqskHN9anv8tRiupG9dLRuLKGMfxmxjQsWu1D17I6htZCCKlaC26BjN+rey4cf7R95
         lyjUKDh78rj5XMpJMyasDbj2dGNAjeSR9qlo57j/Kkn2QLZIyXjvkBT6D21dbb/IbC7T
         ypAJxOtlV0nmbX0295lUx6dx+vEHevXCW+BvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rpvuLuUJkeR3eQQ3LbyzzZDxNXAVYGYH7HzdIAkuftuizfchpFe+EOjH9Sg8v0hzPS
         P2IRRhKpAzENk+SQb7+sjEv46jC1wL8fna94OeiNFjmpnhE4YwNtDKYjls6+mYTX0gxz
         TrYsx5+QtsUlk0wEMCGLI/MgDb00FP9qcvQUw=
Received: by 10.231.34.11 with SMTP id j11mr5158196ibd.120.1279098289228; Wed, 
	14 Jul 2010 02:04:49 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 14 Jul 2010 02:04:49 -0700 (PDT)
In-Reply-To: <1279076475-27730-5-git-send-email-gdb@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150974>

On Wed, Jul 14, 2010 at 03:01, Greg Brockman <gdb@mit.edu> wrote:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execl(prog, prog, =
(char *) NULL);

Why the casting of NULL? It's not done in the builtin/help.c code.

Anyway, if it was cast it should be to (const char *), shouldn't it?

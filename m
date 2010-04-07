From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v4] Remove --allow-empty from the git-commit synopsis
Date: Wed, 7 Apr 2010 12:45:48 -0700
Message-ID: <j2s780e0a6b1004071245jaaaf8d20r71720749c29227b8@mail.gmail.com>
References: <7vfx37cckf.fsf@alter.siamese.dyndns.org> <1270668498-30495-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, gitster@pobox.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzbCe-0005EY-IN
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab0DGTqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 15:46:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36401 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab0DGTqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 15:46:03 -0400
Received: by pwj9 with SMTP id 9so1335549pwj.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Vv116lbsIfZDxOhZB1dkdD7ErfzqpBev/8Zs2ARGxDI=;
        b=hy9BAy+A70wAy4yhOf1qFU46UtJdztU2HXKh5bJatG0NLDnDSF/PVRGxaZUWap7kQV
         3vR7Hmir9ZH+fn3HXMyeznq44Pw8mgAQuiJ9KrchEmDiGmH6Mm43p8+DbneV8wpumug/
         A0PjA4Dp1i1bu3WFcX0UZQCdn9YDfmWh+9ldY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LUldAQusIJWHNQ39oEYN1Sd8WFH/WfGPE/bL4NZvhx94hwfwGrQsFfK878GZII0SS7
         hOZ8Ouejbb6euu/axuO29MTB7C3N+q2H5wOcc6Zh6kDIA8lkjsUOT7XQwvQo2OLIrhUM
         y8Gwpl7ytfcYeEI1Z6H1F0LHRc93KuQEHdSsc=
Received: by 10.143.19.3 with HTTP; Wed, 7 Apr 2010 12:45:48 -0700 (PDT)
In-Reply-To: <1270668498-30495-1-git-send-email-avarab@gmail.com>
Received: by 10.142.2.22 with SMTP id 22mr3830797wfb.13.1270669563104; Wed, 07 
	Apr 2010 12:46:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144277>

On Wed, Apr 7, 2010 at 12:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> As for Jeff's suggestion of omitting options from the `--help' output=
:
> I couldn't find a way to do that using parse-options.[ch]. It's also
> customary for `--help' to include the full usage examples regardless
> of how long they get (just look at wget, ls etc.). The SYNOPSIS
> sections in manual pages by comparison usually aim for brevity.
>

You can hide options from the -h output (not --help-all) by using the
PARSE_OPT_HIDDEN flag.

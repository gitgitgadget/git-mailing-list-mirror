From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/8] cmd_merge: convert to single exit point
Date: Thu, 17 Nov 2011 16:09:05 +0530
Message-ID: <CALkWK0kME4fgLK0S+sFRXmDX1uj_N5+PZnvLFJp33qNssPptWQ@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com> <1321522335-24193-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:39:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQzNU-0003lm-LI
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab1KQKj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 05:39:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40695 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab1KQKj1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 05:39:27 -0500
Received: by wwe5 with SMTP id 5so2645820wwe.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kvidOSzScOYQpxEbg3kZ0336ydA3aVC9Sk4E6zm5CnM=;
        b=RcLbYXzxWKVotEan/qfEQ3yFfu5Ryzsk/PJB2JD9NXMr6ff72QE6kfu7QvEiPYLZJk
         PrAvC7cGC0IkQtJZVIDat0jGE4j/+8RejHCk82Q0QlEg2u3vhJteFQKMYr1HydBApKbL
         ugXgs0m0m9CgsTt5e/2uvlL/UaotUqGrhnGgI=
Received: by 10.216.188.145 with SMTP id a17mr5840833wen.24.1321526366086;
 Thu, 17 Nov 2011 02:39:26 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Thu, 17 Nov 2011 02:39:05 -0800 (PST)
In-Reply-To: <1321522335-24193-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185592>

Hi again,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [Subject: [PATCH 4/8] cmd_merge: convert to single exit point]
>
> This makes post-processing easier.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0builtin/merge.c | =C2=A0 48 +++++++++++++++++++++++++++++------=
-------------
> =C2=A01 files changed, 29 insertions(+), 19 deletions(-)

Um, (how) does this seemingly unrelated patch belong to the series?

Thanks.

-- Ram

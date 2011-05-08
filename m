From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/4] i18n: Add shell script translation infrastructure
Date: Sun, 8 May 2011 19:03:39 +0200
Message-ID: <BANLkTi=nTSf0CQWs-ODxw=P+eX=Dc7Yf-Q@mail.gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 19:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ7PJ-00034P-Nn
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 19:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab1EHREV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 13:04:21 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50558 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab1EHREU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 13:04:20 -0400
Received: by qyg14 with SMTP id 14so3520026qyg.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Lf+8G30mbkZ6t5hYvwzFoRr5/E8mh1/K+P9gBDMaY5A=;
        b=dZEWDoo3k6GrSluP/tu95PhZGI9RDumN4OxDjQaCsKxCEayz+zkoNBQqYDPimjoXoQ
         NC8Fd0f2GYu5NcV4kLAKv4Xzeasc/zeiZckWXKlrrxbV1K//0MlU3i5KAP1EmNNsuAal
         123DGt12b9EnzadFGpBwsg2aSkRxs4V+7yrmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CcK9MB1/uuqekF8yBPbh7k8wY8k5m3CyQIdW5dvrV7QcEl2nn7izFjtL/3z+MRvrqo
         xtX11Ii7no1FnP6x9fzA+bJJTf6UnUcFTgZwyD50Po6UJq1lbAXPzqr5H5f9yLjyu6EU
         0qEAupXcUIir7Fic83PsrFu8hNC+xigD8cryM=
Received: by 10.229.42.142 with SMTP id s14mr4428246qce.174.1304874259138;
 Sun, 08 May 2011 10:04:19 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Sun, 8 May 2011 10:03:39 -0700 (PDT)
In-Reply-To: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173162>

Heya,

On Sun, May 8, 2011 at 14:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> This adds skeleton no-op functions to git-sh-i18n.sh analogous to the
> gettext.c skeleton functions for C, adds *.sh scripts to the "pot"
> target for message extraction, and updates the git-sh-i18n--envsubst
> tests to use the new test_i18ncmp function.

I seem to remember there were some concerns about performance with a
previous version of this series. Have you done any before/after
timings on, say, the git test suite? Or am I remembering incorrectly?

--=20
Cheers,

Sverre Rabbelier

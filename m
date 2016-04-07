From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] builtin/interpret-trailers: suppress blank line
Date: Thu, 07 Apr 2016 19:35:27 +0200
Message-ID: <vpqoa9ltj8g.fsf@anie.imag.fr>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:35:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDqY-0001AV-BA
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbcDGRfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:35:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42293 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbcDGRfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:35:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u37HZPhj011883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 7 Apr 2016 19:35:25 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u37HZRmB006161;
	Thu, 7 Apr 2016 19:35:27 +0200
In-Reply-To: <1460042563-32741-3-git-send-email-mst@redhat.com> (Michael S.
	Tsirkin's message of "Thu, 7 Apr 2016 18:23:10 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 07 Apr 2016 19:35:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u37HZPhj011883
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460655328.05005@gwcSgUUeJniWaX25NXkKDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290938>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> it's sometimes useful to be able to pass output message of
> git-mailinfo through git-interpret-trailers,
> but that creates problems since that does not
> include the subject and an empty line after that,
> making interpret-trailers add an empty line.

Nit: we usually wrap our text around 72 columns in the commit message.
Yours is wrapped weirdly.

> Add a flag to bypass adding the blank line.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  trailer.h                    |  2 +-
>  builtin/interpret-trailers.c |  9 +++++++--
>  trailer.c                    | 10 +++++++---
>  3 files changed, 15 insertions(+), 6 deletions(-)

You'd definitely need some tests and documentation if you introduce a
new option.

No time for a real review, sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

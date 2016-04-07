From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 07 Apr 2016 19:17:42 +0200
Message-ID: <vpqtwjduymh.fsf@anie.imag.fr>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-2-git-send-email-mst@redhat.com>
	<xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:18:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDZr-0006bY-B4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525AbcDGRSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:18:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41989 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcDGRSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:18:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u37HHeHK008044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 7 Apr 2016 19:17:40 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u37HHgkA005940;
	Thu, 7 Apr 2016 19:17:42 +0200
In-Reply-To: <xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Apr 2016 09:55:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 07 Apr 2016 19:17:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u37HHeHK008044
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460654261.11427@28JT+Yto+PwnPHQ9MIzuIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290930>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> Allow -t as a short-cut for --trailer.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>
> As I do not think interpret-trailers is meant to be end-user facing,
> I am not sure I should be interested in this step.
>
> I am in principle OK with the later step that teaches a single
> letter option to end-user facing "git am" that would be turned into
> "--trailer" when it calls out to "interpret-trailers" (I haven't
> checked if 't' is a sensible choice for that single letter option,
> though).

If 'am' has -t == --trailer, I think it makes sense to have the same
shortcut in interpret-trailers for consistency.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Fri, 04 Mar 2016 07:50:07 +0100
Message-ID: <vpqvb52g2jk.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqd1rbiifi.fsf@anie.imag.fr>
	<CAPig+cTC-fkJS5Lskww+qRW5XEqFK4f6fBbY6MBqJWKv5UN_ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 07:50:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abjZ9-0007Cf-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 07:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbcCDGuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 01:50:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55762 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcCDGuR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 01:50:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u246o7HC027273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 4 Mar 2016 07:50:07 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u246o7Xq008036;
	Fri, 4 Mar 2016 07:50:07 +0100
In-Reply-To: <CAPig+cTC-fkJS5Lskww+qRW5XEqFK4f6fBbY6MBqJWKv5UN_ug@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Mar 2016 20:01:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 04 Mar 2016 07:50:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u246o7HC027273
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457679009.65683@RnOvwGt4wE75w3HGn9QksA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288235>

Eric Sunshine <sunshine@sunshineco.com> writes:

> It would be reasonable to combine the two cases into one:
>
>     if (opt_autostash != -1)
>         die(_("--[no]-autostash option is only valid with --rebase."));

Nit (in case Mehul copy/paste this): that would be --[no-], not --[no]-.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

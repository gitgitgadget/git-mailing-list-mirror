From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 11 Mar 2016 14:30:28 +0100
Message-ID: <vpq8u1p16rv.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
	<CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
	<CA+DCAeSvjyy6WO=n-wdo3_yHGSWmUC0Epbt-OYLF_fbuczeeKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9S-0000v6-4T
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbcCKNak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:40 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56251 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbcCKNae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:34 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u2BDUQ8Z008670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 11 Mar 2016 14:30:26 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2BDUS9j001496;
	Fri, 11 Mar 2016 14:30:28 +0100
In-Reply-To: <CA+DCAeSvjyy6WO=n-wdo3_yHGSWmUC0Epbt-OYLF_fbuczeeKA@mail.gmail.com>
	(Mehul Jain's message of "Fri, 11 Mar 2016 18:45:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Mar 2016 14:30:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2BDUQ8Z008670
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1458307827.34785@hy9oqa5+Mgx8/qZHxzh2ow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288685>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Fri, Mar 11, 2016 at 10:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>>  static int config_autostash = -1;
>>
>> Hmm, why can't config_autostash just default to 0?
>
> Previously Junio recommended not to explicitly initialize a
> static to 0 (or NULL).
> http://thread.gmane.org/gmane.comp.version-control.git/287709/focus=287726

What Junio says is that you don't need to write

static int config_autostash = 0;

since it is equivalent to

static int config_autostash;

But there's nothing wrong with having a static variable defaulting to 0.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

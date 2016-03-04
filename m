From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Fri, 04 Mar 2016 07:51:40 +0100
Message-ID: <vpqpovag2gz.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqd1rbiifi.fsf@anie.imag.fr>
	<CA+DCAeSRN=nqhnv14kvbnxExiSBPnA3hLP8hY0fbd+YgTR3TNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>, sunshine@sunshineco.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 07:51:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abjaZ-000830-89
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 07:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbcCDGvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 01:51:47 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48317 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbcCDGvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 01:51:46 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u246pdFf016487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 4 Mar 2016 07:51:39 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u246peOx008059;
	Fri, 4 Mar 2016 07:51:40 +0100
In-Reply-To: <CA+DCAeSRN=nqhnv14kvbnxExiSBPnA3hLP8hY0fbd+YgTR3TNw@mail.gmail.com>
	(Mehul Jain's message of "Fri, 4 Mar 2016 11:07:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 04 Mar 2016 07:51:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u246pdFf016487
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457679101.11972@9PVb/oRtpv0075JXRw8pRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288236>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Thu, Mar 3, 2016 at 10:54 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Mehul Jain <mehul.jain2029@gmail.com> writes:
>>> +     else {
>>> +             /* If --[no-]autostash option is called without --rebase */
>>> +             if (opt_autostash == 0)
>>> +                     die(_("--no-autostash option is only valid with --rebase."));
>>> +             else if (opt_autostash == 1)
>>
>> The else is not needed since the other branch dies.
>
> I'm bit confused here. Which "else" you are talking about.

The last "else" keyword. Not the "else" branch. It would just work like
this, and be a bit more pleasing to my eyes:

if (...)
	die(...);
if (...)
	die(...);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

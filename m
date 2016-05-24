From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Tue, 24 May 2016 14:49:23 +0200
Message-ID: <vpqshx77h9o.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<20160523195504.GA8957@dcvr.yhbt.net>
	<0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue May 24 14:49:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5BmE-0007SB-MO
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 14:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbcEXMta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 08:49:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46984 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbcEXMta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 08:49:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4OCnLV1025592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 24 May 2016 14:49:22 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4OCnN7j021645;
	Tue, 24 May 2016 14:49:23 +0200
In-Reply-To: <0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org> (Samuel
	GROOT's message of "Tue, 24 May 2016 14:43:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 24 May 2016 14:49:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4OCnLV1025592
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464698963.86913@GSqgD83b/XikvqDqSDDoaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295492>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> On 05/23/2016 09:55 PM, Eric Wong wrote:
>> Tom Russello <tom.russello@grenoble-inp.org> wrote:
>>> This new option takes an email message file, parses it, fills the "To",
>>> "Subject" and "Cc" fields appropriately and quote the message.
>>> This option involves the `--compose` mode to edit the cover letter quoting the
>>> given email.
>>
>> Cool!  There should probably be some help text to encourage
>> trimming down the quoted text to only relevant portions.
>
> What kind of help text would you want to see?
>
> Maybe something like this:
>
>   GIT: Quoted message body below.
>   GIT: Feel free to trim down the quoted text
>   GIT: to only relevant portions.
>
> As "GIT:" portions are ignored when parsed by `git send-email`.

That's an option, but in the context of email, I think these
instructions are not necessary.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

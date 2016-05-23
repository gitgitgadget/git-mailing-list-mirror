From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Mon, 23 May 2016 22:07:18 +0200
Message-ID: <vpqmvng8rnt.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<20160523195504.GA8957@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	samuel.groot@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Mon May 23 22:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4wGb-0008NX-9S
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 22:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbcEWUNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 16:13:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34757 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbcEWUHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 16:07:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4NK7GCZ013243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 23 May 2016 22:07:16 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4NK7IjH002479;
	Mon, 23 May 2016 22:07:18 +0200
In-Reply-To: <20160523195504.GA8957@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 23 May 2016 19:55:04 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 23 May 2016 22:07:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4NK7GCZ013243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464638838.16434@4FB8fAs8WucRVOBfi61QEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295388>

Eric Wong <e@80x24.org> writes:

> Tom Russello <tom.russello@grenoble-inp.org> wrote:
>
>> +	#Message body
>> +	while (<$fh>) {
>> +		#for files containing crlf line endings
>> +		$_=~ s/\r//g;
>> +		my $space="";
>> +		if (/^[^>]/) {
>> +			$space = " ";
>> +		}
>> +		$message_quoted .=  ">".$space.$_;
>
> Is this really necessary to switch between "> " and ">" prefix?
> AFAIK, MUAs prefix unconditionally with "> ".

I had the same question, but at least my mailer (Gnus) has the same
special-case it seems.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

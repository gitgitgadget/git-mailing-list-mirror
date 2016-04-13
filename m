From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 14:30:06 +0200
Message-ID: <vpq1t69669d.fsf@anie.imag.fr>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
	<vpqegaa9i89.fsf@anie.imag.fr>
	<BF053934-BA62-4621-AAAA-11F821B274EA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:30:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqJwg-0002lt-AV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759278AbcDMMah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 08:30:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51342 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759195AbcDMMag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:30:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3DCU5hm015444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Apr 2016 14:30:05 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3DCU6eC011744;
	Wed, 13 Apr 2016 14:30:06 +0200
In-Reply-To: <BF053934-BA62-4621-AAAA-11F821B274EA@gmail.com> (Lars
	Schneider's message of "Wed, 13 Apr 2016 14:16:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 13 Apr 2016 14:30:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3DCU5hm015444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461155406.31787@VvCnQPoTtjT7Zmw7k7Y5Yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291393>

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 13 Apr 2016, at 07:43, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> 
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> 
>>> True, presumably the Travis integration already solves that part, so
>>> I suspect it is just the matter of setting up:
>>> 
>>> - a fork of git.git and have Travis monitor any and all new
>>>   branches;
>>> 
>>> - a bot that scans the list traffic, applies each series it sees to
>>>   a branch dedicated for that series and pushes to the above fork.
>> 
>> ... and to make it really useful: a way to get a notification email sent
>> on-list or at least to the submitter as a reply to the patch series.
>> Just having a web interface somewhere that knows how broken the code is
>> would not be that useful.
>
> Travis CI could do this but I intentionally disabled it to not annoy anyone.
> It would be easy to enable it here:
> https://github.com/git/git/blob/7b0d47b3b6b5b64e02a5aa06b0452cadcdb18355/.travis.yml#L98-L99

The missing part would be "as a reply to the patch series". When I start
reviewing a series, if the patch is broken and the CI system already
knows, I'd rather have the information attached in the same thread right
inside my mailer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

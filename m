From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 20 Mar 2016 21:28:58 +0100
Message-ID: <vpqlh5c99md.fsf@anie.imag.fr>
References: <56E3BE3E.9070105@gmail.com>
	<1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
	<xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
	<FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
	<xmqq7fh5as54.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Sidhant Sharma <tigerkid001@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 21:29:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahjyY-0002I8-Ov
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 21:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbcCTU3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 16:29:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49834 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcCTU3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 16:29:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2KKSt9x030735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Mar 2016 21:28:56 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2KKSwmp017091;
	Sun, 20 Mar 2016 21:28:58 +0100
In-Reply-To: <xmqq7fh5as54.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Mar 2016 10:25:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 20 Mar 2016 21:28:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2KKSt9x030735
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459110539.76627@99Kpzdx+g+b3PfThTa0fcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289384>

Junio C Hamano <gitster@pobox.com> writes:

> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> On 14 Mar 2016, at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> I recall back in the days when people said that Hg's command set was
>>> so much more pleasant to use that some people thought about building
>>> Hg's command line UI on top of low level implementation of the Git's
>>> data structure....
>>> ...
>>
>> I think a "ggit" wrapper should not introduce any new commands or
>> new parameters. Everything should be passed unmodified to Git.
>> The wrapper would only add additional warnings...
>
> Somehow I was assuming that you are aiming for a more ambitious
> project, where the users get an easier-to-learn-and-understand
> command line UI experience than bare Git [*1*],

I think the proposed approach makes much more sense, at least because:

* At some point, ggit users should become git users and the transition
  should be smooth.

* ggit users will find advices/documentation/tutorials here and there on
  the web, or talk to their friends who use git, and they want this
  information to apply to ggit.

Also, having an alternative UI sometimes serves as an excuse not to
improve git's UI itself. If git's behavior is dangerous, ggit can warn
about it. If git's behavior is broken, then we should repair it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Mon, 03 Mar 2014 23:39:11 +0100
Message-ID: <vpqlhwqc3g0.fsf@anie.imag.fr>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
	<CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
	<vpqlhwsr3ww.fsf@anie.imag.fr> <53144881.6090702@alum.mit.edu>
	<vpq7g8bfws8.fsf@anie.imag.fr>
	<xmqqha7fnebn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbWJ-0006zQ-3M
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbaCCWja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:39:30 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35543 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913AbaCCWj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:39:29 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s23Md9XD026723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2014 23:39:09 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s23MdBKK025190;
	Mon, 3 Mar 2014 23:39:11 +0100
In-Reply-To: <xmqqha7fnebn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Mar 2014 13:48:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 03 Mar 2014 23:39:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s23Md9XD026723
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394491150.54432@KdngD6XINxkBcB/qQ60ndQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243293>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Or perhaps "-NUM" should fail with an error message if any of the last
>>> NUM commits are merges.  In that restricted scenario (which probably
>>> accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".
>>
>> Makes sense to me. So, -NUM would actually mean "rebase the last NUM
>> commits" (as well as being an alias for HEAD~NUM), but would fail when
>> it does not make sense (with an error message explaining the situation
>> and pointing the user to HEAD~N if this is what he wanted).
>>
>> This would actually be a feature for me: I often want to rebase "recent
>> enough" history, and when my @{upstream} isn't well positionned,...
>
> Could you elaborate on this a bit?  What does "isn't well
> positioned" mean?

The most common case is when @{upstream} is not positionned at all,
because I'm on a temporary branch on which I did not configure it. The
other case is when I did a manual merge of a branch other than upstream.

As I said in another message, there would probably be cleaner solutions,
but the trial and error one does not work that bad.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

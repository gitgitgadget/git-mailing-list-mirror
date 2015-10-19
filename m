From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Mon, 19 Oct 2015 21:42:58 +0200
Message-ID: <vpq4mhmablp.fsf@grenoble-inp.fr>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-4-git-send-email-tklauser@distanz.ch>
	<CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
	<xmqqwpukayde.fsf@gitster.mtv.corp.google.com>
	<20151019134633.GL2468@distanz.ch>
	<CAP8UFD2pqg_J36V9wZkAR0b-L421gHFi9SbRqFwBbZ1LMVOKSg@mail.gmail.com>
	<CAPig+cR4wyumSfzXjptCfniuN0QC8TErL1X9LDPMsCD8wHP_kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 21:43:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoGL0-00009l-65
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 21:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbbJSTnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 15:43:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52022 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbbJSTnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 15:43:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9JJgubd029243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 19 Oct 2015 21:42:56 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9JJgwbk031902;
	Mon, 19 Oct 2015 21:42:58 +0200
In-Reply-To: <CAPig+cR4wyumSfzXjptCfniuN0QC8TErL1X9LDPMsCD8wHP_kA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 19 Oct 2015 15:24:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 19 Oct 2015 21:42:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9JJgubd029243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445888579.71397@H3imQcoJX9LSTgMkB0SGJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279888>

Eric Sunshine <sunshine@sunshineco.com> writes:

> With this in mind, my
> question was also indirectly asking whether there was sufficient
> justification of the long-term cost of a --count-lines option. The
> argument that --count-lines would help test a proposed
> strbuf_count_lines() likely does not outweigh that cost.

I agree. If we expect users to call --count-lines outside
rebase-interactive.sh and our own tests, then the actual use should be
justified in the commit message.

If not, then at least the --count-lines option should be hidden and not
documented in the public doc. But I agree that introducing test-strbuf
would be even better.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

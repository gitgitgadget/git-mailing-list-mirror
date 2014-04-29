From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Tue, 29 Apr 2014 14:29:46 +0200
Message-ID: <vpq4n1cxqrp.fsf@anie.imag.fr>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	<87vbtt6dyq.fsf@fencepost.gnu.org> <vpqsioxn82l.fsf@anie.imag.fr>
	<87k3a96cj9.fsf@fencepost.gnu.org> <vpq38gxlk3m.fsf@anie.imag.fr>
	<20140428162439.GA9844@sigill.intra.peff.net>
	<xmqqk3a9qoib.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 14:30:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf7Au-0004Nd-GA
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 14:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933932AbaD2MaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 08:30:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52967 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932982AbaD2MaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 08:30:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3TCTjNe027672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Apr 2014 14:29:45 +0200
Received: from anie.imag.fr (ensi-vpn-253.imag.fr [129.88.57.253])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3TCTk6M023468;
	Tue, 29 Apr 2014 14:29:46 +0200
In-Reply-To: <xmqqk3a9qoib.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Apr 2014 11:48:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Apr 2014 14:29:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3TCTjNe027672
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399379386.95017@LQnUeLdX4pKuV5Tr7NDjrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247580>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Mon, Apr 28, 2014 at 02:22:21PM +0200, Matthieu Moy wrote:
>>
>> I'd be OK with doing the moral equivalent for now (perhaps just taking
>> Junio's proposal[1]), and I can deal with the refactoring later when
>> re-rolling the Makefile series.
>>
>> -Peff
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/240637
>
> I doubt we would want to use the patch verbatim in that message; it
> served its purpose well to illustrate that there may be other ways
> to address the issue, but I agreed with the flaw in it you pointed
> out in the thread [*1*]
>
> I also agree that droppage of S does not have to wait for that
> topic.

So, shall I rewrite my patch on top of master? (not hard, but there will
be a minor conflict to resolve when merging with Peff's cooking series).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

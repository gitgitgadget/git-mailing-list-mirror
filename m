From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 14:22:21 +0200
Message-ID: <vpq38gxlk3m.fsf@anie.imag.fr>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	<87vbtt6dyq.fsf@fencepost.gnu.org> <vpqsioxn82l.fsf@anie.imag.fr>
	<87k3a96cj9.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jeff King <peff@peff.net>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weka4-0001hV-8l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 14:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbaD1MWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 08:22:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53783 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbaD1MWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 08:22:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3SCMK5a031788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2014 14:22:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3SCMLqp006749;
	Mon, 28 Apr 2014 14:22:21 +0200
In-Reply-To: <87k3a96cj9.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 28 Apr 2014 11:14:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Apr 2014 14:22:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3SCMK5a031788
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399292544.40697@OI59S4BT56RA/UF2Ay8L+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247308>

David Kastrup <dak@gnu.org> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> There seem to be a few more occurences (git-sh-setup.sh and pager.c):
>>
>> Not since f82c3ffd862c7 (Wed Feb 5 2014, move LESS/LV pager environment
>> to Makefile).
>
> The only upstream branch containing this commit is pu.  So this patch
> should likely not go anywhere else for now.

Oops, indeed, I made my patch on top of pu by mistake. Anyway, my patch
can wait for the other series to be merged.

Jeff, you're the author of f82c3ffd862c7, topic jk/makefile in git.git,
marked "expecting a reroll" by Junio. Any news from the series?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

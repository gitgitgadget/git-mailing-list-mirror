From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Only show completions from refs/heads
Date: Mon, 02 Mar 2009 08:45:19 +0100
Message-ID: <87zlg4qsfk.fsf@krank.kagedal.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org> <87fxi3x2es.fsf@wine.dyndns.org>
	<87y6vvu8sa.fsf@krank.kagedal.org> <87bpsrx1j1.fsf@wine.dyndns.org>
	<87vdqztvrl.fsf_-_@krank.kagedal.org> <87prh1tc5y.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 08:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2rT-00080G-8g
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbZCBHpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 02:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZCBHpW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 02:45:22 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:55636 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbZCBHpW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 02:45:22 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5F7B940018;
	Mon,  2 Mar 2009 08:45:11 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 510994002A; Mon,  2 Mar 2009 08:45:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 1F2AD40018;
	Mon,  2 Mar 2009 08:45:11 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 62353DC49E; Mon,  2 Mar 2009 08:45:19 +0100 (CET)
In-Reply-To: <87prh1tc5y.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Sun\, 01 Mar 2009 17\:56\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111910>

Alexandre Julliard <julliard@winehq.org> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
>> ---
>>
>> Here is a version that can to both commit name lookup and branch nam=
e
>> lookup, and with a configuration parameter that determines how to fi=
nd
>> branch names to complete on.
>
> Why do you introduce a separate function for checkouts?  I don't see
> much need to have a different set of completions for checkout
> vs. cherry-pick, they both can be used with an arbitrary commit anywa=
y.

Yes, but the typical uses differ a lot. The (overwhelmingly) typical
use of checkout is to switch to another branch. The typical use of
cherry-pick is to pick any commit and not treat branch heads
specially.

So when switching branches, I obviously want a simple way to select
which branch to switch to. When cherry-picking, I would need some
simple way of picking any single commit, but that's hard so making it
easy to pick any named commit is probably the reasonable solution.

--=20
David K=C3=A5gedal

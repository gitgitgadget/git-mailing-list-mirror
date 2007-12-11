From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary mode.
Date: Tue, 11 Dec 2007 09:58:03 -0800
Message-ID: <7vzlwhdsgk.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<200712080636.12982.chriscool@tuxfamily.org>
	<20071211092446.GA4703@elte.hu>
	<20071211092916.GF30948@artemis.madism.org>
	<m3ve75sfn3.fsf@roke.D-201>
	<20071211115914.GJ30948@artemis.madism.org>
	<20071211122539.GA13945@sigill.intra.peff.net>
	<20071211140508.GA12204@elte.hu>
	<20071211144351.GA15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 18:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29Nj-0006Vn-18
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbXLKR60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 12:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXLKR6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:58:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbXLKR6Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 12:58:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 10F87508E;
	Tue, 11 Dec 2007 12:58:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 25097508A;
	Tue, 11 Dec 2007 12:58:07 -0500 (EST)
In-Reply-To: <20071211144351.GA15448@artemis.madism.org> (Pierre Habouzit's
	message of "Tue, 11 Dec 2007 15:43:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67894>

Pierre Habouzit <madcoder@debian.org> writes:

> Also make it `cut` friendly using a tab to separate the numbers and n=
ames.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>     On Tue, Dec 11, 2007 at 02:05:08PM +0000, Ingo Molnar wrote:
>     > please switch around the column too so that the commit count co=
mes=20
>     > first, this is way too ugly:
>     >=20
>     >  Junio C Hamano: 4826
>     >  Shawn O. Pearce: 1146
>     >  Linus Torvalds: 950
>     [...]
>
>     Agreed, here is the patch that does that, and a sample output is:
>
>         $ git shortlog -n -s -e HEAD -- builtin-commit.c
>             11	Junio C Hamano <gitster@pobox.com>
>              6	Johannes Schindelin <Johannes.Schindelin@gmx.de>
>              6	Kristian H=C3=B8gsberg <krh@redhat.com>
>              2	Jeff King <peff@peff.net>
>              1	Alex Riesen <raa.lkml@gmail.com>

Thanks.  Looks good.

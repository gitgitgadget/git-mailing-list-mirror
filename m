From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Fri, 14 Dec 2007 08:51:02 +0100
Message-ID: <5A086A2E-16DB-4A3C-92E6-F879189A87FE@wincent.com>
References: <1197552751-53480-2-git-send-email-win@wincent.com> <1197575138-58070-1-git-send-email-win@wincent.com> <20071214045127.GC10169@sigill.intra.peff.net> <7vmysdx3la.fsf@gitster.siamese.dyndns.org> <7vy7bxu3w5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:52:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35LQ-0004wh-Af
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbXLNHwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 02:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbXLNHwE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:52:04 -0500
Received: from wincent.com ([72.3.236.74]:49801 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbXLNHwD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 02:52:03 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBE7p38o012993;
	Fri, 14 Dec 2007 01:51:04 -0600
In-Reply-To: <7vy7bxu3w5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68259>

El 14/12/2007, a las 8:33, Junio C Hamano escribi=F3:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> By the way, there is no reason to make --check and --exit-code =20
>> mutually
>> exclusive either.
>
> Perhaps something like this.  Regardless of the exclusivity issue, I
> think the "diff_result_code()" helper function is a good clean-up.

Totally agreed. It replaces some groups of very-similar lines.

I'll integrate these (and the other suggestions) some time this =20
morning and post a new version of the series that incorporates all the =
=20
feedback and patch suggestions.

Cheers,
Wincent

From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Diff only file at point by default
Date: Mon, 25 Aug 2008 11:30:03 +0200
Message-ID: <87bpzh8msk.fsf@wine.dyndns.org>
References: <87vdxtpjkd.fsf@lysator.liu.se>
	<7v3akvw7gz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 11:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXYmN-0005cJ-RH
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 11:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYHYJx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2008 05:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYHYJx2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 05:53:28 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:42246 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbYHYJx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 05:53:27 -0400
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Aug 2008 05:53:27 EDT
Received: from adsl-62-167-36-68.adslplus.ch ([62.167.36.68] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1KXYOj-00088A-Uy; Mon, 25 Aug 2008 04:30:14 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id A764A1E716B; Mon, 25 Aug 2008 11:30:03 +0200 (CEST)
In-Reply-To: <7v3akvw7gz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 23 Aug 2008 18:02:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Use prefix (C-u) to diff all marked files instead.
>>
>> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
>> ---
>>  contrib/emacs/git.el |   13 +++++++++----
>>  1 files changed, 9 insertions(+), 4 deletions(-)
>>
>> For anyone who has used pcvs (or dsvn) this makes much more sense. T=
he
>
> Looks sensible to me; Alexandre?

Looks OK to me, but I think you should apply the same treatment to all
the other diff functions. Also the documentation string needs a bit mor=
e
work.

--=20
Alexandre Julliard
julliard@winehq.org

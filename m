From: Marti Raudsepp <marti@juffo.org>
Subject: Re: git vs hg commit counts?
Date: Tue, 27 Oct 2009 03:16:31 +0200
Message-ID: <54b33ccd0910261816x3c49d4ccr60a80a88dd4cfac9@mail.gmail.com>
References: <1256602127.29938.8.camel@Joe-Laptop.home> <7v8wexd6zq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
	git <git@vger.kernel.org>, mercurial@selenic.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2agO-0007PC-P0
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 02:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbZJ0BQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 21:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbZJ0BQs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 21:16:48 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:42486 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbZJ0BQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 21:16:48 -0400
Received: by ewy4 with SMTP id 4so4212604ewy.37
        for <multiple recipients>; Mon, 26 Oct 2009 18:16:51 -0700 (PDT)
Received: by 10.216.85.143 with SMTP id u15mr2939409wee.205.1256606211136; 
	Mon, 26 Oct 2009 18:16:51 -0700 (PDT)
In-Reply-To: <7v8wexd6zq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131300>

On Tue, Oct 27, 2009 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> We simplify a merge history by discarding one branch when the merge r=
esult
> matches one of the parents. =C2=A0Does "hg" know how to do that as we=
ll?

57 of the differing changesets are normal merges (probably what Junio e=
xplained)
3 are duplicate changesets in hg, probably also related to that
27 changesets are octopus merge fixups

wrt octopus merges: in git, one merge commit can have an arbitrary
number of parents, but in hg a merge changeset always has 2 parents --
so a octopus merge is represented as multiple distinct changesets.

Marti

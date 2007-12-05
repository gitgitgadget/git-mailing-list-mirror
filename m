From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout --push/--pop
Date: Tue, 04 Dec 2007 22:59:56 -0800
Message-ID: <7vprxl1v9v.fsf@gitster.siamese.dyndns.org>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
	<m34peyur8r.fsf@roke.D-201>
	<7vir3e428i.fsf@gitster.siamese.dyndns.org>
	<200712042204.lB4M4SVB002260@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Salikh Zakirov <salikh@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoF7-0008Bf-Oh
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXLEHAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 02:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXLEHAF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:00:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47402 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbXLEHAE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 02:00:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5EE522F9;
	Wed,  5 Dec 2007 02:00:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C234B9B26E;
	Wed,  5 Dec 2007 02:00:20 -0500 (EST)
In-Reply-To: <200712042204.lB4M4SVB002260@mi1.bluebottle.com> (Nanako
	Shiraishi's message of "Wed, 5 Dec 2007 07:04:06 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67111>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> This introduces a branch-stack mechanism to record branch switching i=
n $GIT_DIR/BRANCH_STACK file.  If you are switching to another branch a=
nd plan to come back to the original branch soon, add '--push' option t=
o record your current branch.
> When you want to come back, 'git checkout --pop' will switch back to =
the branch recorded at the top of the stack, while popping it.
>
> Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=
=E3=81=93 <nanako3@bluebottle.com>

Hmph, is this in response to my "I am not sympathtic to 'I have to
remember'"?

=46unnily enough, I often find myself almost typing pushd/popd when
switching branches, so in that sense "git checkout" to switch branches
does have some similarity to the notion of pushing and popping.

Matthieu, is this something that forgetful people would find useful?

Having said that, I think there are other push/pop people wanted from
you.  Hint, hint...

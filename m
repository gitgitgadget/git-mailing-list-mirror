From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/difftool: use a separate config namespace for
 difftool commands
Date: Tue, 17 Mar 2009 16:42:10 -0700
Message-ID: <7veiwvpvhp.fsf@gitster.siamese.dyndns.org>
References: <1236589956-13486-1-git-send-email-davvid@gmail.com>
 <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com>
 <20090310070122.GB4523@gmail.com>
 <200903172054.46063.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Mar 18 00:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljiwn-0000Xv-Ox
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 00:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZCQXmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 19:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZCQXmT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 19:42:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbZCQXmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 19:42:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BF9FB7E5E;
	Tue, 17 Mar 2009 19:42:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E397A7E5D; Tue,
 17 Mar 2009 19:42:11 -0400 (EDT)
In-Reply-To: <200903172054.46063.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Tue, 17 Mar 2009 20:54:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F93CAFE-134D-11DE-AB7C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113538>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> David Aguilar, 10.03.2009:
>> On  0, Jay Soffian <jaysoffian@gmail.com> wrote:
>> > On Mon, Mar 9, 2009 at 5:12 AM, David Aguilar <davvid@gmail.com> w=
rote:
>> > > =C2=A0contrib/difftool/git-difftool =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A06 +++---
>> >=20
>> > Aside, (for Junio I guess...), what's the reason this command is i=
n
>> > contrib, and by what criteria might it graduate to being installed
>> > with the rest of the git commands?
>> >=20
>> > j.
>>=20
>> My thoughts (also for Junio, I guess..):
>>=20
>> If y'all feel that it can live with the rest of the git
>> commands then that would be great =3D)
>
> I'd like to see it as a general git tool, too.
> Maybe it can even share some common functionality with git-mergetool.

The code was copied and pasted very heavily, and I think (IIRC) the aut=
hor
was a bit too ashamed to have it outside contrib/ before it is properly
refactored or something like that.  Which I happen to agree with, by th=
e
way.

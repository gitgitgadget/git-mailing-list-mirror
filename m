From: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>
Subject: Re: git diff/log --check exitcode and PAGER environment variable
Date: Fri, 08 Aug 2008 12:04:48 +0200
Message-ID: <489C1A40.9000001@sneakemail.com>
References: <489C145B.5090400@sneakemail.com> <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Aug 08 12:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KROr4-0003El-B8
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYHHKEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 06:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYHHKEv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:04:51 -0400
Received: from morch.com ([193.58.255.207]:51915 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbYHHKEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:04:51 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id 59534278E
	for <git@vger.kernel.org>; Fri,  8 Aug 2008 12:07:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91646>

Junio C Hamano gitster-at-pobox.com |Lists| wrote:
>> There is this old thread:
>> "[PATCH 1/5] "diff --check" should affect exit status"
>> http://thread.gmane.org/gmane.comp.version-control.git/68145/focus=3D=
68148
>> which seemed not to reach a conclusion.
>=20
> Conclusion was (1) if you really care about the exit code, do not use
> pager; (2) after 1.6.0 we will swap the child/parent between git and =
pager
> to expose exit code from us, but not before.
>=20
> Or am I mistaken?

Perhaps a more correct statement on my part would have been that I=20
couldn't find the conclusion. :-)

It ended with Junio C Hamano saying:
> Heh, I am about to push out fixed-up results, so it might save both o=
f
> us some time if you looked at it first and then complained on my
> screwups.

I wasn't subscribed to the list back then and couldn't follow beyond=20
that thread in GMane.

Regardless of what happened or not back then, the current documentation=
=20
does not match the current code. Not for git-diff, and certainly not fo=
r=20
git-log.

Or am I mistaken?

I didn't see a reference in that thread to post 1.6.0 changes or to=20
child/parent relationships, but if this is known and planned for=20
post-1.6.0, then cool: I'll get on with my life and let you get on with=
=20
yours!

Peter
--=20
Peter Valdemar M=C3=B8rch
http://www.morch.com

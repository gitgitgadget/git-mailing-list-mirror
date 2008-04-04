From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 04 Apr 2008 13:52:10 -0700
Message-ID: <7vzls9xs05.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <1207340506.10992.28.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 22:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhsuI-0003wk-Cx
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 22:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYDDUwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYDDUwU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 16:52:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYDDUwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2008 16:52:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 718455659;
	Fri,  4 Apr 2008 16:52:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C33345658; Fri,  4 Apr 2008 16:52:13 -0400 (EDT)
In-Reply-To: <1207340506.10992.28.camel@gaara.boston.redhat.com> (Kristian
 =?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 04 Apr 2008 16:21:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78818>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> On Fri, 2008-04-04 at 11:24 -0700, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed
>> with '-' are only in 'pu' while commits prefixed with '+' are
>> in 'next'.
>>=20
>> The topics list the commits in reverse chronological order.
>>=20
>> With a handful topics graduated to "master", we hopefully will have =
the
>> final 1.5.5 soon.
>
> What happened to builtin-clone?

Nothing.

> ... I know I just threw it over the fence,
> but Daniel picked it up and got it a lot closer to working?  Did it f=
all
> through the cracks or is it just 1.5.6 material?

If I recall correctly, "a lot closer to working" happened way after 1.5=
=2E5
merge window closed, so it definitely is not 1.5.5 material.

Judging from the fact that we recently had to deal with the fallouts of=
 C
rewrites that happened during the 1.5.4 timeframe, I would have to say
that any C rewrite of a substantial and important program needs to be
cooked at least for one (or preferably two cycles, especially we are
trying to have shorter cycles) in 'next'.

So at this point, I optimistically say that it has a good chance of bei=
ng
deeply in 'next' and all the active git people would hopefully be using
it, by the time 1.5.6 (or perhaps that is named 1.6.0, depending on wha=
t
else we will do) ships, but I cannot say much more than that.  It very
much depends on how hard the code has been scrutinized already at this
point; I haven't personally looked at it in any serious depth yet.

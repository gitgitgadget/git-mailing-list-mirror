From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] user-manual: add global config section
Date: Fri, 01 May 2009 17:16:18 -0700
Message-ID: <7vfxfotl4d.fsf@gitster.siamese.dyndns.org>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
 <7v7i1zv3cg.fsf@gitster.siamese.dyndns.org>
 <94a0d4530905010137h772b53f1q8af0d30400a05043@mail.gmail.com>
 <7v3abowk6v.fsf@gitster.siamese.dyndns.org>
 <94a0d4530905011551r635a4ebfrba86707419e13cc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 02:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M02uV-0006sb-Gw
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 02:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbZEBAQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 20:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbZEBAQ1
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 20:16:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZEBAQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 20:16:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0773AF2BF;
	Fri,  1 May 2009 20:16:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4E35AF2BE; Fri,
  1 May 2009 20:16:21 -0400 (EDT)
In-Reply-To: <94a0d4530905011551r635a4ebfrba86707419e13cc4@mail.gmail.com>
 (Felipe Contreras's message of "Sat, 2 May 2009 01:51:37 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78F8EFDE-36AE-11DE-843F-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118110>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>> A good sequence would be:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0To start working on a tarball extract (or=
 your uncontrolled
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0project) with git, first do:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git init
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Whoa. =C2=A0That was fast. =C2=A0Did it d=
o anything? =C2=A0Yes, it created a
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0subdirectory .git that is going to store =
your history and other
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0control information. =C2=A0Right now you =
do not have any history (nor
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the current state for that matter) record=
ed in it, but it already
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0has some control information. =C2=A0One o=
f the more important one is
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the per-repository configuration file. =C2=
=A0Take a look:
> ...
> Most people don't start with 'git init' they start with 'git clone'

That does not just not change the issue but even strengthens my point.
After clone, you have a working per-repository .git/config file that is=
 a
good demonstration of how easy and simple the syntax is.  You of course
need to adjust the prose to guide the user to the configuration file if
you use clone instead of init, but that goes without saying.


By the way, I think you lacked 1/4 in your last round and this time it =
is
missing too.

[  17: Felipe Contreras  ] [PATCH v2 0/4] user-manual: general impro
[  74: Felipe Contreras  ] [PATCH v2 2/4] user-manual: use 'fast-for
 [  51: Felipe Contreras  ] [PATCH v2 3/4] user-manual: add global c
  [  38: Felipe Contreras  ] [PATCH v2 4/4] user-manual: simplify th

The description in 0/4 makes it sound like 1/4 is a general clean-up
improvement, and so is 2/4.  Can we apply these two first (and we
obviously need to find that missing 1/4 --- is there some git-send-emai=
l
bug hiding or something)?

The two patches 3/4 and 4/4 are not "general" improvement; it is to
advocate the use of "git config" more instead of showing the file in th=
e
editor, and while you obviously think it is an improvement, I do not th=
ink
there is a "general" consensus that it is an improvement.

More importantly, I do not think that is integral part of the "general
clean-up", and by making it a separate topic, we can shrink the size of
the patches in flight.

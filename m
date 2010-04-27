From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Tue, 27 Apr 2010 08:35:51 +0200
Message-ID: <874oixe720.fsf@krank.kagedal.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
	<36ca99e91003112340u6256ef4dwb40e308c9a5e3a46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 08:36:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6eOy-0002Kj-SW
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 08:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab0D0GgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 02:36:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:48481 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab0D0GgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 02:36:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O6eOl-0002EB-Ib
	for git@vger.kernel.org; Tue, 27 Apr 2010 08:35:59 +0200
Received: from 62.20.90.206 ([62.20.90.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 08:35:59 +0200
Received: from davidk by 62.20.90.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 08:35:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 62.20.90.206
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:x58dMj8wn/deH7ZfL5s1tYwh0jM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145879>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Fri, Mar 12, 2010 at 07:53, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Erick Mattos <erick.mattos@gmail.com> writes:
>>> + =C2=A0 =C2=A0 test "alpha" =3D "$(git branch | sed -n "/*/s/\* //=
p")" &&
>>
>> Don't read from "git branch" in scripts; use symbolic-ref on HEAD.
>
> I think what he wants is:
>
>         git rev-parse --abbrev-ref HEAD

Aha! That's a command I've been looking for a number of times. Thanks a
lot for the tip.

--=20
David K=C3=A5gedal

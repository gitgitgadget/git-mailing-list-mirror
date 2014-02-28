From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 18:33:03 +0100
Message-ID: <87eh2n16sw.fsf@fencepost.gnu.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org> <858usvz5nj.fsf@stephe-leake.org>
	<87txbj1fnw.fsf@fencepost.gnu.org> <85zjlb1740.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:53:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRcy-0001Zy-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbaB1Rxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 12:53:36 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55311 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbaB1Rxg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 12:53:36 -0500
Received: from localhost ([127.0.0.1]:54350 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WJRcs-0001g9-Ka; Fri, 28 Feb 2014 12:53:34 -0500
Received: by lola (Postfix, from userid 1000)
	id C1260E0BFA; Fri, 28 Feb 2014 18:33:03 +0100 (CET)
In-Reply-To: <85zjlb1740.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 11:26:23 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242997>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>>
>>> David Kastrup <dak@gnu.org> writes:
>>>
>>>> "do the right thing" commands also tend to do the wrong thing
>>>> occasionally with potentially disastrous results when they are use=
d
>>>> in scripts where the followup actions rely on the actual result.
>>>
>>> That is bad, and should not be allowed. On the other hand, I have y=
et
>>> to see an actual use case of bad behavior in this discussion.
>>
>> Huh.
>>
>> <http://permalink.gmane.org/gmane.comp.version-control.git/242744>
>
> That's about backward incompatibility, which is bad, but not what I w=
as
> talking about above.

No, it isn't.  I quote:

    I sometimes run "git reset" during a merge to only reset the index
    and then examine the changes introduced by the merge. With your
    changes, someone doing so would abort the merge and discard the
    merge resolution.  I very rarely do this, but even rarely, I
    wouldn't like Git to start droping data silently for me ;-).

You should not make statements like "I have yet to see an actual use
case of bad behavior in this discussion" when you actually mean "I=A0ha=
ve
not yet seen anything I=A0would be interested in doing myself".

--=20
David Kastrup

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/4] git-am foreign patch support: StGIT support
Date: Wed, 27 May 2009 13:50:35 -0700
Message-ID: <7vmy8yi82s.fsf@alter.siamese.dyndns.org>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
	<7v7i03j9mb.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0905270129j375ac104yb9ca8601312ddbde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Q5N-0006AB-Qy
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbZE0Uuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 16:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZE0Uuf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:50:35 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34095 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbZE0Uue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 16:50:34 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090527205035.NQCD25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Wed, 27 May 2009 16:50:35 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id wkqb1b0084aMwMQ04kqbDd; Wed, 27 May 2009 16:50:35 -0400
X-Authority-Analysis: v=1.0 c=1 a=u217S5DB6-EA:10 a=VLcXo6BCFe0A:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=jl6dxy4fduqIGx2U7ogA:9
 a=6HZOd3cdZdOR2hkxXYCFkyGSFtsA:4 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0905270129j375ac104yb9ca8601312ddbde@mail.gmail.com> (Giuseppe Bilotta's message of "Wed\, 27 May 2009 10\:29\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120104>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Wed, May 27, 2009 at 9:19 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # set the patch format =
appropriately
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 patch_format=3Dstgit
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # now handle the actual=
 StGIT patches
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 split_patches "$@"
>>
>> Can an stgit patch file (or the leading pathname for that matter) ha=
ve IFS
>> character in its name?
>
> StGIT sanitizes filenames in a way similar to what format-patch does.

Good ;-)

>> Since we rely on Perl but not awk in core-ish part of the scripted
>> Porcelains, it might be a good idea to write this in Perl as well.
>
> By 'as well' you mean in case awk is missing, and have both, or by
> only keeping a perl version?

"As well" I meant "Using Perl instead of awk, just like other scripted
Porcelains."

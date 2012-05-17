From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4] git-svn: clarify the referent of dcommit's optional argument
Date: Thu, 17 May 2012 11:46:56 +1000
Message-ID: <CAH3AnrpCJZt0acr7f5C5kwCF+KxgzD3dbeT+g7Ko5uCMxNqU0Q@mail.gmail.com>
References: <1337200956-9260-1-git-send-email-jon.seymour@gmail.com>
	<CAH3AnrqQDfx7s1fXBgKJmFtMA33CW9qx2tWSoenqSR0pVc63WQ@mail.gmail.com>
	<7vzk97bv2j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, normalperson@yhbt.net, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 17 03:47:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUpoY-0006QB-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 03:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760798Ab2EQBq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 21:46:59 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50515 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab2EQBq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 21:46:58 -0400
Received: by wibhn6 with SMTP id hn6so1336816wib.1
        for <git@vger.kernel.org>; Wed, 16 May 2012 18:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JDeClztkQIqjoon4/qehGRcxbkPjmqesP5DPIoscqJg=;
        b=tKMFC5n/VnTuD6hWdcemGuW9bjWxx/4VuDjgLzhJNT5n85VhSy65WXhJjbLOIu1DtN
         sIfjPMr43yUDK+Y4b+3t6QH1/5i7FLPTwr9zw+7N88ZS2LTEikZ50Q2x1ZL6Fwm8rENY
         4mI6t/UgYVApk4HtQ6Rgy8Ctcu0pE55AhF69o85702CRWvJWbdmrAeDJ1vS0QUXDh2OE
         iAeXCgIrijL9x5yn6Gdjgi8m10al23QZejeY/cjZjSHHYkVG/1umAFABwE5LgTHT/7Jc
         VP7D0EGM5fXKizLcVl66e3i6X/FZ4xBBGs2pWp6PvD9ZGVlzXMZMVHi63G/qN8FKqdno
         poIg==
Received: by 10.181.11.137 with SMTP id ei9mr13241765wid.21.1337219216919;
 Wed, 16 May 2012 18:46:56 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Wed, 16 May 2012 18:46:56 -0700 (PDT)
In-Reply-To: <7vzk97bv2j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197908>

On Thu, May 17, 2012 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>>> +Originally, 'git svn' recommended that developers pulled or merged=
 from
>>> +the 'git svn' branch. =C2=A0This was because the author favored `g=
it svn set-tree B`
>>> +to commit a single head rather than the `git svn set-tree A..B` no=
tation to
>>> +commit multiple commits. Use of 'git pull' or 'git merge' with `gi=
t svn set-tree A...B`
>>
>> A...B -> A..B
>>
>> Will fix in next iteration, assuming Junio and Eric are otherwise
>> happy with the update.
>
> I don't have an opinion on the latter half of the patch that is prima=
rily
> about the rationale given by "the author", i.e. Eric ;-), but the
> description of dcommit subcommand itself certainly looks simpler and =
more
> readble to me.
>
> Thanks.
>
>

Ok, I'll fix the ... issue mentioned above and (also some trailing
whitespace) once Eric has given his feedback or acknowledgement.

jon.

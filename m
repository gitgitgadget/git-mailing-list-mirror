From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 6 Aug 2010 12:33:10 +0000
Message-ID: <AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
	<7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 14:33:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhM71-0007eV-E7
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 14:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934716Ab0HFMdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 08:33:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34613 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934706Ab0HFMdQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 08:33:16 -0400
Received: by iwn33 with SMTP id 33so1278330iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KtHjaR9khQWhw+aElmvihV1mdwtDsDHO/HDlavDPEYc=;
        b=GGbltplQdVSqSsmXm5MMV0TYM59+NsXLNsYpQaARD9nQhkWv8sAcclw1F2HhhVM9fL
         CYSNGV7BM1r9fr/gCqKeXZoJBgtY98GTDuUTozgbcjJF5k6fwkLvIk+EKJs9dion8ABT
         0Qt6pEkI5+UXA6exssC8x0JPzKndob7LBK/dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IRdM6p0Kbxk600Rz38B7igHIgNzjUvTK8vHrUOLux0ZyCnVKEYIpTCiRZM4Qh5Szu4
         XlvVesrS57ZjD59m7UAm+0T9NbvM5EOFT0x3Z+hkI77oXwXKvunu0yXUtgnZnBekRHpZ
         eZQibOuaiY0S1kNnIF8Y++Esk5t0XSRQm4ArI=
Received: by 10.231.185.142 with SMTP id co14mr13579785ibb.97.1281097990867; 
	Fri, 06 Aug 2010 05:33:10 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 05:33:10 -0700 (PDT)
In-Reply-To: <7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152777>

On Thu, Aug 5, 2010 at 22:18, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Aug 4, 2010 at 22:24, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>> Since we're asking about the status of series...
>>
>>> * tr/ab-i18n-fix (2010-07-25) 1 commit
>>> =C2=A0- tests: locate i18n lib&data correctly under --valgrind
>>> =C2=A0(this branch uses ab/i18n.)
>>
>>> * ab/i18n (2010-07-19) 2 commits
>>> =C2=A0- tests: rename test to work around GNU gettext bug
>>> =C2=A0- Add infrastructure for translating Git with gettext
>>> =C2=A0(this branch is used by tr/ab-i18n-fix.)
>>
>> Do you have any plans for when to merge the i18n series?
>
> When people see the benefit of doing so. =C2=A0I currently do not see=
 much need
> for it myself but I am a minority ;-).

That's news to me. I'd assumed that it was mostly on track, i.e. that
it would get merged down after cooking for a while in pu.

However, if it's a matter of gathering popular support maybe I should
change my strategy a bit.

Perhaps it would help if I sent the entire series as it is in pu now
to the list along with a cover letter explaining the main implications
of merging it?

All the RFCs so far have either focused on discussing the idea without
the implementation, or small parts of the implementation that needed
to be improved.

>> It's been cooking for a while now, and it'll need a lot of follow-up
>> work (gettextizing) once it gets merged.
>
> Yeah, and s/once/before/ probably.

What sort of work do you think is needed before it's merged? It seems
to Just Work everywhere I and others have tested it (sans some minor
patches like working around old gettext bugs).

The follow-up work I was referring to was the project we'll need to
undertake once it's merged to convert "foo" to _("foo") as
appropriate.

What sort of work do you think might be needed before it's merged?

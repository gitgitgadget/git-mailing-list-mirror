From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Cooking of the ab/i18n series
Date: Thu, 5 Aug 2010 21:09:52 +0000
Message-ID: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:10:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7hp-0000l5-R3
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934093Ab0HEVJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 17:09:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33778 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534Ab0HEVJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 17:09:55 -0400
Received: by iwn33 with SMTP id 33so476448iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=GNhAt6omapaaDMg08N+3dkDADgIEXS+cErEIfP4A8gg=;
        b=dSE9D5sLkbvMZCqK0gJcPzVDK2KFS078ZZnM2C2xrKDwFI0T5Zk5FaZIRoxeFPkNVh
         O/d6MMCsqgFVr4N9qQ1BlkL9ngD31MlysYi02juN3tSKtc7V7UTnUdFr1fdwPszTYH3a
         4WVcOSMfdNKl+8VQ1Q7bXfuP+0NjaWenBqQ4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=MtqT3+MPdLXcZN9uHSume2/LR2qarHdBytqgSXdXaldOMQW4bjELlu+vbjQJkVkEJr
         3LOU3hhCpdUqxK8cBLueUze4ypbx28H5vvqRXWqEG4QqZjMxbHVWbZfzfUmAw2vr23zN
         PjNwS/aTI0skAUeeqILzaHtHZ2lS5gXk0mz0g=
Received: by 10.231.39.201 with SMTP id h9mr12070959ibe.118.1281042592950; 
	Thu, 05 Aug 2010 14:09:52 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 5 Aug 2010 14:09:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152718>

On Wed, Aug 4, 2010 at 22:24, Junio C Hamano <gitster@pobox.com> wrote:

Since we're asking about the status of series...

> * tr/ab-i18n-fix (2010-07-25) 1 commit
> =C2=A0- tests: locate i18n lib&data correctly under --valgrind
> =C2=A0(this branch uses ab/i18n.)

> * ab/i18n (2010-07-19) 2 commits
> =C2=A0- tests: rename test to work around GNU gettext bug
> =C2=A0- Add infrastructure for translating Git with gettext
> =C2=A0(this branch is used by tr/ab-i18n-fix.)

Do you have any plans for when to merge the i18n series?

It's been cooking for a while now, and it'll need a lot of follow-up
work (gettextizing) once it gets merged.

I don't have infinite time to do that, so sooner rather than later
would be better if we're going to e.g. have a fully localized Git 1.8.

I haven't been sending these follow up patches due to the reasons I
already cited. They're pretty much guaranteed to conflict with other
things in-flight.

If you're not comfortable with merging it soon for whatever reason
then perhaps I could submit something to add a no-op N_() macro to Git
in the interim. Then we could just do s/N_/_/ on the source tree once
the real series gets merged.

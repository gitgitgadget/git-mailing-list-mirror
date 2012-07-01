From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Sun, 1 Jul 2012 12:34:33 +0200
Message-ID: <CAD77+gSu-RxtcyXqpF6+VanLh==_BJymTAnY2M_EiMz=b63F6g@mail.gmail.com>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de>
 <7vzk7p8z38.fsf@alter.siamese.dyndns.org> <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com>
 <7v8vf551iu.fsf@alter.siamese.dyndns.org> <7vvci93k6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 12:35:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlHUb-00056r-9p
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jul 2012 12:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab2GAKez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jul 2012 06:34:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53781 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab2GAKey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2012 06:34:54 -0400
Received: by obbuo13 with SMTP id uo13so6461644obb.19
        for <git@vger.kernel.org>; Sun, 01 Jul 2012 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BN4YqfSKON3Q6/5AMddLJz6hVlA0JSbATMxe4WWnYuk=;
        b=HoagMnJsHVmQOgQxDFnnXeii5jc7lpOlKwtupTxf+yX8GC43LGFK04Aug6+p0EAPK0
         5ycs9Dah5kVZENS2t5IE+UENVb7WRwgZkeL1mVlF2ovXZPK3Fl3aWJO5mT4gU+JvMlLm
         nbbyxzSxdbaWwMUpa02/uGl2w90dL9rf5l0eW3JpSCA/5jo1AdAwcZwFJJuN0LaUTIJm
         XLJ6MbLtf3ZIVC0Ta/BjAkOIbYoZhVaHzAPvfVw3Tuo9N7aU13BhwEd3gfFO9QyqdgFR
         b1RVImnVedAnQYTIsIBgPb+QmdfPgJBeXZ/Zbgbl1g6DWDwIvj6oMUqzFgrkOPJ8cMl1
         4n9Q==
Received: by 10.50.163.5 with SMTP id ye5mr2982527igb.37.1341138893790; Sun,
 01 Jul 2012 03:34:53 -0700 (PDT)
Received: by 10.50.135.97 with HTTP; Sun, 1 Jul 2012 03:34:33 -0700 (PDT)
In-Reply-To: <7vvci93k6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200838>

First of all, thanks for your detailed analysis; it cleared things up
for me quite a bit.

I am not sure if this would work in all cases, but let's assume there
is a new GIT_WORK_ROOT which will always point to the top level of a
given repository (it would stay the same for submodules, as well).

As for storage of .git, GIT_DIR_ROOT would always point to a directory
where git data is stored and GIT_DIR_NAME to the relative path within
GIT_DIR_ROOT. Admittedly, this may be rather specific to vcsh, but I
don't see any other (reliable) option to support submodules.


Thanks,
Richard

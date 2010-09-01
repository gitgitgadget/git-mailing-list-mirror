From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Thu, 2 Sep 2010 09:39:39 +1000
Message-ID: <AANLkTik7eBGJrQ3HEYjesvR9y1PpwUphVvpBmzVCiu6p@mail.gmail.com>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
	<AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 01:39:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqwuB-0002oX-8t
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 01:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab0IAXjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 19:39:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58369 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0IAXjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 19:39:41 -0400
Received: by wwj40 with SMTP id 40so680676wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 16:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SuMHZ8I5pTnEILuVNt6Gjnh3cypsLJ2kUhN7Xi6bkfc=;
        b=v4reZ6OloCMka74Pr106ea6o5/wiYaWtYngU9K6zOZ2BOO1CpOQcKhcwfPNjo4hXRg
         DyGJfEr0uCS8vxRzv6u+QNAjHqtR5PpExkwMwlmNV2wBnYbkEMaJXzGegDLpx6NOOedW
         d5wr7MgMUykVmHraPJlYMTGe+y4pp3NhC2imA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RVKBLI1SQE3mc4yZdqPAryGXa0/Fd4Z1WQhvuUJgUnlkPPQc+dHHJY3tCR3AOu72Zt
         emwqYfOae78tGk1ItLB+8rMFdT2zCVcJILAHQBwc4rcLxUfVh+1WHTvoISc+YQJ70UUx
         rpu4VvSVsBxRak2f5PKdxOLoOSM/s3eJw8JyE=
Received: by 10.227.138.134 with SMTP id a6mr9024317wbu.68.1283384379566; Wed,
 01 Sep 2010 16:39:39 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 1 Sep 2010 16:39:39 -0700 (PDT)
In-Reply-To: <AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155098>

On Thu, Sep 2, 2010 at 6:54 AM, Elijah Newren <newren@gmail.com> wrote:
>> * en/object-list-with-pathspec (2010-08-26) 2 commits
>> =C2=A0- Make rev-list --objects work together with pathspecs
>> =C2=A0- Add testcases showing how pathspecs are ignored with rev-lis=
t --objects
>>
>> Heard that this is still broken?
>
> Are you possibly remembering v1 of the series, which mis-used the
> tree_entry_interesting() API, and was fixed by v2 including extra
> testcases? =C2=A0You merged the latter into pu, so there's no remaini=
ng
> issue I know of.
>
> However, if I've missed some email or other report about any other
> breakage, let me know and I'll take a look.

I haven't really used it recently since I'm redoing my series to
support multiple subtree. Will let you know soon if it works (v2
worked last time before the rework).

While at there, how about adding tree exclusion mechanism that you
mentioned in sparse clone? That would be really cool.
--=20
Duy

From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sun, 14 Mar 2010 18:57:44 -0300
Message-ID: <55bacdd31003141457x74222a79lc060112d20dbbe4c@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org> <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com> 
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org> <m38w9wlg7i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 22:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqvp7-0001yo-31
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 22:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934179Ab0CNV6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 17:58:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59085 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934132Ab0CNV6G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 17:58:06 -0400
Received: by gyg8 with SMTP id 8so1115134gyg.19
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iJFbMqsVmGkYT8vU1vY5F9/P2VKXqJPwXo/uMXhmBBo=;
        b=oQVQN4K9sKVA/qVf87Fax3lEk7l0I0HEmw1ITrCk8IGQAWHt3s1t8X3PkyikV8KdBY
         kUlRF+Hcc4Ua3TjJjjS2SlCGacWZPHxPINmKF74cAv4K75qfa5f9SdqyO1afdYJE5YaR
         UmMDq/Z8mogagYkzKKChEDC5lbu7in7c3OwnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LdooY/u7Q9OdyZJSNOO+WOAoehIU2K3eTqFqixjBj+r1OepFLrHKmJj3uQbhMvCpvd
         668XYK+sVEV2XLeXu2AAy5RLn7jeGd5kk7R1e5kUMK/vrbLIdPfxPIXAGA0w+/posxbo
         BXnh6msSDT50r7ne3KT7qBTysbPN9COtyuQJk=
Received: by 10.101.155.38 with SMTP id h38mr2975448ano.131.1268603884262; 
	Sun, 14 Mar 2010 14:58:04 -0700 (PDT)
In-Reply-To: <m38w9wlg7i.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142158>

Hi,

You got it right.  HTML and man branches are really very good examples.

Regards

2010/3/13 Jakub Narebski <jnareb@gmail.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C2=A0 =C2=A0 Side note: The other two "disjoint" merges we have are=
 also this kind
>> =C2=A0 =C2=A0 of "no common paths" merge. =C2=A0Nobody who was invol=
ved in the branches
>> =C2=A0 =C2=A0 that resulted in them prepared his branch with --orpha=
n, by the way.
>> =C2=A0 =C2=A0 They started out in independent repositories, because =
they were by
>> =C2=A0 =C2=A0 definition independent projects and these were "cross =
project merges",
>> =C2=A0 =C2=A0 as Linus put it.
>
> Note that beside "disjoint" merges ("cross project merges"), of gitk,
> git-gui, gitweb and (very early in git history) git mail tools, there
> are also three "disjoint"/"unparented" branches: 'html', 'man' and
> 'todo'.
>
> While 'todo' is totally unrelated, and if instead of starting in
> separate repository it would be created using proposed feature, it
> would be created with "no common paths" case.
>
> BUT in the case of 'html' and 'man' branches I could see why current
> implementation of _removing index and not removing files_ might be
> advantageous. =C2=A0Remove index, create HTML and manpage version of
> documentation, and add HTML (in 'html' branch) or manpages (in 'man'
> branch)... probably shifting root, so it is not all in single
> Documentation directory.
>
> Just my 2 eurocents.
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Tue, 21 Jul 2015 12:42:40 -0700
Message-ID: <xmqq615duwjz.fsf@gitster.dls.corp.google.com>
References: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
	<55AE95EE.1080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tony Finch <dot@dotat.at>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdRA-0002OK-43
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbbGUTmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 15:42:43 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35897 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbGUTmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:42:42 -0400
Received: by pachj5 with SMTP id hj5so125311358pac.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=o1tlF1HKWeQXjU98nngxMQCf3DsnS4S6dx5OByBH/vA=;
        b=ttDVCVS+jcYSaThgJabAKoD3Pi29mXCOS68Aq3+HWSmSCvVscx/9XdH54fyCX69kIZ
         4XzWdHrpHVCwtYAR+26nW0UZHFagjnC8gr6tvPzOxyApjR10unJJTCuZOZyEyRPi1qMn
         tiQWfXVsKUdv2L9bSj4NF/sQYkuCg6fGgKyu5C4+KXBUhgwtxp4gWJfESLrO5N0tnl7N
         CYQzJU9a3UDQN8i7yYbPEZGmEVbgAoHdBZuFvKreYcot9BjGJIUbdVl4N5pKgcGryZnX
         apwfubJWfN28ALwZBtImT/B+UdZW2NwD6e+k1ay0kGdD25zjFc2MNAc70VO/6iEen/6e
         y1Vw==
X-Received: by 10.70.118.5 with SMTP id ki5mr76927606pdb.6.1437507762213;
        Tue, 21 Jul 2015 12:42:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id s1sm28965793pda.54.2015.07.21.12.42.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 12:42:41 -0700 (PDT)
In-Reply-To: <55AE95EE.1080500@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Tue,
	21 Jul 2015 20:56:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274405>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> * tf/gitweb-project-listing (2015-03-19) 5 commits
>>  - gitweb: make category headings into links when they are directori=
es
>>  - gitweb: optionally set project category from its pathname
>>  - gitweb: add a link under the search box to clear a project filter
>>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filte=
r
>>  - gitweb: fix typo in man page
>>=20
>>  Update gitweb to make it more pleasant to deal with a hierarchical
>>  forest of repositories.
>>=20
>>  Any comments from those who use or have their own code in Gitweb?
>
> Sent a reply to wrong (old) thread, sorry.
>
> tl;dr - first can be applied unconditionally, others have slight
> issues. Cgit implements something like this, though with limit
> (only first directory path), and different UI - it looks useful
> on https://git.kernel.org/cgit/

I'll merge the first one down, and discard the rest without
prejudice, then.

Thanks.

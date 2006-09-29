From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/5] fetch & co: misc output cleanup
Date: Fri, 29 Sep 2006 11:54:19 -0700
Message-ID: <451D6BDB.50900@gmail.com>
References: <87r6xu1rci.fsf@gmail.com>
Reply-To: git <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 29 20:54:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTNVK-0006Ls-Ot
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWI2SyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 14:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWI2SyX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:54:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:47165 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161443AbWI2SyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 14:54:22 -0400
Received: by wr-out-0506.google.com with SMTP id i32so333336wra
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 11:54:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RykxTz/yoQ6PaWFi/kpHk9g/+bwUMKdBMROtVF/33KW9Oube56DUfM8NtBPfKCSVHK5ucwVJvLxFAHzBHKc7CEatwfbMWMYa4O2hyF0FsMFI16PHd/9l2VCUZUKVDeqrsfgHcOXUu6GzpPeXCdGkG88SsNMHp0Q+SQfcoAk2ZYg=
Received: by 10.90.25.3 with SMTP id 3mr827415agy;
        Fri, 29 Sep 2006 11:54:21 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.gmail.com with ESMTP id 25sm3698928wra.2006.09.29.11.54.20;
        Fri, 29 Sep 2006 11:54:21 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87r6xu1rci.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28124>

Santi B=E9jar wrote:
> this patchset includes:
>=20
>       fetch: Reset remote refs list each time fetch_main is called
>       fetch & co: Use "hash1..hash2" instead of "from hash1 to hash2"
>       fetch & co: Use short sha1 in the output
>       fetch: Add output for the not fast forward case
>       fetch: Clean output

Please do not make short ID output the default. That is, unless you can=
=20
somehow guarantee that the short ID reported today will _always_ be=20
unambiguous even with future additions to the repository.

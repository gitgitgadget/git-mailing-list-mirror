From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/15] t3200 (branch): fix && chaining
Date: Thu, 8 Dec 2011 10:17:24 +0530
Message-ID: <CALkWK0nDHa-Kc9_0kCw-LCoykudvZOR-9JNASyLj_=uvn-eJ9A@mail.gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com> <1323286611-4806-9-git-send-email-artagnon@gmail.com>
 <20111207215509.GC2911@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 05:47:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYVtf-0004mk-93
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 05:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab1LHErq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 23:47:46 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:44990 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1LHErq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 23:47:46 -0500
Received: by qadb15 with SMTP id b15so1368501qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=96J0KIp7OjOzP7Rx+7+pSCGst/Guy6JjVz+5UpjhlEk=;
        b=IkyA9NVqp4njHba8G+9CdcK+Yg6OyjNPYQY74wfV43aNR8SuLBtOEx7g70zdKR6v2k
         snnd0yTW7LSYWKiNkY5UYxKmacVlhUDADb/yVWdSHr1wrnO7+q1Ya7+PPKXrN3VijG/A
         elJWXXGEMClMy1BaLBtttSJ84ax27AzULrPT0=
Received: by 10.224.189.78 with SMTP id dd14mr1336540qab.31.1323319665216;
 Wed, 07 Dec 2011 20:47:45 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Wed, 7 Dec 2011 20:47:24 -0800 (PST)
In-Reply-To: <20111207215509.GC2911@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186532>

Hi Jonathan,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -22,7 +22,7 @@ test_expect_success \
>>
>> =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0'git branch --help should not have created a bog=
us branch' '
>> - =C2=A0 =C2=A0 git branch --help </dev/null >/dev/null 2>/dev/null;
>> + =C2=A0 =C2=A0 git branch --help </dev/null >/dev/null 2>/dev/null =
&&
>> =C2=A0 =C2=A0 =C2=A0 test_path_is_missing .git/refs/heads/--help
>
> Won't this break when running tests for the first time, before the gi=
t
> manpages are installed?

Used test_might_fail to guard it this time.  Thanks.

-- Ram

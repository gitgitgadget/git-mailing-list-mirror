From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Re: error: refs/tags/2.0.9 does not point to a valid object!
Date: Tue, 19 Oct 2010 13:15:12 +0200
Message-ID: <AANLkTi=KvEPwmnJ_sexLz3j5n4a+ATPJTnXiAK2T8MPi@mail.gmail.com>
References: <AANLkTi=JgVhkNVu70nW7_vbqWUsS=mnJGQDVBtm-dxJD@mail.gmail.com> <23120755.523391.1287433903205.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 13:15:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8AAS-0007VV-K0
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 13:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758304Ab0JSLPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 07:15:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33457 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152Ab0JSLPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 07:15:36 -0400
Received: by iwn7 with SMTP id 7so784255iwn.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OrJGL611s2PateYxKbRdeijCtTWMg+2zHI7iQQVDmoE=;
        b=pNCKTB9XYt4JWZmD1WuM7lnGK8LzaBtdbYEZnZg3iD3qzyKukzPGLUxEFxvBuEpbAR
         1vZhvHwnw1q8pcCL9sQMzBcwu8U+DlCVq7MAR7n9dIUJUxybhdPOPDST932eS70uyV6C
         nUGTPbIssnRQS/bMHayXQ8k+L35EkauthT9Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v49h9oTAppkw6U/Qwpa5QZizZoOogctUXGglF17gRwsGeijKZAFYr8pStjnWiQfO9W
         6oywd5k3z84ioS14lq/DrfIVxj7bORCKkwWl2w/fGtUee5JhsDZmTdYFZR0z4NvWIBRO
         oZqF11cmp7b849F3OV72cTgec1BIDNAuz0lSo=
Received: by 10.231.12.136 with SMTP id x8mr4389143ibx.55.1287486932991; Tue,
 19 Oct 2010 04:15:32 -0700 (PDT)
Received: by 10.231.17.141 with HTTP; Tue, 19 Oct 2010 04:15:12 -0700 (PDT)
In-Reply-To: <23120755.523391.1287433903205.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159321>

On Mon, Oct 18, 2010 at 10:31 PM, Stephen Bash <bash@genarts.com> wrote=
:
>
>
> ----- Original Message -----
>> From: "Mathieu Malaterre" <mathieu.malaterre@gmail.com>
>> To: git@vger.kernel.org
>> Sent: Monday, October 18, 2010 3:23:57 PM
>> Subject: error: refs/tags/2.0.9 does not point to a valid object!
>>
>> I am trying to convert a SVN repository to GIT.
>>
>> The filter ran for a couple of hours. But after the conversion I get
>> the following:
>>
>> Initialized empty Git repository in /tmp/bla/.git/
>> remote: Counting objects: 59368, done.
>> remote: Compressing objects: 100% (25408/25408), done.
>> remote: Total 59368 (delta 43461), reused 44204 (delta 33809)
>> Receiving objects: 100% (59368/59368), 14.40 MiB | 14.27 MiB/s, done=
=2E
>> Resolving deltas: 100% (43461/43461), done.
>> error: refs/tags/2.0.9 does not point to a valid object!
>> error: refs/tags/2.0.8 does not point to a valid object!
>> error: refs/tags/2.0.7 does not point to a valid object!
>> error: refs/tags/2.0.6 does not point to a valid object!
>> error: refs/tags/2.0.5 does not point to a valid object!
>> error: refs/tags/2.0.4 does not point to a valid object!
>> error: refs/tags/2.0.16 does not point to a valid object!
>> error: refs/tags/2.0.15 does not point to a valid object!
>> error: refs/tags/2.0.14 does not point to a valid object!
>> error: refs/tags/2.0.13 does not point to a valid object!
>> error: refs/tags/2.0.12 does not point to a valid object!
>> error: refs/tags/2.0.11 does not point to a valid object!
>> error: refs/tags/2.0.10 does not point to a valid object!
>>
>> Could someone please let me know what I am doing wrong in my script
>> in filter-branch.
>
> Yep, I ran into the exact same problem. =A0Short answer, move/remove =
the refs/original directory before cloning, and the issue should go awa=
y.
>
> http://kerneltrap.org/mailarchive/git/2010/8/20/37441
>
> There was also a proposed test case:
>
> http://kerneltrap.org/mailarchive/git/2010/9/7/39119

This was indeed the problem. Just a simple rm -rf .git/refs/original/*
and original issue is gone.

Thank you so much !
--=20
Mathieu

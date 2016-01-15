From: pedro rijo <pedrorijo91@gmail.com>
Subject: Re: Find main branch
Date: Fri, 15 Jan 2016 10:49:02 +0000
Message-ID: <CAPMsMoCHYEqSoR5UKBVK7yqSK=itRXxDDV0Kp7xwoykYRpzfWg@mail.gmail.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
 <20160114213113.c700484c7e3acddc467d0e75@domain007.com> <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
 <CAGyf7-H2jSW0vJZ7ng1OcN7X5tvs+sEuGUH4yMSpJ_-wwUcoTQ@mail.gmail.com> <20160114211335.GB10825@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 11:49:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK1wz-0001VH-TH
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 11:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbcAOKtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 05:49:46 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34029 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbcAOKto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 05:49:44 -0500
Received: by mail-lf0-f49.google.com with SMTP id 17so78029776lfz.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 02:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IDW734DdYb8vbjIJQPA7kIN2UvXJYI63RFsZ41ejy9s=;
        b=OuYwzbtlqiCr2AOCfrJ02rEbjYw1qqqDYHSupDcE947LbZgWZQNic9pDzX+OppAsfS
         R4zvS0EfUWsRCOevartwmJ9xmBiXNj8NQ2MpbM1OKbdn9Q5L+LbBes5U72TqjR7UYPsG
         Rkfb87sUyRO1cl/g3N1etldWcw8683msuKcEIux/U19VgRyZa1vTLDpp2Zz/QhrpkUAb
         mODncwZtMhIILcmtDbGchJn+K84U0KfWOcaSMZFHDHszk/FmxY8FwAXxofYGsmeAQ2PZ
         toy4Cx+YrHUiwGTDBXVgZAHATDnI2EVeVqIKOz+bl2uyfVfcljZVDh8Y3tyQb8unik+d
         3XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IDW734DdYb8vbjIJQPA7kIN2UvXJYI63RFsZ41ejy9s=;
        b=WNdVE14ZQ5KOBzs8xQR86YOIXQzpXoWDIF+GzfDJ2HXkkLsH1NkHHHlj2ux4C2OnRn
         Dj2bDUtBMB9APJRM+WrsAto6pSvLgRaWci7pcUVN747gsbc2ZYmKYn3vNg3nAHThFPG7
         vL8RuvCcOXNMzkVj9d1qr9Tyau/0ROdXpqKmdbVQZxSrAjr2LNGwqr/ZkcwAdjeAxWVe
         b66Yh1VqBZZVgEy4mJBj4bIdmUhHSFD/KUxtsl2FsawZsCbgQAobKx9K+kxiwY0fgHVQ
         k9XMlqV4lBV3yDFT7qSg/NS+91jT7QBRUCtRzZbH/giRGjL2F3hQCKCjw9EKzkjx201g
         6inA==
X-Gm-Message-State: ALoCoQmdJkzn+nzi4rOUfVyW7KwF5MzX/rHtTu5irDlg5JojBDrIjK2JWvGqCGZVjCOW8IiY/vRQ+qweT9c6IWboLgDor5fnCA==
X-Received: by 10.25.16.104 with SMTP id f101mr3044999lfi.47.1452854981729;
 Fri, 15 Jan 2016 02:49:41 -0800 (PST)
Received: by 10.112.167.2 with HTTP; Fri, 15 Jan 2016 02:49:02 -0800 (PST)
In-Reply-To: <20160114211335.GB10825@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284158>

Thanks guys, the last answer seems to work !

Wouldn't mind to have a git command that returned the main branch though :p

Thanks,
Pedro Rijo

2016-01-14 21:13 GMT+00:00 Jeff King <peff@peff.net>:
> On Thu, Jan 14, 2016 at 12:12:35PM -0700, Bryan Turner wrote:
>
>> The same thing works for GitHub. Here's the hazelcast/hazelcast repository:
>>
>> bturner@ubuntu:~$ git remote-https
>> https://github.com/hazelcast/hazelcast.git
>> https://github.com/hazelcast/hazelcast.git | head
>> list
>> @refs/heads/master HEAD
>> 988810c4b5c5195412c65357e06cbb0e51173258 refs/heads/3.1.8
>> bddfb328e4779bccec6f7788c94960f6292b02c9 refs/heads/3.2-fix-eacg
>> 84e7d1006cd342c39afdf0ac520b5b04b8233d75 refs/heads/3.3.6
>> 2e4ffc4f593de0869f0db9f7224f964f72dac15d refs/heads/3.4-gem
>> d0a7d416b1220ef4badd98e42991dabe34c7beeb refs/heads/3.5.1
>> 6a13721d33bdb07de23f5c505b689e2ee50d5abb refs/heads/3.5.3-ercssn
>> 56676b20baae8668e731f17c9f3b9844ddd486d0 refs/heads/3.5.4
>>
>> I'm not aware of a simple equivalent for SSH. Also, note that this
>> "git remote-https" trick won't work on Windows. When you hit Enter
>> after "list" it writes a CRLF, so the "git-remote-https" process
>> compares "listCR" against its list of known commands and finds no
>> match.
>
> There's no equivalent for ssh, because you're hooking in at the
> remote-helper layer, and ssh (and git://) are builtins, and http is not.
>
> I mentioned "git remote" elsewhere in the thread, which is probably the
> least gross way (it's just ugly because it writes to a file instead of
> to stdout). But you can also snoop on the protocol:
>
>   $ GIT_TRACE_PACKET=3 git ls-remote origin 3>&1 >/dev/null |
>     perl -lne '/symref=(\S+)/ and print $1'
>   HEAD:refs/heads/master
>
> It would be nice if "git ls-remote" just had some way of printing the
> capabilities.
>
> -Peff



-- 
Obrigado,

Pedro Rijo

From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Exact format of tree objets
Date: Tue, 18 Jun 2013 10:53:29 -0300
Message-ID: <CABx5MBSFxpp4S8utMu5F_-VE-g4n98h67Rf+NfB=7bSk5qrq5w@mail.gmail.com>
References: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
 <7v4nd4bigv.fsf@alter.siamese.dyndns.org> <loom.20130612T160455-551@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 15:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowM7-0000wx-55
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 15:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839Ab3FRNxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 09:53:51 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:53438 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab3FRNxu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 09:53:50 -0400
Received: by mail-vc0-f170.google.com with SMTP id hf12so2932382vcb.15
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hbrHaozWCnl+QttB7Q7Slh3gRMb0eHtpHgFfTbLkj90=;
        b=Il18BxjGPNclyRrGsBE6c62IKwMyjXa4bwFYEscxkqSDPdWsk8qyMoXNdraNqH+RWC
         UYp+WwVzF5zfocYVzn8zOEOuufKS7w2LoRUn7cVFfkPSufMZ6YScqcWDv7xTfEiUabI/
         y7Adn4SWLfLiAMHbXt7Sk/FnN5gYtY3ino4x+5hK/vUcWA0yCjfhy00dZwNvYtaR+sHG
         ZS/6Na3hHhe4qlcP10k4uuMgxvP+A1DpSpdPQ1RSRCzvNsdQiQSVw7sEdTym2ddUec26
         uO8AyQdAHfUZpXZO8PUIaOZ+/Eh8/DIOvK8VvYsxq8KfFGJR9x6bg8fuOMThmB/zFaRm
         wXRQ==
X-Received: by 10.52.94.211 with SMTP id de19mr1575007vdb.59.1371563629598;
 Tue, 18 Jun 2013 06:53:49 -0700 (PDT)
Received: by 10.221.2.134 with HTTP; Tue, 18 Jun 2013 06:53:29 -0700 (PDT)
In-Reply-To: <loom.20130612T160455-551@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228231>

Thanks!

By the way, where can I find this kind of specification? I couldn't
find the spec of tree objects here:
https://github.com/git/git/tree/master/Documentation


--
Chico Sokol


On Wed, Jun 12, 2013 at 11:06 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> Junio C Hamano <gitster <at> pobox.com> writes:
>> Chico Sokol <chico.sokol <at> gmail.com> writes:
>>
>> > Is there any official documentation of tree objets format? Are tre=
e
>> > objects encoded specially in some way? How can I parse the inflate=
d
>> > contents of a tree object?
>> >
>> > We're suspecting that there is some kind of special format or
>> > encoding, because the command "git cat-file -p <sha>" show me ...
>> > While "git cat-file tree <sha>" generate ...
>>
>> "cat-file -p" is meant to be human-readable form.  The latter gives
>> the exact byte contents read_sha1_file() sees, which is a binary
>> format.  Essentially, it is a sequence of:
>>
>>  - mode of the entry encoded in octal, without any leading '0' pad;
>>  - pathname component of the entry, terminated with NUL;
>>  - 20-byte SHA-1 object name.
>
> I always wondered why this is the sole object format where SHA-1 is i=
n 20-
> byte binary format and not 40-chars hexadecimal string format...
>
> --
> Jakub Nar=C4=99bski
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

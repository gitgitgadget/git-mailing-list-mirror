From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git.c: add --index-file command-line option.
Date: Sat, 15 Dec 2012 23:01:08 +0100
Message-ID: <50CCF324.5060802@gmail.com>
References: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com> <7vpq2btcqp.fsf@alter.siamese.dyndns.org> <50CCC73B.3070802@gmail.com> <7vliczrttq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 23:02:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjznx-0004aI-P6
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 23:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab2LOWBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 17:01:18 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58145 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab2LOWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 17:01:18 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2227716bkw.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=CIYfuBuiLjjfnkdISGe0qV6ZvweSySevz3PG0YFXU5k=;
        b=lCkCiOT2jHxwqi1X8gzaLheZyFpxcZipqogotqmYaHKa07/ZY0ItW1pjaw5RjgD6CV
         XqC9lv8++gU8f8r/dsUgbLv/ymeMvccE/0DXKmyTdEGdnTi45zhA01laxDIg1hs0wRlQ
         WNcpQ0YMHf9rmoJt9mlt/BjhGp02ejidfOVBUYarqsOhv/2iIDRfmzlGLiCXA4RXWsBH
         PomROvfWCCK5qJmpEwtIBYxLpYO49Sh1yKiCDWGDqaoqPgFYP4LGvFIs6PCcONCjmg1U
         +Jx0qYFzqGVB6BI6+5QySYby7oKBKh8rE9CXIEfXeLlZj2+IzAZyVdCE7MK9yhduPY1E
         8YTQ==
Received: by 10.204.147.8 with SMTP id j8mr4341509bkv.105.1355608876572;
        Sat, 15 Dec 2012 14:01:16 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id r16sm6814891bkv.3.2012.12.15.14.01.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 14:01:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <7vliczrttq.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211572>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 15/12/2012 20:36, Junio C Hamano ha scritto:
> [...]
>>>> Unlike other environment variables (e.g. GIT_WORK_TREE,
>>>> GIT_NAMESPACE), it was not possible to set the GIT_INDEX_FILE
>>>> environment variable using the command line.
>>>
>>> Is this necessary?  I'd prefer to see a better reason than "just
>>> because others have it".
>>
>> A long running program will be able to tell git to use an alternate
>> index file, without having to modify its own environment,...
> 
> Hrm, isn't that the single-shot environment export syntax
> 
> 	GIT_INDEX_FILE=foo git blah
> 
> is for?  Is there a real-world need for this?
> 

This works with a shell.
I'm using Python to write a custom git command.




Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDM8yQACgkQscQJ24LbaUTftQCbBC7D9P7Sqlr9GzWuCIcIHPf2
aQcAn13+d4trLZS4izGvZtoaopMav4nV
=vfb6
-----END PGP SIGNATURE-----

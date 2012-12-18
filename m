From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: Incorrect man page for git-diff
Date: Tue, 18 Dec 2012 20:10:05 +0100
Message-ID: <50D0BF8D.5050004@gmail.com>
References: <50D0AA78.5090603@gmail.com> <7vwqwffcxp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:10:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2Yj-0008Pw-3a
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab2LRTKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:10:12 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:33149 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab2LRTKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:10:11 -0500
Received: by mail-bk0-f48.google.com with SMTP id jc3so564016bkc.35
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=nzSDjaMVmX+b0Tnmiqa9fp2gq68yefj6NcU0O1wxwjU=;
        b=yvgpV0hz9cuQZ8tkcN7tFmGitroCqgWzKlh+ep8Cz7DRByQ4C6x0UhdUI8H0OGhiVO
         FHHl4/XXutvKcPzoCBVxYU+43rDNT2rn1XXlQnnWvDbYJqiDVVzEMDo/p/pgHiMIv0+L
         bvSf+UnabDj2zBi01lOECk4WaYUt3S651JrTsMRh566ZkdGKPyIefreJtluEcQn4ju17
         B4BYp7nyV2fAOoaSa06g63weSzwgqVDwOk3fFEIvLqYcnmTEqZUZGD0ImCHAzVwB0PGX
         YvbK3xiEWXr2+ephm8etgWsfu1IU7BytWIv0DIWPfy6CBk7JZCS+uzKLoeV8zgHjaFFC
         gE5w==
X-Received: by 10.204.147.156 with SMTP id l28mr1230229bkv.87.1355857809752;
        Tue, 18 Dec 2012 11:10:09 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id o9sm2347747bko.15.2012.12.18.11.10.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 11:10:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vwqwffcxp.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211776>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 18/12/2012 19:11, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> Documentation seems to suggest this is supported, but it is not true:
>>
>>   $ git diff HEAD:git.c HEAD~100:git.c -- git.c
>>   usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]
>>
>> unless I'm missing something.
> 
> Neither HEAD:git.c nor HEAD~100:git.c are commits.

Well, the documentation calls these parameter "commit", later saying
"For a more complete list of ways to spell <commit>, see "SPECIFYING
REVISIONS".

>  You are
> comparing two blob objects in their raw forms without textconv nor
> filter.
> 

Note that I was not missing the fact that git diff does not apply
texconv and filters.

I'm not sure the man page is wrong and should be changed:

  -- usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]
  ++ usage: git diff [<options>] [<commit> [<commit>]]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDQv40ACgkQscQJ24LbaUT+vwCgj0rjaZbc+/x0+jvAGZydbVKB
244An2pWLj7t4nG3lZzx+LGyH3mjTujS
=TmVI
-----END PGP SIGNATURE-----

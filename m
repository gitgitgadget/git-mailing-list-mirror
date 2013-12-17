From: Johan Herland <johan@herland.net>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 12:18:28 +0100
Message-ID: <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
	<CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
	<20131212042624.GB8909@thyrsus.com>
	<CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
	<52B02DFF.5010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Eric Raymond <esr@thyrsus.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 12:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vssfh-0005wA-AK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 12:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab3LQLSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 06:18:36 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:36462 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3LQLSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 06:18:35 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VssfY-0004WO-Qt
	for git@vger.kernel.org; Tue, 17 Dec 2013 12:18:32 +0100
Received: from mail-pb0-f54.google.com ([209.85.160.54])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VssfY-000Jkt-FF
	for git@vger.kernel.org; Tue, 17 Dec 2013 12:18:32 +0100
Received: by mail-pb0-f54.google.com with SMTP id un15so6888493pbc.27
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 03:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eqHDmkRQplbncwG5gGhUujgx9sA3oSc7nuT6BjXWBHs=;
        b=TGAGJAIZuVll86tX3cSAfE611nbVLEjn2qzh/rLbFOws4oDB33jekfYpw5Z9ssFcrj
         d5xfousvpNpsB+k+mPA1yqwK/YR1I1QbiJWQsqh7rshhp2t+IHUKCGXxxuVmHXZY4snD
         +7xF9xwDVZMgME4dm/Wb9xGpA9z9efvtXqfQJzYWRQlk76SObtfyzAfu67naG2tlEBOz
         xHeKWn1xlIq3sYm24p7MUe51BUZcKXxSm2z1wjt6XNZxBRMj3oA49w3ot4PeCv/xghZ7
         jY5ci0t2HgEAHzpbQXNRPtGYjDa5HG0qdhY/M80l7kEL8QJ1S+oFl4Kqpu7qvDQCcb68
         s46Q==
X-Received: by 10.68.236.35 with SMTP id ur3mr20613250pbc.137.1387279108491;
 Tue, 17 Dec 2013 03:18:28 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Tue, 17 Dec 2013 03:18:28 -0800 (PST)
In-Reply-To: <52B02DFF.5010408@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239380>

On Tue, Dec 17, 2013 at 11:57 AM, Jakub Nar=C4=99bski <jnareb@gmail.com=
> wrote:
> Martin Langhoff wrote:
>
>> On Wed, Dec 11, 2013 at 11:26 PM, Eric S. Raymond<esr@thyrsus.com>  =
wrote:
>>>
>>> You'll have to remind me what you mean by "incremental" here. Possi=
bly
>>> it's something cvs-fast-export could support.
>>
>>
>> User can
>>
>>   - run a cvs to git import at time T, resulting in repo G
>>   - make commits to cvs repo
>>   - run cvs to git import at time T1, pointed to G, and the import t=
ool
>
>>
>>
>> will only add the new commits found in cvs between T and T1.
>
>
> I wonder if we can add support for incremental import once, for all
> VCS supporting fast-export, in one place, namely at the remote-helper=
=2E
>
> I don't know details, so I don't know if it is possible; certainly
> unstable fast-export output would be a problem, unless some tricks
> are used (like remembering mappings between versions).

You could do this by mapping some CVS revision identifier (like a hash
over the file:revision pairs if nothing better is available), and that
would be useful when trying to match up the git commit from a later
import against the existing commits from an earlier import.

HOWEVER, this only solves the "cheap" half of the problem. The reason
people want incremental CVS import, is to avoid having to repeatedly
convert the ENTIRE CVS history. This means that the CVS exporter must
learn to start from a given point in the CVS history (identified by
the above mapping) and then quickly and efficiently convert only the
"new stuff" without having to consult/convert the rest of the CVS
history. THIS is the hard part of incremental import. And it is much
harder for systems like CVS - where the starting point has a broken
concept of history...

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net

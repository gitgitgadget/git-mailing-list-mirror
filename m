From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 11:57:03 +0100
Message-ID: <52B02DFF.5010408@gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com> <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@thyrsus.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 11:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VssL1-0004Nt-7y
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 11:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab3LQK5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 05:57:13 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:46680 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3LQK5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 05:57:11 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so2743621eae.5
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 02:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rASUYyBpSNIHJkfUK9CVTcXhYluXz3qTLgNvVg/aKDg=;
        b=k9mLPEY20asUgN9G1U5/eOQGGD39tJUqQItfczuK29i4v+/RFhlG7LfM9ZZ/z+d63v
         Iwrc3UgyU48RLKMGCyq5dya/3pD3tF6J6pQriLV503SFinu8jz97aYjDvqsfTYFKEceS
         6Uo+GECNkXna8cpomHDpYpkR4cB2EM3io0ufOpqdem+7voXN9FA/066iVfbHblvqFI7L
         MDwtFvPqBtiUkji0umxNEw+qwqUq38r7M7bTWNZD4uqRoIb2lXhLO0JEPeS3UgJTj30s
         M1gM7LcfG4gwEZcZ6Qmw+aTDUh0OzUxAv2XfJdVC7pqmn+vyy5S82AW3eyOFqap4CCFS
         UaCw==
X-Received: by 10.14.212.69 with SMTP id x45mr22326347eeo.69.1387277830893;
        Tue, 17 Dec 2013 02:57:10 -0800 (PST)
Received: from [158.75.2.83] ([158.75.2.83])
        by mx.google.com with ESMTPSA id 44sm51942708eek.5.2013.12.17.02.57.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Dec 2013 02:57:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239379>

Martin Langhoff wrote:

> On Wed, Dec 11, 2013 at 11:26 PM, Eric S. Raymond<esr@thyrsus.com>  w=
rote:
>> You'll have to remind me what you mean by "incremental" here. Possib=
ly
>> it's something cvs-fast-export could support.
>
> User can
>
>   - run a cvs to git import at time T, resulting in repo G
>   - make commits to cvs repo
>   - run cvs to git import at time T1, pointed to G, and the import to=
ol
 >
> will only add the new commits found in cvs between T and T1.

I wonder if we can add support for incremental import once, for all
VCS supporting fast-export, in one place, namely at the remote-helper.

I don't know details, so I don't know if it is possible; certainly
unstable fast-export output would be a problem, unless some tricks
are used (like remembering mappings between versions).

--=20
Jakub Nar=C4=99bski

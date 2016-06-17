Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9D720179
	for <e@80x24.org>; Fri, 17 Jun 2016 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbcFQOfv (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 10:35:51 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33466 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcFQOfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 10:35:50 -0400
Received: by mail-lf0-f47.google.com with SMTP id f6so61610604lfg.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 07:35:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=i21Y+erm1bax033GUmHRvMOUXZmMoeT6hvF/cAon88w=;
        b=KTaauGb68ZysFGq09t/3TN/BcrNs9PMTivuytipv04nR1CeBokBKTGP3b2Mo5nAx+v
         y4zVhUe8uigwOSzfMGO0Tdizwa2vN9u0IfhY/Xqrx8LYS7NWjhlkhokoPYUF6QYyobuL
         pAG269s0p3D8Okun8x3ODY0Jg7yeO8UtlF8Uljc0VwNMVYv4GmAY4FaGJcLj5bhilQ4H
         +bKXp6JjZHy7jAkYGjhTwK4TkCPRpfZBRw75EWEjCas+a9dQwivCb2OeNpy8loQY6Vbu
         sxcaQRgK95LiDp9pzh+UFqhW0Hy5l35fca320J4FA4XhOBVOhLLnQPvd4FcxLrid2N7J
         m4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=i21Y+erm1bax033GUmHRvMOUXZmMoeT6hvF/cAon88w=;
        b=jkXVexttGp2hWKSXqqYCd+R4vIfzh2N4tHU/beOhniBIrDkbE0s+wrAjbP3Lhd9ocQ
         8VOaCtObaeG84GqiYUD2GOtyjOPqE33dbKQeT7iE/MdODTp1y63Kq3612C4Lbu8Lbui7
         JR1fN+AL0fgfdQsSH77z0y4xZrv9GYzL8qR3/zifGgpCDFoJ3gVASgBLI9X1PrSKhxlP
         UCrindw8QcnfCDk70oGKmCNanEiEzGISG8iM/Mo/ukjqhHsKOktKfy0LKoHJIp39CRYc
         i4g7KuVPXCmubXfEqQQD8Glam2UE3bO0YAa9fRpI3e1i8lNZrtCESUYLV6EfW3SRRPMO
         VGSw==
X-Gm-Message-State: ALyK8tJDjypfj+8+nb+TT9YeTRMgp6FqJSp6AodDTabae9as0qXFKaFwMyjdX096zDZW2r3hRYguasrazXwO9Esu
MIME-Version: 1.0
X-Received: by 10.25.161.142 with SMTP id k136mr662918lfe.0.1466174147848;
 Fri, 17 Jun 2016 07:35:47 -0700 (PDT)
Received: by 10.25.156.83 with HTTP; Fri, 17 Jun 2016 07:35:47 -0700 (PDT)
In-Reply-To: <20160616121353.GB15988@sigill.intra.peff.net>
References: <CABYP2JZU5wqxCK1B7b_fDB0Lqz4-7a_Erb5dHKReZHQecxC8QQ@mail.gmail.com>
	<20160616121353.GB15988@sigill.intra.peff.net>
Date:	Fri, 17 Jun 2016 20:05:47 +0530
Message-ID: <CABYP2JZ5nNHh_cRkgpRMkn7Qfs4zAjy+wfaputJ0CvZ-M4FW6w@mail.gmail.com>
Subject: Re: URL rewrite in local config unable to override global config rule
From:	Saksham Saxena <saksham.saxena.1994@ieee.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 5:43 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 16, 2016 at 03:44:17PM +0530, Saksham Saxena wrote:
>
>> Summary : Added a new rule to the local config of a git repo by
>> issuing ' git config --local url."https://".insteadOf git:// ', but it
>> wasn't observed by git as it kept using "git://".
>
> Hmm. This works in a simple example for me...
>
>> Details : I had set my global config to use "git://" instead of
>> "https://", as I prefer working with SSH.
>
> ..even if I have an existing "url.git://.insteadOf=https://". But I
> could believe that having other config confuses things. The
> url-rewriting is not "last one wins", but rather that we try all of
>
> > them, and the longest match wins.

Longest? Could you elaborate please?

>
> Can you show us the output of "git config --list" on a repository that
> is having this problem, and then the command that you run and its
>
> > output?

Here you go (https://gist.github.com/sakshamsaxena/a1cee9c39ddc127ae659e92d02d58f0b).
The commands are run in that sequence.

>
>> Recently, I began writing a
>> 'GitHub Wiki' of one of my GitHub projects, and, apparently, those
>> Wikis are normal git repositories, and can be cloned and edited
>> locally. However, the clone url available is served over HTTPS only,
>> and doesn't support any other protocol.
>
> You should be able to clone, fetch, or push wiki repositories using any
> of the normal protocols. So:
>
>   git@github.com:username/repo.wiki.git
>
> should work. Likewise, git:// will work if the repository is public, but
>
> > you cannot push over it.

True. Can't push over git:// and that's why I'm limited to https://

>
> -Peff



-- 
Regards
Saksham Saxena
Member, IEEE Delhi Section Student Network
Member, IEEE DTU Student Branch
Student, Delhi Technological University

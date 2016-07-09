Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743611F744
	for <e@80x24.org>; Sat,  9 Jul 2016 05:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197AbcGIFFG (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:05:06 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36124 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbcGIFFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:05:04 -0400
Received: by mail-io0-f174.google.com with SMTP id s93so18002381ioi.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:05:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GBcNJc+2S8K4/Np0b45ic3d4j+JodDT+taaJfHO/KPg=;
        b=QTg/vmoKkhgXSFsmLUgpOocoHWx98mLN/ToJJ92QkPwjbPdxfX/A5n9s8m1FLoJpjm
         iPiS4eE8jfvv2m1/MHbWfj2+TNnUmE896fgtXWJ/y30bdqnuuscYFyZQZFo1mG197MR+
         kuwoF28NySiVZSz98ozwrTKCkLazoZKj4H+jnzl7lI3kXahzySqy/HLibOMXq9Pv+nJf
         nMGihYR/Ig2j7ZaU+6xc9vMz+hQOUxvO0ULQVAOuoW4mcVLl3Dod4oT6j/zSsIK01SbY
         sPUeaGrT0BwfHBw3aNJKwi3y/P7WHOvhXrg5eEOAih8Dg+JvOPOSR4dbqhZk35Etoe1B
         Sytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GBcNJc+2S8K4/Np0b45ic3d4j+JodDT+taaJfHO/KPg=;
        b=aM2PhPBwEmo1N0Mh3QV+Vju1du4/xHXG7r9hX2y+d35RHn/2RJEqgvclGg2iiV8Cnm
         e1pIzTtBgcPE5QnYSz9yyOD0jH+6SEuK6ywzttnGehyLttnAWV3HkcBBACuKiQV8wEmk
         8WKuGbG+dAjadKNBmMSiRQlFHNZe33YNJVYgTe/rwqxgeJwaFkHuTJBa7nn/9U7CzGOg
         mR2AF5xA4gaZeL9GOB8D3jh/XBMlRLWBKhYrIprX7cOt7VjV4i1W1nfitV0V1eeLdXK5
         H+QvbVfEKUAMLGcqJ4SKAzbPzxTDCnOLw8JSXDD1UX5dC1FtEod9p9joJ2NFCo2fWgUw
         85uQ==
X-Gm-Message-State: ALyK8tI7U7sHJAjJ06QL0kAx07SRjfWs7GGvBsP2kl0cr1sY6JkSC1Ko35lClZt1nJzsmQ==
X-Received: by 10.107.158.204 with SMTP id h195mr11509589ioe.153.1468040703419;
        Fri, 08 Jul 2016 22:05:03 -0700 (PDT)
Received: from gmail.com (c-73-51-186-156.hsd1.il.comcast.net. [73.51.186.156])
        by smtp.gmail.com with ESMTPSA id f9sm1396561ioi.2.2016.07.08.22.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 22:05:02 -0700 (PDT)
Date:	Sat, 9 Jul 2016 00:05:00 -0500
From:	Erik Johnson <palehose@gmail.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
Message-ID: <20160709050500.GD1916@gmail.com>
References: <20160707184408.GA1916@gmail.com>
 <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
 <20160708003646.GB1916@gmail.com>
 <CA+P7+xr_dYbno+JsTmaG+WWrgwsAXXGTyA6HL4A4A34ahHMD=Q@mail.gmail.com>
 <20160709022223.GC1916@gmail.com>
 <CA+P7+xoLKmUaJ9f1obVVDyjBTBe=XvSACvL8uiJWYf+2MTMN8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <CA+P7+xoLKmUaJ9f1obVVDyjBTBe=XvSACvL8uiJWYf+2MTMN8w@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 08, 2016 at 09:58:26PM -0700, Jacob Keller wrote:
>On Fri, Jul 8, 2016 at 7:22 PM, Erik Johnson <palehose@gmail.com> wrote:
>> On Fri, Jul 08, 2016 at 05:41:17PM -0700, Jacob Keller wrote:
>>> It is possible we should update "git branch -d" should perform a
>>> worktree prune first, since that would enable it to determine that you
>>> deleted the directory, and any worktree which is removable should be
>>> marked as persistent.
>>>
>>> Given that there is a known workaround (git worktree prune) and that
>>> it is expected behavior for a branch checked out to prevent deletion,
>>> I think the best coarse of action would be to patch git branch -d to
>>> do a prune before attempting to delete.
>>>
>>> Thanks,
>>> Jake
>>
>>
>> Well, I never mentioned -d (I was using -D), but I think we're both in
>> agreement.
>>
>>
>
>Out of curiosity, what is git branch -D behavior when the worktree does exist?
>
>Thanks,
>Jake

It works the same irrespective of whether or not the directory exists:

% git worktree add ../foo
Preparing ../foo (identifier foo)
HEAD is now at 91e095b Merge pull request #34429 from terminalmage/pkg-latest-versioncheck
% git branch -D foo
error: Cannot delete branch 'foo' checked out at '/home/erik/git/salt/foo'
% rm -rf /home/erik/git/salt/foo
% git branch -D foo
error: Cannot delete branch 'foo' checked out at '/home/erik/git/salt/foo'
% git worktree prune -v
Removing worktrees/foo: gitdir file points to non-existent location
% git branch -D foo
Deleted branch foo (was 91e095b).


--

-Erik

"For me, it is far better to grasp the universe as it really is than to
persist in delusion, however satisfying and reassuring."  --Carl Sagan


--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAleAhfwACgkQXlWDxDeAjz99AACfenllmR8Amm+GTHmtNnBAobSk
SYUAn0fw9qztDDvUFDuGZZikaxgrUVQe
=V/Rc
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--

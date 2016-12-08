Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED524203EC
	for <e@80x24.org>; Thu,  8 Dec 2016 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbcLHPgp (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:45 -0500
Received: from mail-wj0-f178.google.com ([209.85.210.178]:35045 "EHLO
        mail-wj0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbcLHPgo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:44 -0500
Received: by mail-wj0-f178.google.com with SMTP id v7so391292899wjy.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bossastudios-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wP7tPgr8t6+Ua3GwQHFyx378setXEvnyrSRDqIDl4nU=;
        b=NfclaIyTQfLW+dW8+jEht0cIImQezx8jJk8lYSmm9yJGYeStix0N2rRnC1yaI/K8x6
         Ch2XWBX557lSBgSx1Y0HTimOAx9YZYu9A/tnypzhnY3gbeK8hsWG4ckTVhXasiwKSwGa
         xm9XCDjAa6RQcaytcoWz+iBE3T59o+XSWil7WP9Ti6/0wcZObEuMIxQUuoMI2kmc+1cI
         jhVe4D56cbyvZ5fBlHt0xQN1dhAvZPuSITDdeJmt7IJkNSAqeE2JGon06rp+joqENinQ
         /0EbT6KZEIs+o3l/TEdOQGb4PnnRLGi8YWuhY6y/GGjcM3/YTS4mOh0wWLFQnmLxywaH
         8JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wP7tPgr8t6+Ua3GwQHFyx378setXEvnyrSRDqIDl4nU=;
        b=WEc6yFgTauymCNW1H+3RAu55ANcfEnxpf0a8r2VqcyaDN9Fn96+xiynOSsND6YRuML
         +Wbz7p/3p4EUHrlvkhDbAX35gv4JVlqUuQYGX9mdTzyZ5FsaA7SHoGzbB1WcAgbYQOaH
         12Lh5sAcyPh/tmWZdBtEg4pBieATOdpSKQ/RNHiZ4DbD5CxBF514lavgl9zUQhgBaNMb
         XQBehvJXLVQHuBvelMy29nsmvSH1oX5Th5ItLQuXEKMNg7HCqt7AbXS2x9S+dvr9gGIO
         F9CgjJL8T7TatngLUt3dRe4SiqDnY8dTPxVHakcp+8T28ZXgEqPZKbiDEmcJQuX/gh1r
         2/5w==
X-Gm-Message-State: AKaTC026bIBySOXIKDo5en5xFKkCGdCFVrtPwmIcFfBVqK5hY8iYa/smQPVZ6w66wE26HRe7vPnyv6Q6TWkPkZnF
X-Received: by 10.194.177.231 with SMTP id ct7mr65773886wjc.221.1481211402316;
 Thu, 08 Dec 2016 07:36:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.14.9 with HTTP; Thu, 8 Dec 2016 07:36:41 -0800 (PST)
In-Reply-To: <D1437EA2-F4D3-4190-8D79-020C06CFA3DB@gmail.com>
References: <CABW+60x0PSw7uNQZg4SeN7EAbNpraR_HWvnVFz1-fVLYX=B8RQ@mail.gmail.com>
 <06520F42-BD49-4349-83B3-74DCA1E260CD@gmail.com> <CABW+60za0shXucPgg_jGYt4f8QbkLzLmS5GRf8czE67Taqd+zw@mail.gmail.com>
 <D1437EA2-F4D3-4190-8D79-020C06CFA3DB@gmail.com>
From:   Nick Warr <nick.warr@bossastudios.com>
Date:   Thu, 8 Dec 2016 15:36:41 +0000
Message-ID: <CABW+60whExoSLGJSQBbUREC31MCO+c0Vps9Ouc24DF==UrAF4g@mail.gmail.com>
Subject: Re: Serious bug with Git-2.11.0-64-bit and Git-LFS
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 December 2016 at 14:18, Lars Schneider <larsxschneider@gmail.com> wrote:
>
>> On 08 Dec 2016, at 15:00, Nick Warr <nick.warr@bossastudios.com> wrote:
>>
>> That looks pretty much like the error we're dealing with, any reason
>> why going back a point version on Git (not git-lfs) would resolve the
>> issue however?
>
> Going back to GitLFS 1.4.* would make the error disappear. However, I think
> you should fix your repository. Try this:
>
> git lfs clone <YOUR REPO URL>
> cd <YOUR REPO>
> git rm --cached "workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi Effects/Effects/Debris/Meshes/debris_junk.FBX"
> git add --force "workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi Effects/Effects/Debris/Meshes/debris_junk.FBX"
> git commit -m "Move files properly to GitLFS"
> git push
>
> Afterwards you should be able to use the latest version of Git and GitLFS
> without trouble.
>
> Cheers,
> Lars
>
> PS: Top posting is not that popular in the Git community ;-)
>
>
>>
>> On 8 December 2016 at 13:57, Lars Schneider <larsxschneider@gmail.com> wrote:
>>>
>>>> On 08 Dec 2016, at 12:46, Nick Warr <nick.warr@bossastudios.com> wrote:
>>>>
>>>> Using Git-2.11.0 with the latest git-lfs 1.5.2 (also tested with
>>>> 1.5.3) cloning from our locally hosted gitlab CE server via HTTPS.
>>>>
>>>> When cloning a repo (large, 3.3 gig in git, 10.3 in LFS)  for the
>>>> first time the clone will finish the checkout of the git part, then
>>>> when it starts downloading the LFS parts it will reliably finish with
>>>> a smudge filter error.
>>>>
>>>> This leaves the repo in an unstable condition, you can then fetch the
>>>> lfs part without issue, but checking out the lfs files or trying a git
>>>> reset --hard will continue to spit out the same error. As you can see,
>>>> the actual error is not particularly useful.
>>>>
>>>> fatal: workers/unity/Assets/3rdPartyAssets/FORGE3D/Sci-Fi
>>>> Effects/Effects/Debris/Meshes/debris_junk.FBX: smudge filter lfs
>>>> failed
>>>> Unknown command ""
>>>>
>>>> Possibly it's due to the file extension being all capital letters, we
>>>> did manage to change the error by recommitting the file with a
>>>> lowercase extension, but it failed on the next file (which also had a
>>>> capital letter extension).
>>>>
>>>> This has happened on multiple fresh windows 10 64 bit installs,
>>>> different machines and target directories (to hopefully remove the
>>>> possibility of file permissions) where cloning is taking place.
>>>>
>>>> The solution is to back level to Git 2.10.2 and the error disappears.
>>>>
>>>> More than willing to provide any further information,
>>>
>>> Hi Nick,
>>>
>>> debris_junk.FBX is not stored properly in Git LFS.
>>> I explained the problem in detail here:
>>> https://github.com/git-lfs/git-lfs/issues/1729
>>>
>>> You should add the file properly to GitLFS to fix the problem.
>>> However, I think this is a regression in GitLFS and I hope it will
>>> be fixed in the next version.
>>>
>>> No change/fix in Git is required.
>>>
>>> Cheers,
>>> Lars
>

Thank gmail for the top posting, hard enough getting it to send non html mail :(

Just to add a bit more to the discussion, we went and had a look at
that directory which was freshly cloned with 2.10.2 and 1.5.3 and the
files were there (400 KB + FBX files, not 2KB pointers) after the git
reset --hard, we're actually looking at renaming all those files, as
that isn't the only one unfortunately..

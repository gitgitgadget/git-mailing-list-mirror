From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable clone
Date: Sun, 6 Mar 2016 15:49:49 +0700
Message-ID: <CACsJy8Donxwx0LE0jDwpLbS4D-m4JzWne29GHAG0jfh2CH3pdQ@mail.gmail.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
 <CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
 <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1603060831570.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 06 09:50:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acUOP-0003eu-TK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 09:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbcCFIuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 03:50:21 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33430 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcCFIuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 03:50:21 -0500
Received: by mail-lb0-f169.google.com with SMTP id k15so101667559lbg.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N5eJbwpi0bTF3agie9a5+F4N8MRVOw/h4tjeWhMQ9cs=;
        b=C3Q84VUALiySp3dL1GXtdkd0nmG53DOlito26jE/wmYExC+930yZMBwYu8kUA3kmN9
         Umx7BmjuhaA0ZDKQHmpgvb93t0EVy8uIT9I/Xh2OAA15si8rrh43jfYFK/cU8KzR54q9
         MIAOcdVCaxfINEdvPJcTU/zFoAXOhgbrNLc/2Lf3VY9FzZj5kFC3AiQVyILMAWzpsAAK
         hRsoryf6a1KLWqdiLpMbCDppzQXRIaR+vUAvQogt40t6fDJPs4Uh8GhE7ELEkEkOTV9m
         4YTLsSwdwW26fuLWNzYHS/NdnQlIpF6YkLktKB7tRUKv6kU9aMkbL4JLc1o9v3yLKzHQ
         Y5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N5eJbwpi0bTF3agie9a5+F4N8MRVOw/h4tjeWhMQ9cs=;
        b=IFZbf9+lsVSO3vBmkQCaQ+fr4qzSsZweTEw6W50ny+WboAJq97nl6/bqUYoTCoNi/D
         Jw0UFe57oV3hnkcHsWwo/5GL3EMtL4vd3AnnBKnMV4d49+EkkdRrFRZMjaoYh4KIHPI2
         O+eZzbbnFnsL0rmLLjV4xYV1Yf4eL6PlJtYGUq4qv57g26ZyvPvbAtQOkC3SGvj12PS/
         r7fRRyPDj1Keq2ZiQaz47nyuOs7DzwhAKfxLeDI2N+RCiuOyplBX8baJTI5CUovbCL/F
         ynfile0OWekTikw11FeHEVIQnYsVEIOIMVMkXm7hHZRdbaTvpkfsVupsavChOh8T9Q5j
         d+Dw==
X-Gm-Message-State: AD7BkJKL48FWcvM/FROiVWcNHp/U6F4K6jhxbASFXEd77hJoZ3VY0lm66ft3kDqRfGuuZyPjN5xc/oc1UJU7rw==
X-Received: by 10.25.161.131 with SMTP id k125mr5898952lfe.83.1457254219263;
 Sun, 06 Mar 2016 00:50:19 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Sun, 6 Mar 2016 00:49:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1603060831570.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288339>

On Sun, Mar 6, 2016 at 2:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> First of all: my main gripe with the discussed approach is that it uses
> bundles. I know, I introduced bundles, but they just seem too klunky and
> too static for the resumable clone feature.

One thing Junio didn't mention in his summary is the use of pack
bitmap [1]. Jeff talked about GitHub specific needs, but I think it
has values even outside of GitHub: if people store some secret refs in
the initial pack (e.g. hidden by ref namespace, or in reflog - imagine
someone committed a password and did a reset --hard then pushed
again), they probably do not want to publish initial pack as-is. With
pack bitmap, we can sort of recreate the "clean initial pack" on the
fly relatively cheaply because all object order is stable in this
particular pack. We go a tiny bit less static with this resume+pack
bitmap combination.

[1] http://thread.gmane.org/gmane.comp.version-control.git/288205/focus=288222

> So I wonder whether it would be possible to come up with a subset of the
> revs with a stable order, with associated thin packs (using prior revs as
> negative revs in the commit range) such that each thin pack weighs roughly
> 1MB (or whatever granularity you desire). My thinking was that it should
> be possible to follow a similar strategy as bisect to come up with said
> list.
>
> The client could then state that it was interrupted at downloading a given
> rev's pack, with a specific offset, and the (thin) pack could be
> regenerated on the fly (or cached), serving only the desired chunk. The
> server would then also automatically know where in the list of
> stable-ordered revs the clone was interrupted and continue with the next
> one.
>
> Oh, and if regenerating the thin pack instead of caching it, we need to
> ensure a stable packing (i.e. no threads!). That is, given a commit range,
> we need to (re-)generate bytewise-identical thin packs.

The bytewise-identical idea is already shot down. But I like the
splitting into multiple thin packs (and re-downloading the whole thin
pack when failed). Multiple thin packs allow resume capability.
Chaining thin packs saves bandwidth. And pack-objects still has
freedom doing anything inside each thin pack. For gigantic repos and
good-enough connections, this could work (even for fetch/pull).

The biggest problem I see is it's hard for rev-list to split thin
packs based on pack size because we do not know that until
pack-objects has consumed all revs and produced the pack.
Approximation based on the number of objects should probably be ok
unless there are very large blobs. But that probably should be
addressed separately by the resurrection of Junio's split-blob series.
-- 
Duy

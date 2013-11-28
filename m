From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 11:15:27 -0800
Message-ID: <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 28 20:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm74I-0005gF-1M
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab3K1TPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:15:50 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:32965 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab3K1TPt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:15:49 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so8459895wes.41
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dglIrLgW3BXqKDZHJbnFYq9gAIqW0WhTmaBTtM/voQI=;
        b=HUPCg0Fz7jxYo2F245eAzY/U3UFEMtSX5XM4SXjhJ+dnDzC4h0JdtlwEYzQLTuTJmZ
         v53iRT0HgpbUEYwoVvfeEQNAB/5PMkBDM2Qw/lA9kY8Qr3WtNlQ3yOqZTnW+uuIthiHJ
         7igKgUGhAkWvhQ9KZ3YO2rb7iNeWzh1MgcL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=dglIrLgW3BXqKDZHJbnFYq9gAIqW0WhTmaBTtM/voQI=;
        b=GMvcZVbiRtPDI8bQ5j7SCz0aZe7bksvljHo7G3sF4sVyRW8oDsyUG62EEhfL3qOnfj
         y9YW4nvBDVcUz8h6JwezaoCnITUSXrTWrbAbjZOxikN6kgEA2ZvGepasu2HUT1eWh4At
         lKPlRw4lOY/J9NtkhIYt0lGcusl3ODpkdTpx73+2UaYy4kh92tIgIJlXYQpCet/dyUMh
         zCq3cRjdGFfhUDuF5krHo/U6JwP91boAjIynIA42PT58d5TE/aDZQevu/r8/Y1r6iif8
         TF73PUx6U1tault4jBua2xR9+YeZ8Yl+xKTcU+1LoGN3YkV66Dw2T2wSq8s2SX8dq3D7
         JkWw==
X-Gm-Message-State: ALoCoQldZZ5v4Q2+hXh1K1kg0O1WCW5CeNA56HcXv6EAhR725BS9lJ9MKA2kndfTD6K/5av6Gi+/
X-Received: by 10.180.210.232 with SMTP id mx8mr3824195wic.34.1385666147266;
 Thu, 28 Nov 2013 11:15:47 -0800 (PST)
Received: by 10.227.192.198 with HTTP; Thu, 28 Nov 2013 11:15:27 -0800 (PST)
In-Reply-To: <20131128092935.GC11444@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238502>

On Thu, Nov 28, 2013 at 1:29 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 28, 2013 at 04:09:18PM +0700, Duy Nguyen wrote:
>
>> > Git should be better support resume transfer.
>> > It now seems not doing better it=92s job.
>> > Share code, manage code, transfer code, what would it be a VCS we =
imagine it ?
>>
>> You're welcome to step up and do it. On top of my head  there are a =
few options:
>>
>>  - better integration with git bundles, provide a way to seamlessly
>> create/fetch/resume the bundles with "git clone" and "git fetch"

We have been thinking about formalizing the /clone.bundle hack used by
repo on Android. If the server has the bundle, add a capability in the
refs advertisement saying its available, and the clone client can
first fetch $URL/clone.bundle.

=46or most Git repositories the bundle can be constructed by saving the
bundle reference header into a file, e.g.
$GIT_DIR/objects/pack/pack-$NAME.bh at the same time the pack is
created. The bundle can be served by combining the .bh and .pack
streams onto the network. It is very little additional disk overhead
for the origin server, but allows resumable clone, provided the server
has not done a GC.

> I posted patches for this last year. One of the things that I got hun=
g
> up on was that I spooled the bundle to disk, and then cloned from it.
> Which meant that you needed twice the disk space for a moment.

I don't think this is a huge concern. In many cases the checked out
copy of the repository approaches a sizable fraction of the .pack
itself. If you don't have 2x .pack disk available at clone time you
may be in trouble anyway as you try to work with the repository post
clone.

> I wanted
> to teach index-pack to "--fix-thin" a pack that was already on disk, =
so
> that we could spool to disk, and then finalize it without making anot=
her
> copy.

Don't you need to separate the bundle header from the pack data before
you do this? If the bundle is only used at clone time there is no
--fix-thin step.

> One of the downsides of this approach is that it requires the repo
> provider (or somebody else) to provide the bundle. I think that is
> something that a big site like GitHub would do (and probably push the
> bundles out to a CDN, too, to make getting them faster). But it's not=
 a
> universal solution.

See above, I think you can reasonably do the /clone.bundle
automatically on any HTTP server. Big sites might choose to have
/clone.bundle do a redirect into a caching CDN that fills itself by
going to the application servers to obtain the current data. This is
what we do for Android.

>>  - stablize pack order so we can resume downloading a pack
>
> I think stabilizing in all cases (e.g., including ones where the cont=
ent
> has changed) is hard, but I wonder if it would be enough to handle th=
e
> easy cases, where nothing has changed. If the server does not use
> multiple threads for delta computation, it should generate the same p=
ack
> from the same on-disk deterministically. We just need a way for the
> client to indicate that it has the same partial pack.
>
> I'm thinking that the server would report some opaque hash representi=
ng
> the current pack. The client would record that, along with the number=
 of
> pack bytes it received. If the transfer is interrupted, the client co=
mes
> back with the hash/bytes pair. The server starts to generate the pack=
,
> checks whether the hash matches, and if so, says "here is the same pa=
ck,
> resuming at byte X".

An important part of this is the want set must be identical to the
prior request. It is entirely possible the branch tips have advanced
since the prior packing attempt started.

> What would need to go into such a hash? It would need to represent th=
e
> exact bytes that will go into the pack, but without actually generati=
ng
> those bytes. Perhaps a sha1 over the sequence of <object sha1, type,
> base (if applicable), length> for each object would be enough. We sho=
uld
> know that after calling compute_write_order. If the client has a matc=
h,
> we should be able to skip ahead to the correct byte.

I don't think Length is sufficient.

The repository could have recompressed an object with the same length
but different libz encoding. I wonder if loose object recompression is
reliable enough about libz encoding to resume in the middle of an
object? Is it just based on libz version?

You may need to do include information about the source of the object,
e.g. the trailing 20 byte hash in the source pack file.

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Sat, 7 Apr 2012 00:23:28 +0700
Message-ID: <CACsJy8A2AKApvWJ4JqQn0e=KE1-bx_A9cmCCLxG4A7VkeOrRsg@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
 <CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com>
 <878vi8sx1x.fsf@thomas.inf.ethz.ch> <CACsJy8AkFiiaKnqqyLEZfa+DJsRyKd6dGEN71c3q=6j3fo8jww@mail.gmail.com>
 <CAJo=hJsfXd8J3ndLTMSUFRaH4FG+4YDXdnfFZ13bC+hoA3GE8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <italyhockeyfeed@gmail.com>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 19:24:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGCtM-0002g9-7I
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 19:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab2DFRYC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 13:24:02 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45810 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab2DFRYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 13:24:00 -0400
Received: by wibhq7 with SMTP id hq7so718940wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dN+IeXX42/7Woob7F0AdnaQKoPoEhNlfWhf7RWmzaJ8=;
        b=lj8WRSuamouObn2uKwwXdWRtMv1aKQbvBsKHdpBCKaaVYwD22WODP6MK/HQ/zc1f7J
         MLIMfAIpE+AUFTqUJvfcu3gJhcNbse02Bt2vgP5Z1+K3Oq+Vjqfeb5Yl6ieDFBiQi3zi
         JhzCsUTzrfZAa2X3ezHOTzTLZDZZKyLXfxComCa/c8f2TxWksLMFPrlVZYk/W1fOhmX1
         /ThtO37+127Mm6jc+Cen2EzTkYUeT5nzbpAj1cPo+59EKrUU4qfXED2GmWX1uqrfRxGm
         XXbpO2YrkYtHLAl6WfbEEB/UE5dQZaq4z1P+NRNxXYJlQK2EHPreyHlnofS78hL3qvTL
         35Zg==
Received: by 10.180.97.41 with SMTP id dx9mr20675427wib.9.1333733039080; Fri,
 06 Apr 2012 10:23:59 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Fri, 6 Apr 2012 10:23:28 -0700 (PDT)
In-Reply-To: <CAJo=hJsfXd8J3ndLTMSUFRaH4FG+4YDXdnfFZ13bC+hoA3GE8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194885>

On Sat, Apr 7, 2012 at 12:13 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Fri, Apr 6, 2012 at 08:44, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
>> On Fri, Apr 6, 2012 at 10:24 PM, Thomas Rast <trast@student.ethz.ch>=
 wrote:
>>> But even so: do we make any promises that (say) git-add is atomic i=
n the
>>> sense that a reader always gets the before-update results or the
>>> after-update results? =C2=A0Non-builtins (e.g. git add -p) may make=
 small
>>> incremental updates to the index, so they wouldn't be atomic anyway=
=2E
>>
>> Take git-checkout. I'm ok with it writing to worktree all old entrie=
s,
>> or all new ones, but please not a mix.
>
> Why, what is the big deal? git-checkout has already written the file
> to the local working tree. Its now just reflecting the updated stat
> information in the index. If it does that after each file was touched=
,
> and it aborts, you still have a partially updated working tree and th=
e
> index will show some updated files as stat clean, but staged relative
> to HEAD. I don't think that is any better or worse than the current
> situation where the working tree is shown as locally dirty but the
> index has no staged files. Either way you have an aborted checkout to
> recover from by retrying, or git reset --hard HEAD.
>
> In the retry case, checkout actually has less to do because the files
> it already cleanly updated match where its going, and thus it doesn't
> have to touch them again.

OK, what about git-commit? If I read your description correctly, you
can update entry sha-1 in place  too. Running cache-tree on half old
half new index definitely creates a broken commit.

A command can also read (which does not require lock), update its
internal index, then lock and write. At that time, it may accidentally
overwrite whatever another command wrote while it was still preparing
the index in memory.
--=20
Duy

From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Fri, 14 Jan 2011 14:26:42 +0000
Message-ID: <AANLkTi=8s4mjreC1yiJi4R5Y3G6_kErmBfk0B9ALcBO8@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>
	<AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
	<AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
	<AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
	<AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com>
	<AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com>
	<AANLkTimkDYCL7+N-Rno1-0p3Gy6o0wYrnuStV_n5k4Hk@mail.gmail.com>
	<AANLkTi=3ikJ2UNNCW582CT7LQ7o2DBZ1hXJhPfMUNbKk@mail.gmail.com>
	<4D2F8D7E.6030305@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jan 14 15:27:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdkc5-0006ua-Pv
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 15:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab1ANO0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 09:26:46 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50642 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab1ANO0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 09:26:44 -0500
Received: by qwa26 with SMTP id 26so2766755qwa.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 06:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oB0rHEnxtZJSqqpICgVDxQ3184ahkUizDjr3r6ziqi4=;
        b=B/HDvmwhPyX8p9AFTDuKDOg//Pe75TPDB4/wthmeYiJx7kGbZb9HnSWjrcwAAsKHZb
         N5aHXQv2AW+aYC/qUjXtSbme0iWnmERH4iUQxGdnEF892Ejox7SWTNUjy3F8QMnqD6qS
         NsdawzVVIt0du1yp6kP8aEOnUiY4V5QK5jv4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=otmKSmCp5wMwVQuWvhNsqxtqNZYmEhStXkRrrgzSjMgA0PER6KGipsz30GrXc9znqa
         FJLJyWjpEO3u4yq1Ct3m5EZ/2BMa3MsA8up1MnCSrKlpnNRYbAhN+vvaHmWuOCvI/gxf
         NSyARofXaftPu1MADCHL6ufzwKfQ9/JP0JoIM=
Received: by 10.224.2.74 with SMTP id 10mr764318qai.119.1295015203388; Fri, 14
 Jan 2011 06:26:43 -0800 (PST)
Received: by 10.220.175.200 with HTTP; Fri, 14 Jan 2011 06:26:42 -0800 (PST)
In-Reply-To: <4D2F8D7E.6030305@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165104>

On Thu, Jan 13, 2011 at 11:40 PM, Sam Vilain <sam@vilain.net> wrote:
> On 14/01/11 00:39, Luke Kenneth Casson Leighton wrote:

>> and change that graph? =C2=A0are you _certain_ that you can write an
>> algorithm which is capable of generating exactly the same mapping,
>> even as more commits are added to the repository being mirrored, or,
>> does that situation not matter?
>
> For a given set of start and end points, and a given sort algorithm,
> walking the commit tree can yield deterministic results.

 excellent.  out of curiosity, is it as efficient as git pack-objects
for the same start and end points?

> Did you look at any of the previous research I linked to before?

 i've been following this since you first originally started it, sam
:)  it would have been be nice if it was a completed implementation
that i could test and see "for real" what you're referring to (above)
- the fact that it's in perl and has "TODO" at some of the critical
points, after trying to work with it for several days i stopped and
went "i'm not getting anywhere with this" and focussed on bittorrent
"as a black box" instead.

 if i recall, the original gittorrent work that you did (mirror-sync),
the primary aim was to rely solely and exclusively on a one-to-one
direct link between one machine and another.  in other words, whilst
syncing, if that peer went "offline", you're screwed - you have to
start again.  is that a fair assessment?  please do correct any
assumptions that i've made.

 because on the basis _of_ that assumption, i decided not to proceed
with mirror-sync, instead to pursue a "cache git pack-objects"
approach and to use bittorrent "black-box-style".  which i
demonstrated (minus the cacheing) works perfectly well, several months
back.

 in this way (i know i didn't reply earlier - apologies), there is
absolutely no need to "take bittorrent apart", no need to modify it,
tinker with it, adjust it, redesign it, learn from it "for
inspiration" - you just get on with it, using the code, protocol and
everything about it as a black-box. "get this file to everyone and
anyone wot needs it".

 as well, after nicolas and others went to all the trouble to explain
what git pack-objects is, how it works, and how damn efficient it is,
i'm pretty much convinced that an approach to uniquely identify, then
pick and cache the *best* git pack-object made [by all the peers
requested to provide a particular commit range], is the best, most
efficient - and importantly simplest and easiest to understand -
approach so far that i've heard.  perhaps that's because i came up
with it, i dunno :)  but the important thing is that i can _show_ that
it works (http://gitorious.org/python-libbittorrent/pybtlib - go back
a few revisions)

 so - perhaps it would help if mirrorsync was revived, so that it can
be used to demonstrate what you mean (there aren't any instructions on
how to set up mirrorsync, for example).  that would then allow people
to do a comparative analysis of the approaches being taken.

 i'd be *very* interested - and i'm sure that there are others
likewise equally as interested - to see if the mirrorsync "commit tree
walking" algorithm can come up with a more efficient method of
transferring git repositories than git pack-objects can.

l.

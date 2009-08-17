From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 19:53:49 +0700
Message-ID: <fcaeb9bf0908170553k7008d7a0u1f5955f227a991df@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com> 
	<fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> 
	<2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com> 
	<fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com> 
	<4A8932BB.7030002@viscovery.net> <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com> 
	<alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:54:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1j8-0005tj-By
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbZHQMyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 08:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbZHQMyJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:54:09 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:33301 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZHQMyI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 08:54:08 -0400
Received: by ywh3 with SMTP id 3so4054147ywh.22
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ni1Tb4FecPLDTh+k8HOibNJZKO/EFu4RhZ+XxgK5bII=;
        b=wmkaVQRwTArZ6jDsAhtWg1QUxlAGc00g2L03ZCJ3rFUt4tRUob9xHTe/Ujk6JqcIu2
         WB/EqRCjH3hCsRjUxZ0IxGXDNKxzO8InRm00aZiIjt4jOakBlHjv1n58B/cmVX19GsY0
         8QBu4ybgK6K3a3APd0U5Nj8l05RUslA8w3Kw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uhP8tkxpkGAgvuP28CIHxjjrkgkvwb+RbjY3Gu+alOPCs8i9aAr1dtZt8iwAD4cLl6
         5DFHgMjlCYoOIl40UD/WDihxJlQY9r6c2AHm+QEGqdGn6jkAfAmtyVFQDj2eqAGcnzCw
         D2R/s1ntOkeWd1ndSC+xqgiHpkfSznL/50fV0=
Received: by 10.100.55.18 with SMTP id d18mr939369ana.80.1250513649360; Mon, 
	17 Aug 2009 05:54:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126176>

On Mon, Aug 17, 2009 at 7:29 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Nguyen Thai Ngoc Duy wrote:
>
>> On Mon, Aug 17, 2009 at 5:36 PM, Johannes Sixt<j.sixt@viscovery.net>=
 wrote:
>>
>> > In order to advocate my earlier proposal: Name the file
>> > .git/info/phantoms, then it's clear: "The files mentioned here are
>> > phantoms" - they exist in the index, but not in the worktree; no
>> > phantoms means that everything is checked out.
>>
>> OK. Phantom checkout, must be unique in VCS world ;-) If no one obje=
cts
>> my next series will use this name as it's better than "sparse" and
>> "assume-unchanged" is just too vague. Would option names to
>> enable/disable this be --with[out]-phantoms?
>
> The term 'phantom' is not specified at all. =C2=A0At least interested=
 people on
> the mailing list know 'sparse'. =C2=A0But I agree that the naming is =
a major
> problem, hence my earlier (unanswered) call.
>
> However, I would find specifying what you do _not_ want in that file
> rather unintuitive, in the same leage as receive.denyNonFastForwards =
=3D no.

But .gitignore is because I do _not_ want some files. Hey, how about
worktree-ignore? Turning it to positive matching instead of excluding
is not hard, but I have a feeling that people (OK, I) usually want to
ignore some directories. Applying trick:

*
!foo/
!bar/

to have foo and bar ignored too often would not be fun.
--=20
Duy

From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Git Download/Bootstrap Suggestion
Date: Sat, 28 Mar 2009 09:24:08 -0700
Message-ID: <8c9a060903280924h62f4d7aq47819bf3264e6ad6@mail.gmail.com>
References: <49CD0841.9000602@gmail.com> <fabb9a1e0903271621g392eefdeu85b46c655c1ad067@mail.gmail.com> 
	<49CE4BD2.4060808@drmicha.warpmail.net> <fabb9a1e0903280915l512374ebt8a1f804666dfe87b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 17:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnbMK-0002YE-9H
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 17:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbZC1QY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 12:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757886AbZC1QY0
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 12:24:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:48031 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbZC1QYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 12:24:24 -0400
Received: by rv-out-0506.google.com with SMTP id g37so447089rvb.5
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QChCSjwo6pBHZ7LW7//Q8h1x4A6uz2vFS3Mu6Ql5Pn4=;
        b=m831+/oiAODWFBimzxPK2JI5uq5tNm73TkGwJ64+cAfqxlmMyC9VlpKrnKuqy77fHJ
         f9tUIc0nnztIYOKmijiqltriIBWP6VlaeWZpm7FGp6//iJRYzh1Hvb3TjDO3FZXoO/ci
         QGM2LPml7kso06SZAFUsIuxTZ3FBR4gPORM80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hDGX1y4NQOWWXaxJeQ34nxDhNm3J9jo9hy9/QHgNxH3Ph1UdXJJLKP40jldOD4HeBI
         xKolTUwOdbcfsL13yeN/tkx2uCK3l3OxKaDW1n6yKM+Jp3ztHrdF8p/EBvjSNLQgd4UJ
         u9jvrfRy+9IlRHWmxxwP5S+n3KvvVRai2vC4o=
In-Reply-To: <fabb9a1e0903280915l512374ebt8a1f804666dfe87b@mail.gmail.com>
Received: by 10.142.44.11 with SMTP id r11mr1379158wfr.240.1238257463157; Sat, 
	28 Mar 2009 09:24:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114967>

So he can compile git from a git repo, and not have to download it
(again) after compiling from a work tree.  Saving a step, and
re-compiling a bunch of files when he upgrades.

On Sat, Mar 28, 2009 at 09:15, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Heya,
>
> On Sat, Mar 28, 2009 at 17:09, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> No, I think he meant repo, not work tree.
>
> Why would he need the repo to bootstrap?
>
> --
> Cheers,
>
> Sverre Rabbelier
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

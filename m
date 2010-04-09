From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: am: be more helpful
Date: Sat, 10 Apr 2010 01:31:42 +0200
Message-ID: <j2yfabb9a1e1004091631v40226a94kbad5512e9439c65d@mail.gmail.com>
References: <t2kfabb9a1e1004091559u92230e17h957f2c5565c133e3@mail.gmail.com> 
	<7v4ojk1a1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:32:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NgK-0005yY-Oy
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab0DIXcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 19:32:09 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:51184 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab0DIXcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 19:32:04 -0400
Received: by yxe1 with SMTP id 1so1605973yxe.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=P9g9fFu/D00QVFwv6GjqdYqogWriahGnzFeefZxNQL8=;
        b=GqkChFOcTbe1eIOfgtKpE/y7Vt3Wm7Bb/tb1/q1cF1bfffWai/Ga0MesGbJwOc1HPd
         FTLTGqcNoPZR1U7yR7XdDH59G97tm+rGt4+MA0/w4NP96/mKHZP5d394pRaz7s0y7ZAl
         Z5Zt2efDxSRl1lmwp58Lm5QocNPA9Hgc+5D9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=f1f8RxTCHflFRI3LFCBdo+CgsRxBIHo14pZXwhOudp3gzFG37voMiyJVS+i5gEVCZ8
         81iEqlmAYPtW6PBVm973WY5ATewGGoTGY4+tAX1WRDvtj+lkcI1UTKhvhJ+YLb2hGAFT
         d7d53UsBoJByjKrAE2AWUNCRfoJ/7nDJkdggA=
Received: by 10.100.206.13 with HTTP; Fri, 9 Apr 2010 16:31:42 -0700 (PDT)
In-Reply-To: <7v4ojk1a1i.fsf@alter.siamese.dyndns.org>
Received: by 10.101.142.37 with SMTP id u37mr1180780ann.79.1270855923912; Fri, 
	09 Apr 2010 16:32:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144487>

Heya,

On Sat, Apr 10, 2010 at 01:27, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> I run into this problem every now and then when I manually apply a
>> patch. I apply it, do some stuff, and then having forgotten I already
>> applied it, try to apply it again, and am confused as to why it won't
>> apply. Would it be difficult to teach 'git am' to see if the patch-id
>> of the patch that couldn't be applied has been applied already
>> (similar to what 'git cherry' does I guess?) and print a helpful
>> message saying "warning: patch already applied" when there is a
>> conflict trying to apply such an already-applied patch?
>
> "am -3"?

"Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
No changes -- Patch already applied."

Yeah, that's pretty much what I want, only I'd like to get that as a
warning when running 'git am' without the -3. Either that, or have -3
be the default, which we all know won't happen :P. If I'd realize that
perhaps I'd already applied the patch I could indeed use 'git am -3'
to check that, or, as I do now (after a few minutes of confusion),
scroll up and notice that I'd already applied it. What I want is to
save me those minutes of confusion by having git DWIW.

-- 
Cheers,

Sverre Rabbelier

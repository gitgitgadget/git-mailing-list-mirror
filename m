From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Need to change old commit (and regenerate tree)
Date: Fri, 21 May 2010 09:05:46 +1000
Message-ID: <AANLkTim0M-PJC655bhfcQ6mBYTPt9TK9Ys8qJBJd1UPS@mail.gmail.com>
References: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
	 <m2sk5mtecw.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antriksh Pany <antriksh.pany@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 21 01:05:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFEoR-00032F-91
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 01:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab0ETXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 19:05:49 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:59966 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab0ETXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 19:05:48 -0400
Received: by qyk1 with SMTP id 1so489651qyk.5
        for <git@vger.kernel.org>; Thu, 20 May 2010 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=PKjisBjEB2o/Lf84cCmwMctuNT+drVcW/R3kDBVfhF4=;
        b=nIVrcEnVUbFYGJjdFYJtDbxyDMlpjjN5EY2hDFV/FlzExfJzQrE3y6QBh0SqOW/OoK
         N2U2Ctr97EUKT8V7SsWB1nX4thW8Z2MDSli3x3kulc8z2jrAetOsP6t1JEAeU3RFDNHY
         vnmioC8Dske5FcyPAawN1kAtqUeoUoeBq9G2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ADVxQrd3iB9E0m20LE0IN4gaHM6kB08T94Ryr+DVzez2RaWthE1M0eq90eTp3766ZH
         HmQIR40OEaXyNg75k+7Dlj/UNK/u+q58r/rQchcmztPs4lAOgv1R0HoXfPzgxaTiVBo1
         WD+ibLxTDVvUvC7kF6CEISM19deHVSJ7Z+H7o=
Received: by 10.229.249.212 with SMTP id ml20mr206286qcb.147.1274396746730; 
	Thu, 20 May 2010 16:05:46 -0700 (PDT)
Received: by 10.229.22.194 with HTTP; Thu, 20 May 2010 16:05:46 -0700 (PDT)
In-Reply-To: <m2sk5mtecw.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147418>

On Fri, May 21, 2010 at 8:09 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Antriksh Pany <antriksh.pany@gmail.com> writes:
>
>> Instead of (what I initially expected):
>>
>> A--------o--------o--------o--------o(old B)--------o--------o--------o(old C)
>>
>> A2--------o--------o--------o--------B--------o--------o--------C
>>
>>
>> So what I am missing here? Aren't the new commits B~1, B~2, B~3
>> identical to C~4, C~5, C~6 (respectively) in all ways so as to have
>> gotten them the same SHA1 and hence appear as what I expected them to
>> appear?
>
> No, they have a different commit time, which is also part of the hash.
>

Of course, even if the commit time was forged to be the same, the
parent of B~3 is different to the parent of C~6 and since the parent
is also contributes bits to the respective hashes, B~3 will
necessarily (unlikely hash collisions excepted!) have a different hash
to C~6

jon.

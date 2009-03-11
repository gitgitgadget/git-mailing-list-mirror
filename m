From: John Tapsell <johnflux@gmail.com>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 13:24:09 +0000
Message-ID: <43d8ce650903110624t47e37b19n3fc72e3243978200@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <alpine.DEB.1.00.0903111304520.10279@pacific.mpi-cbg.de>
	 <43d8ce650903110508o3d12f32m8202fae750d215a@mail.gmail.com>
	 <alpine.DEB.1.00.0903111358260.10498@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhORM-0005zj-Qy
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 14:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZCKNYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 09:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbZCKNYN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 09:24:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:15993 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbZCKNYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 09:24:12 -0400
Received: by yw-out-2324.google.com with SMTP id 5so508785ywh.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oQ5GhOCLkjB2jQIdKbOMpZkn74NY8NF09I1q792jnys=;
        b=qHcyiO1g5ba8e9TmE7R2VtdRl0QGOpaAgpsjVAWT1CV/npZxjSylS6NNn4zqmS9AKs
         waIWUFItSATSA6OZsN+Z3rIETq03TQrfQ6l8/h7UfIwUqfWjjHy5jJeGj40hL30cjpSJ
         +TyO1fyyWcx+ZTnr9ajDcDH0yG2xNJ0GItoAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FIFwQlfFqkuE7B3HsQwaaKbqFQqlfOmLRrdJRqsOaRvKEIGLWGHmo5nyXtu5ev1cL8
         7DJUn1xEnbN4t//M7aNarmgFujpOlN0FyRSge9+pzz9qfwT5+kL+rgwvtduYvqX3zIrk
         XiIc4rOWrBFUVftssnPSMQ7Ai9F+qE7EyjFlg=
Received: by 10.142.193.10 with SMTP id q10mr664151wff.205.1236777849435; Wed, 
	11 Mar 2009 06:24:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111358260.10498@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112927>

2009/3/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Wed, 11 Mar 2009, John Tapsell wrote:
>
>> 2009/3/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>> > On Wed, 11 Mar 2009, John Tapsell wrote:
>> >
>> >> There used to be a dependency on python. =C2=A0git-merge-recursiv=
e for
>> >> example, before it was converted to C.
>> >
>> > Not "for example". =C2=A0It was the only dependency of git.git on =
Python,
>> > and the rewrite of merge-recursive was only done to break that
>> > dependency, as I had a platform where I could not install Python.
>>
>> But installing perl was no problem? =C2=A0(Just curious)
>
> Perl was installed, albeit in an ancient version, and compiling Perl
> modules written in C was out. =C2=A0It just did not work.

I wonder if it would then be acceptable to have a python script for
this generalised bisect?  Since it's not core functionality.   Not
quite sure how it would fit in though (I'd rather it was called from
"git bisect" rather than adding another separate git command)

John

From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Mon, 9 Mar 2009 11:46:25 -0400
Message-ID: <76718490903090846x2e84816emed5e21da9788680d@mail.gmail.com>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
	 <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
	 <7vocwcl8ku.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0903080447450.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:48:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lghht-0005Hw-0Z
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbZCIPq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbZCIPq2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:46:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:24752 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZCIPq1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 11:46:27 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1714051rvb.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BWOXP/GgOzm8mfBjsf6BkpJSqMN5PfOgbmjSGxlIfVM=;
        b=skRqCbPIPJ+aBzPU+cXapCZg3G7A3DYIyywqbaHXZWx9uRRYRxY/d104aVV+kP0Hqg
         SinzQRuZB7nJ5DpaKXEsD5CwKGGaK2n9ybprwaSiqK1TX30QXKncK+kRY3tArA2lA0mm
         Z4q4Gb58PsSnxh5SbbrZ2Hcp9oQeTof8GcyJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XiK/OyxF6mhpMLazuX5f8dKHQL/BP/j+iZQ3Gg5z9oC/KqUPuNhCtRagKoZ/W5lwQE
         gbJmO/HQAT83MOoSVc7fk1mA7dox1tB+w2Il4VdllCbRGyGwXrU0AzFd2LYMSD8C5v36
         dfoSYUg93WgaY4GrsOS0ELNoroWHzdi54dfeE=
Received: by 10.140.141.16 with SMTP id o16mr3134729rvd.138.1236613585772; 
	Mon, 09 Mar 2009 08:46:25 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903080447450.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112706>

On Sun, Mar 8, 2009 at 4:49 AM, Daniel Barkalow <barkalow@iabervon.org>=
 wrote:
> On Sun, 8 Mar 2009, Junio C Hamano wrote:
>
>> Jay Soffian <jaysoffian@gmail.com> writes:
>>
>> > This series and js/remote-improvements (e5dcbfd) in pu may not get
>> > along completely. "git remote show" tries to show how the refspecs
>> > expand out.
>>
>> I've created an "early semantic conflict resolution" topic branch th=
at is
>> a cross between this series and js/remote-improvements, like so:
>>
>> =C2=A0 =C2=A0 $ git checkout -b xx/db-refspec-vs-js-remote db/refspe=
c-wildcard-in-the-middle
>> =C2=A0 =C2=A0 $ git merge js/remote-improvements
>> =C2=A0 =C2=A0 $ git apply evil-fixup.diff
>> =C2=A0 =C2=A0 $ git commit --amend -a -m "Evil merge."
>>
>> with the following "fixup-as-an-evil-merge patch", which I'd appreci=
ate if
>> you two can sanity check.
>
> That looks like what I'd come up with as a resolution, too, so I thin=
k
> it's sane unless Jay knows of another way to get remote to care about
> patterns.

Looks good to me too.

j.

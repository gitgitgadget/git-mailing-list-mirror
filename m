From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sun, 25 Oct 2009 11:56:37 +0300
Message-ID: <94a0d4530910250156h1dfe345by51581b2e8acd6629@mail.gmail.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
	 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
	 <7v3a587kc2.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910241212s5d644eb6u66c6f96feafcaf10@mail.gmail.com>
	 <7v3a5860gr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 09:56:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1yu7-0008Dq-GF
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 09:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZJYI4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 04:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZJYI4f
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 04:56:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:60518 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbZJYI4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 04:56:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so744688fga.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bEjHucOrS0xVBgU8SsgftI+ZiIZVqip7MFcvR6IONvE=;
        b=on0fvlHgd8U+enpi3/x+EJg1QNTglOJtPJfjmPo7Gy0e+HR/1paT0ObRz2CYAElXqz
         WagGjCX58ggiooWmvY3k9GpeTQPKBOBPudtTCqVuJl7b3MO8poJHzjn1QxtfjAomKbRL
         gakxTqpAoJCcrmQTuHDnm1SgTqjWIg21lnkZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UYYr3tRAY848gf2cxOmIEkn0mSc8chxHGssg5V/T3ZYnNX7a/vkug+QMNgdwAuITaW
         ClXD2VrK7ofNpUKfwEPpuBohQvPkSROphwql2AL03L5nfm+YmwcJNlLSyK0G9SkF3hbh
         pLYCnXD6U1y8Q8Hirt8yuaUByrarQyTM0Igj8=
Received: by 10.86.170.4 with SMTP id s4mr7527528fge.9.1256460997791; Sun, 25 
	Oct 2009 01:56:37 -0700 (PDT)
In-Reply-To: <7v3a5860gr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131194>

On Sat, Oct 24, 2009 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I suspect the patch would have been much easier to the reviewers it=
 it
>>> stated somewhere in the log message:
>>>
>>> =C2=A0(1) how the mechanical change was produced;
>>
>> There wasn't such.
>
> That is actually a bad news; it is even worse than mechanical spottin=
g
> followed by manual inspection. =C2=A0It would force us feel _more_ wo=
rried, as
> we would then need to grep for leftovers that your manual conversion =
may
> not have caught. =C2=A0Sigh...

Perhaps next time I'll do one round manual, and another one automatic,
but in this case I didn't think it was so difficult to review hunk by
hunk.

>>> =C2=A0(2) what criteria was used to choose between leaving the mech=
anical
>>> =C2=A0 =C2=A0 change as-is and rewording them manually; and
>>
>> If it wasn't straight forward. I considered the following straightfo=
rward:
>> fast forward -> fast-forward
>> fast forwarded -> fast-forwarded
>> fast forwarding -> fast-forwarding
>> fast forwardable -> fast-forwardable
>> non-fast forward -> non-fast-forward
>> Fast forward -> Fast-forward
>> Fast forwarding -> Fast-forwarding
>
> All of these are what "s/([fF])ast forward/$1ast-forward/g" does, are=
n't
> they?

I guess, yes. But that's not how I did it, so I couldn't be sure.

>> I couldn't parse that. From what I can see "Fast forward" was
>> emphasized because the author thought the words didn't make much sen=
se
>> separated. Now that the word is fast-forward, there's no need to
>> emphasize.
>
> Even after your patch, hunk beginning on line 1384 of the
> user-manual says
>
> =C2=A0 =C2=A0... then git just performs a "fast-forward"; the head of=
 the ...
>
> and I think you did the right thing by keeping these dq here. =C2=A0T=
his is the
> first occurrence of the word followed by its explanation and for that
> reason, the word deserves to be emphasized---IOW, the context calls f=
or an
> emphasis.

Yes, exactly.

> In the "Important note!" part, we talk about the pull operation that
> normally creates a merge commit, and _in contrast_, under a particula=
r
> condition (namely, "no local changes"), it does something different
> (namely, a "fast-forward"). =C2=A0We should keep the emphasis on "fas=
t-forward"
> here for exactly the same reason---the context calls for an emphasis

I don't think so. The emphasis in this case breaks the readability of
the text for no reason:
with no local changes git will simply do a fast-forward merge

Can be perfectly understood as it is. But in any case, that's out of
the scope of this patch.

Cheers.

--=20
=46elipe Contreras

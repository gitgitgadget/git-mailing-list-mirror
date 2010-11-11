From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] Documentation/git-pull: clarify configuration
Date: Wed, 10 Nov 2010 20:50:00 -0500
Message-ID: <AANLkTi=2XtadM6=BOih-EUBgQk5Kd==CYmL5YgHto8S6@mail.gmail.com>
References: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<20101110172431.GB11513@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 02:50:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGMIj-0006ki-AA
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 02:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab0KKBuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 20:50:04 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40076 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0KKBuB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 20:50:01 -0500
Received: by qyk30 with SMTP id 30so86593qyk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=djSgCCGSMC3wZtCDm281e9faII7jXo7wRtU6GjQumGM=;
        b=becoPS2AtNjVNC8AmS+gFemPXWXRo+msXRTgnoYmF2xvyLR/BxSeqcJSXge4A6bETg
         Wewm83saFR0NwhWlpm6+Xds475hqmGzGwjSXrKUy9jdQrDw4WyPyl/BsRoOpRmvqPaPN
         ck+ebSkS0vCGiWr1u1DFYK1aim9MRAk3r/6X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xu8LW/1C/uYuj1Pqk8sX5w1w2Cg5hs6F/+tAsc9aG05ZQF8rOeq+3dSz8+YEyTFc4e
         /tEbG2/Q4Mn1AYU9w2JHCreE9cFqXzRvCrGm+CI+5nZQ0VC+mLsBcEfKpOcALkIHhB70
         fOiIDVMozXmjjskNb81PHVjviL/7bdYqRCSuo=
Received: by 10.224.215.193 with SMTP id hf1mr245894qab.275.1289440200941;
 Wed, 10 Nov 2010 17:50:00 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Wed, 10 Nov 2010 17:50:00 -0800 (PST)
In-Reply-To: <20101110172431.GB11513@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161204>

On Wed, Nov 10, 2010 at 12:24 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Hi again,
>
> Martin von Zweigbergk wrote:
>
>> The sentence about 'branch.<name>.rebase' refers to the first senten=
ce
>> in the paragraph. Clarify by putting it in a separate paragraph.
>
> I think the patch clarifies by rewording a little, too. :)

Yes, you are right :-). Will improve it in version 3, if I'm asked to
provide that.

>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -92,12 +92,15 @@ include::merge-options.txt[]
>> =A0:git-pull: 1
>>
>> =A0--rebase::
>> - =A0 =A0 Instead of a merge, perform a rebase after fetching. =A0If
>> - =A0 =A0 there is a remote ref for the upstream branch, and this br=
anch
>> - =A0 =A0 was rebased since last fetched, the rebase uses that infor=
mation
>> - =A0 =A0 to avoid rebasing non-local changes. To make this the defa=
ult
>> - =A0 =A0 for branch `<name>`, set configuration `branch.<name>.reba=
se`
>> - =A0 =A0 to `true`.
>> + =A0 =A0 Instead of merging, rebase the current branch on top of th=
e
>> + =A0 =A0 upstream branch after fetching. =A0If there is a remote-tr=
acking
>> + =A0 =A0 branch corresponding to the upstream branch and the upstre=
am
>> + =A0 =A0 branch was rebased since last fetched, the rebase uses tha=
t
>> + =A0 =A0 information to avoid rebasing non-local changes.
>> +
>> + =A0 =A0 The default behavior is to merge rather than rebasing, but=
 it
>> + =A0 =A0 can be overridden per branch with the `branch.<name>.rebas=
e`
>> + =A0 =A0 configuration item (see git-config(1)).
>> =A0+
>
> Do these changes result in good output with "make -C Documentation
> git-pull.1" or "make -C Documentation git-pull.html"? =A0I think it
> might need to be
>
> =A0 =A0 =A0 =A0first paragraph
> =A0+
> =A0second paragraph
> =A0+
> =A0third paragraph
>
> or similar.
>

Oops, that's embarrassing... but thanks for the hints. I did not know
that.

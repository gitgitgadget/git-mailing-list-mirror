From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 08:37:27 -0500
Message-ID: <AANLkTin2-WAHMjKFKVqq7Wbzvjg-KzMkBh1kCGxDH6Mf@mail.gmail.com>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
	<20101108090230.GC2430@burratino>
	<AANLkTi=rT0S1H8pFt9d+FYVme4fjNNzY6O6evuBwo-ZB@mail.gmail.com>
	<m3mxpkeyh4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Vitaliy Semochkin <vitaliy.se@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFRul-0004Jv-Mi
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab0KHNh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 08:37:29 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38356 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0KHNh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 08:37:28 -0500
Received: by vws13 with SMTP id 13so1753911vws.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=voBob0sJIttqV6DF5EGJtl1zf3GDj9m2CstFn1HR09M=;
        b=KZ7eszkc0UmaA8rPJ5FX9/wLUDzrjDTBKQrMwNApmfjZ76fJfpZNFizwwgcyDXNAu8
         z4/6wajNFhSrPJ82ErA4rOb9nwx/QX5O3GXR6Nuah2wPrCs5clWDBlIANAWsHo0hSzc8
         azGdo4JlDsN4kQ6eo7b3oksCrczCqPbIfPap4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xvC/PoJtVCx9I4AIhAcol1bQKMA/CZmc2k9S3djG+GFNlC41qUWA5MPtkNUQpxgTl9
         Hh2elU8Ed24haGy9cKCUIk0q9H8rran7MyWQTHcAdj8lO2tNgr/sLV7kA4WAVg04oSoF
         +oH2nzmlKTK3ZaMG9XFmCSq5/XZbS4cBt7KPA=
Received: by 10.224.69.200 with SMTP id a8mr3946476qaj.190.1289223447728; Mon,
 08 Nov 2010 05:37:27 -0800 (PST)
Received: by 10.224.20.82 with HTTP; Mon, 8 Nov 2010 05:37:27 -0800 (PST)
In-Reply-To: <m3mxpkeyh4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160937>

On Mon, Nov 8, 2010 at 8:29 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>> On Mon, Nov 8, 2010 at 4:02 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>>> Vitaliy Semochkin wrote:
>>>
>>>> I cloned a remote repository
>>>> to check recent changes in origin/master I do:
>>>> git fetch origin master
>
> This fetches into FETCH_HEAD _only_ from "origin" *remote*.
>
>>>> git log origin master
>
> This show log of 'origin/HEAD', which probably is 'origin/master'...
> but which didn't get updated, and local branch 'master'.
>
>>>>
>>>> recently I found out that log doesn't show recent commits
>>>
>>> Yes, this can be confusing.
>>
>> I agree and I believe this has come up a lot of times before. I talk=
ed
>> to Jeff and Junio about this at GitTogether and Jeff said he has a p=
atch
>> for it that he would try to get up to date in a while. (Thanks, Jeff=
!)
>
> How can this issue be solved? =A0The meaning of parameters in 'git fe=
tch'
> is different from meaning of parameters in 'git log'.
>

Sorry, maybe I misunderstood what the confusion was about. What I was
referring to was the confusion caused by 'git fetch origin master' not
updating 'refs/remotes/origin/master'.

/Martin

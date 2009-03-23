From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 1/8] user-manual: remove some git-foo usage
Date: Mon, 23 Mar 2009 12:54:30 +0200
Message-ID: <94a0d4530903230354x3a37cf56oe3862c2b7c37a8d4@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <20090323063141.GA1119@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhpG-00030a-0T
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbZCWKyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 06:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbZCWKye
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:54:34 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:56265 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbZCWKyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 06:54:33 -0400
Received: by fxm2 with SMTP id 2so1730326fxm.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DT5VXqDWdZ+3T6WoU1oHhNUBLSBet+Tsl91/V3kl53M=;
        b=bjbDzrOzJLGD/8Ib7KSdsazHP+rskLKV3xEet8KpicXAJr2cpBqzCTR+q31yu2QXaN
         RFvA260xO3PC3l588qgn8JE8R3o/35cOO9q0HxBL2M+ztc6SimoNPifipeSCGU0Np8WI
         UAq1uwi/x2vRsNHHAeKql35kZOnSv3a9au2jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zrjx/K9wX3qNlCZBt9tIufgG3jWz4t3gNVMxuaao9UBnZxb44DPY9aX9g2aZBuuGGS
         BBZDXYAzZ8feKKr2LZzeHoNoWDqmfGU3uv+0kK5CDIwRNLsfd45KuIJ7+dkd1Van45nT
         QjAQJDT2tZ3gTYaaYb7F/qATimjtRyK5oCdA4=
Received: by 10.86.94.11 with SMTP id r11mr3524004fgb.11.1237805670485; Mon, 
	23 Mar 2009 03:54:30 -0700 (PDT)
In-Reply-To: <20090323063141.GA1119@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114285>

On Mon, Mar 23, 2009 at 8:31 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 22, 2009 at 08:05:14PM +0200, Felipe Contreras wrote:
>
>> =C2=A0Every commit has a 40-hexdigit id, sometimes called the "objec=
t name" or the
>> -"SHA1 id", shown on the first line of the "git-show" output. =C2=A0=
You can usually
>> +"SHA1 id", shown on the first line of the "git show" output. =C2=A0=
You can usually
>
> I think some of these were intentionally left in the original mass
> dashes to spaces conversion. The intent was that one could use the
> git-show form in talking about the command in text.
>
> However, I think I actually prefer the version given by your patch. I
> just wanted to point out that this is a decision to change how we
> mention these in the documentation and not simply a fix for things th=
at
> got missed in the conversion. Others may disagree on how it looks.
>
> It seems like you added monospace backticks in most locations. Is the=
re
> a reason not to standardize on that and use `git show` here?
>
>> =C2=A0[[Updating-a-repository-With-git-fetch]]
>> -Updating a repository with git-fetch
>> +Updating a repository with git fetch
>> =C2=A0------------------------------------
>
> I think this one should probably be `git fetch`.

A subsequent patch is adding the monospace backticks and a lot more
quotation stuff.

In this patch I tried to focus on git-foo, and add the backticks only
when there are no delimiters, so I replaced "git-foo" with "git foo"
and git-foo with `git foo`. I also didn't add backticks on the titles
because I thought it was a bit controversial and was probably better
in a separate patch.

Cheers.

--=20
=46elipe Contreras

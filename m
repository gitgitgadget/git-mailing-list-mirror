From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for vim/gvim
Date: Sun, 19 Sep 2010 12:48:48 +0300
Message-ID: <AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
	<1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
	<20100918073428.GA9850@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 11:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxGVy-00014c-Cp
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0ISJsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 05:48:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60245 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0ISJst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 05:48:49 -0400
Received: by iwn5 with SMTP id 5so3326357iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CSqqzDnBt24RvAuY5tSGZUCIhaatRdxo9ILCIswfCVA=;
        b=u0ffhVwdpWaFB53LJ8Xk3wqJPGc8ZTtGomL31RNtWHAQ6cZ8hyANZGkdr4E+GQdzQa
         dSNmGJAxxXN359Vicj+UAf/XZALLRV6Dgy5/oPv9/UYMmR5RHdpmaygx4iCxUlrDc4X3
         KHb4PfBYUcnpdeIthoHP4R1b5z4N0teiKNXfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S3Z/XnSVshsOW3giVWc93N3GQ7glGSBOB6KRs8iym3rsHdIoR6ThkGGbIIbeYbpX6l
         yCnur98IeJiz6ha2SeUMkca3cfCG5cxAOgnJncHb3OW+tdXT8QZL03F6QUVbQb/fLJcS
         4Mkrog9f2KDSTDohqSgJRs1SDuMFsMG9a8erI=
Received: by 10.231.130.99 with SMTP id r35mr7075114ibs.171.1284889728515;
 Sun, 19 Sep 2010 02:48:48 -0700 (PDT)
Received: by 10.231.160.6 with HTTP; Sun, 19 Sep 2010 02:48:48 -0700 (PDT)
In-Reply-To: <20100918073428.GA9850@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156488>

On Sat, Sep 18, 2010 at 10:34 AM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Tue, Sep 14, 2010 at 09:21:43PM -0500, Dan McGee wrote:
>> When the base version is available, use a three-way, four panel view=
 by
>> default. This shows the (local, base, remote) revisions up top and t=
he
>> merged result by itself in the lower pane. All revisions will still =
scroll
>> together by default, and the cursor still defaults to the merged res=
ult edit
>> pane.
>>
>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>> ---
>>
>> Vim was one of the few diff commands to not support a three-way merg=
e showing
>> the base revision, so this is a stab at resolving that shortfall. Th=
e biggest
>> objection I can see to this is making the interface a bit more cumbe=
rsome and
>> bloated.
>>
>> An example screenshot of what this produces:
>> http://www.toofishes.net/media/extra/vim_three_way.png
>>
>> -Dan
>
>
> Patch 1/2 of this series looks good to me.
>
> Is it worth keeping the old behavior and calling this new
> mode "vimdiff3" or something along those lines?
>
> I'm not a vimdiff user so I'm not be the best person to
> judge the merits of this change. =C2=A0I like what it's trying
> to accomplish, though. =C2=A0Are there any vimdiff users
> with strong feelings either way?

I think this is a definite improvement; the old mode wasn't really
useful for me.

--=20
=46elipe Contreras

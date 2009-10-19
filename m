From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 13:19:05 +0100
Message-ID: <26ae428a0910190519mbe9ddaava3c15de94a0cd14f@mail.gmail.com>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
	 <alpine.DEB.1.00.0910191155310.4985@pacific.mpi-cbg.de>
	 <26ae428a0910190308t3233debdjfc0c8beedb9c0ac6@mail.gmail.com>
	 <alpine.DEB.1.00.0910191353080.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mohit Aron <mohit.aron@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 14:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzrCm-00056a-FU
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 14:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbZJSMTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 08:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755529AbZJSMTE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 08:19:04 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:43545 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZJSMTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 08:19:03 -0400
Received: by ewy4 with SMTP id 4so1483326ewy.37
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=I8S6u5zgx9h6kl/P9+vhoIOmb7LYPtId8h6ywghQ8l4=;
        b=x/XlXzItTHsLawUy/uc8qiqYirKTOL066Fg9GuXFHMZHbgo8BDuLA1/QkQjXbSnEvQ
         8bs7UbmfOM5Kd5dTMpbug/A2/AiGUASn0TNxsLcm97k3bhS9fFVoa0zL/YvoXDj23p3a
         Ju9HaEz/xNCKzJTwTdHYdgYWDlsPJ74hcW9g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WMSQQXaCAe4/v1so7Cdjh/+6oEmUqce5RbGIA1hmmkbeGaZktXy0/k3g+wMfsbrlyw
         bsoSR06B3tVLs6YWpPIQnsbz6VOK1qmIhHUn18sozDp+uyYoFZWoF16n26C641Q0QCAD
         e+gaAVuSlRj7Ypd2NPOwmDDeCHDcwWsAkm6e8=
Received: by 10.216.91.80 with SMTP id g58mr2085402wef.122.1255954745920; Mon, 
	19 Oct 2009 05:19:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910191353080.4985@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 81fd19d688e0c3d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130693>

Mmm....

Thanks for the helpful reply Johannes. Perhaps you should do diligent
research into mail software that folds quoted text for you. There's a
company called Google you might have heard of. Just a thought.

On the other hand if you can't be bothered making a helpful reply
rather than a rude one perhaps simply not writing anything at all
would, at the very least, leave us absolutely no worse off. Just the
opinion of someone not to be taken seriously.... of course!

Howard

2009/10/19 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> first, if you want to be taken seriously, you might want to avoid to
> top-post.
>
> Second, do diligent research (e.g. on the 'mob' user).
>
> On Mon, 19 Oct 2009, Howard Miller wrote:
>
>> I'm quite interested in this too but I can't see what that patch doe=
s at
>> all. I'm unsure what the 'mob' account is but a search suggests it's
>> something to do with anonymous access, which doesn't seem to make an=
y
>> sense.
>
> If this trivial script (_not_ a patch! This should be obvious at firs=
t
> sight) does not make any sense to you, I fear you will not be able to=
 use
> hooks to do what you want to do.
>
>> Can you explain?
>
> Yes.
>
> The 'mob' user (who is password-less) can push to the 'mob' branch _i=
ff_
> that exists. =A0IOW a user of repo.or.cz can decide to let random peo=
ple to
> push commits by creating the 'mob' branch and adding the 'mob' user t=
o the
> pushers.
>
> The first part of the hook (as you can see from the pretty helpful er=
ror
> messages it outputs) is about denying to push to anything but the mob
> branch.
>
> The second part is much more interesting in the context of this threa=
d
> (and I would expect anyone capable of reading shell scripts to see th=
at
> readily), because it denies the 'mob' user to _create_ the 'mob' bran=
ch.
> See line 16ff.
>
> So the point is: the update hook gets a "$2" =3D 0000... in case a br=
anch is
> about to be created, and the hook can prevent that by exiting with a
> non-zero exit code.
>
> Hth,
> Dscho
>
>

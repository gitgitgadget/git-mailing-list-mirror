From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Issue with git rebase
Date: Tue, 14 Sep 2010 12:43:48 +0000
Message-ID: <AANLkTikA7WpyiZCq43+vdUBri5X9pi3odkfRYd4jMXwR@mail.gmail.com>
References: <AANLkTikWPkJ+8DJn5KZXfVw460HRY3Ui-xDZ_TR1X_Xg@mail.gmail.com>
	<AANLkTikUE1q-MrOsc3QOc1x0UHdLJn6nf7yGJZ=q_qqP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rob Aldred <raldred@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 14:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvUrb-0002Wq-02
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 14:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab0INMnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 08:43:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57232 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab0INMnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 08:43:49 -0400
Received: by yxp4 with SMTP id 4so2345615yxp.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V83kll1YWwUvstzUlMdhYs0eFCUAYk4+cloJvCTLK1A=;
        b=XoMbAxEA3fVdq1mZRFAuN8LsEdvUedn9HT1Nbb+pjKQx9ycg6+OM6jfW0DJ2s4X0Fs
         cbt3HnMnXAUa+6Xc9l7tccOoFnWk3boBN6GBiR9eCwVWn5c/pwJiD3XUNHYBrmz75fz5
         zlzcS35pSGJkYhsZPNJAtRiZttT0wXDqTl8TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q6n+A/p9bjsaIjsqBYsFsEFn/BS4J7DFYge0hw5OidDZ2POQW6u0RDFDgsZe+H87gL
         r+3GcKGiGSFRD3/7yo8DTkEzoVR/mc7Qz2ND404Y58p3uOgHbd7Dq/WsqA/bh9ezAplc
         vFl5H055unEOkJllstNhUVmoubiL9cVGWDPzs=
Received: by 10.151.101.19 with SMTP id d19mr13865ybm.330.1284468228263; Tue,
 14 Sep 2010 05:43:48 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 14 Sep 2010 05:43:48 -0700 (PDT)
In-Reply-To: <AANLkTikUE1q-MrOsc3QOc1x0UHdLJn6nf7yGJZ=q_qqP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156170>

On Tue, Sep 14, 2010 at 12:39, Rob Aldred <raldred@gmail.com> wrote:
> Hey, I have a problem with rebase which i suspect is not very common
> I'm trying to repair a commit where over 100,000 lines including a
> diff were commited to the commit message.
> I have followed the manual here:=C2=A0http://bit.ly/9uVReJ
> That produces an error when it reaches the bad commit, heres the outp=
ut:
>
> =C2=A0 =C2=A0First, rewinding head to replay your work on top of it..=
=2E
> =C2=A0 =C2=A0Applying: fixes #2791 - added page count back in
> =C2=A0 =C2=A0Applying: fixes #2399 - commenting out code for starting=
 and
> restarting solr/sunspot on production sites
> =C2=A0 =C2=A0Applying: fixes #2361 - all selenium features now pass
> =C2=A0 =C2=A0Applying: fixes #2797 - fixed checkout footer
> =C2=A0 =C2=A0Applying: Implementing cartridge chooser wizard, Showing=
 featured
> products on the homepage and improving the printer inks page
> =C2=A0 =C2=A0=C2=A0.......the rest of the massive 100000+ line commit=
 message......
> =C2=A0 =C2=A0/usr/local/git/libexec/git-core/git-am: line 765:
> /usr/local/git/libexec/git-core/git: Argument list too long

What version of Git is this, and what does it have on git-am line 765?

How does it look under GIT_TRACE=3D1 ?

In cases like these you can extend the maximum argument list that the
OS can take as a workaround.

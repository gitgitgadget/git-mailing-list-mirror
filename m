From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Sun, 12 Sep 2010 22:12:23 +0200
Message-ID: <AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
	<4C8CF231.6090403@borg.org>
	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
	<4C8D14F9.90705@borg.org>
	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
	<4C8D3303.1030302@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Alejandro_Riveira_Fern=C3=A1ndez?= <ariveira@gmail.com>
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Sun Sep 12 22:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ousub-0006MF-Bp
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0ILUMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 16:12:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36472 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0ILUMX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 16:12:23 -0400
Received: by iwn5 with SMTP id 5so4388692iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8FfD8fzh4+Mg0EEkbm/9KQgPHuG9un+ZvzQypC3jWn8=;
        b=p+uQyCQ0vd4eGeRUrF0H5qLGoc7R3bEDjsfpG8jwUXwiUqmUtWHhvyQfXc4N5Sej2u
         KzGSI7RcHoFl8MNGldhNhlFXtk7YfmuxQV3mcK2ggRW0CI+Upv5iA35NGcxzJSogZvNg
         RoqFKFTOaMnlezpEANJKocP4ScPqaby5yB54M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tlTGYEasSHQD/okg1nrR+6HI5mAA90bgPJAx9ou3WbLYH5elj5jiN50Djj55XgeXmg
         dNkkmPwkTSiS+VIJEbjaQ9HJ/7NEgHMp9BwzouXRAR0qtHKQeD3Qtq1GfS7at03pTJ0T
         EbxHbmOq1mvfL4Zy+CcBp0bbfQy404iM9U61c=
Received: by 10.231.190.75 with SMTP id dh11mr4848236ibb.189.1284322343263;
 Sun, 12 Sep 2010 13:12:23 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Sun, 12 Sep 2010 13:12:23 -0700 (PDT)
In-Reply-To: <4C8D3303.1030302@borg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156051>

2010/9/12 Kent Borg <kentborg@borg.org>:
> Tor Arvid Lund wrote:
>> When messing about with git-p4 I have sometimes messed up that
>> p4/master ref myself. I can normally fix it by setting it manually
>
> Um, I maybe just did that before I saw your e-mail.
>
> I edited:
>
> =C2=A0.git/info/refs
> =C2=A0.git/ORIG_HEAD
> =C2=A0.git/packed/refs
>
> ...and put in the sha1 of the "[git-p4:"-commit.
>
> When I now do:
>
> =C2=A0$ git rev-list --no-merges remotes/p4/master..master
>
> I get just the one commit that I hoped to get!
>
> ...did I just fix it?

My guess: Yes! :)

> I don't have time to try the "git p4 submit" now, I am going to be la=
te
> in meeting my wife. =C2=A0Tomorrow morning...will it work?

I'm optimistic :)

-TA-

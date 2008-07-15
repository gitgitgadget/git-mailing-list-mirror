From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git stash save --keep-index
Date: Tue, 15 Jul 2008 16:50:43 +0200
Message-ID: <bd6139dc0807150750u1eff0389x9e4b61822032c65d@mail.gmail.com>
References: <bd6139dc0807150531k4f0a1a4yee2c8ec2b98ee39c@mail.gmail.com>
	 <20080715142615.GI8224@neumann>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?SZEDER_G=E1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 16:51:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIlsX-00053l-B7
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 16:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbYGOOuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 10:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbYGOOup
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 10:50:45 -0400
Received: from rn-out-0910.google.com ([64.233.170.190]:13968 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYGOOuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 10:50:44 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1536936rnd.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2NY2uxIOz2VH6m51IExWjmLS5H7kR4tj5SgO7WoS2IA=;
        b=BKZkS+JIEl59D2NjqYZImk8bYMjkZcacSM7xvQKlq2bt7bWiArvVX2Rr3Cw6sfb9eN
         qKF8NjSIe36v/tnROV1j0jqgnpgn8Q82d2zIkPb+Nu5vF3u1HMt2S/12GzY3d7Vs7FK7
         L709WDeOYGGCBaNgFUJpihPul9ImoiiENWBAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=IJ9SNAmP/dMHkEd/UWASP40Q7xH9BOUPMywQsZk6Dfm9gWwvN1crn/pnK9tT0z7Eqc
         PN3zl3SSed1yZjvS/GyQn4G0Z1a2lX3S8eAG87T51zHEF1+qBU4C5n+RPYoOOLRk0gxV
         ZdmhayAwD1ksZfTC+9KNcZvLm9PJO2lq6b9SE=
Received: by 10.142.12.14 with SMTP id 14mr4693662wfl.308.1216133443367;
        Tue, 15 Jul 2008 07:50:43 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 07:50:43 -0700 (PDT)
In-Reply-To: <20080715142615.GI8224@neumann>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88561>

On Tue, Jul 15, 2008 at 4:26 PM, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> If there are unstaged changes in the worktree, then yes, 'git stash
> apply/pop' will error out complaining about dirty state.  However, if
> there are changes in the index, but no unstaged changes in the
> worktree, then apply/pop should work (assuming there are no conflicts=
,
> of course).
>
> So, you won't need that temporary commit, if you have not modified
> anything or have added all changes to the index since 'git stash
> save --keep-index'.

Mhhh, ok, I can live with that, thanks!

--=20
Cheers,

Sverre Rabbelier

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2010, #02; Tue, 26)
Date: Wed, 27 Oct 2010 10:42:38 +0200
Message-ID: <AANLkTimPfnH0n4xG0bxyDKT5j2aQEXKKZtU7g+-K0CrF@mail.gmail.com>
References: <7v62woduyp.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 10:43:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB1b8-0007ey-Au
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 10:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab0J0InB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 04:43:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37927 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0J0Im7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 04:42:59 -0400
Received: by fxm16 with SMTP id 16so449346fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=LT1ineSOdBhgOfBnfKDtkrUFF5JAIAbo8FOb2YlNjfs=;
        b=RLoB8YVesQaMW4WnihfNAGFpWNa1IJM2GQKWar2Ea6mvFovxjQ4R9CKXSSucf7h+uD
         MNOEhyxA45252/vw1SSTegpXiQIkZ8ODOocoMWP9KWF2QvBRWLYUlmuYZGXYKNHOJc/z
         Q6Z4KIRJvTMSlqxlcuN0VE4LGw0bgSFJ+aHJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Nn+x63sLgipU3PuP8Eq/J6J+WgTIabaUUR1HadHw2eW2IJBZ2eqslSzKOdqHaBdoS6
         M41jcBVGa8yVd/Bc/dmLNdwxQl5oPkCiRTGXQdpg9GRNTqfXkWdVtJNarxc9/AMDWnlS
         uAdBrHWuKkeMH6+m3Om2ykf+B/YQMnQeCdEmk=
Received: by 10.223.103.8 with SMTP id i8mr2003384fao.27.1288168978499; Wed,
 27 Oct 2010 01:42:58 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Wed, 27 Oct 2010 01:42:38 -0700 (PDT)
In-Reply-To: <7v62woduyp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160030>

On Wed, Oct 27, 2010 at 8:13 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> --------------------------------------------------
> [Graduated to "master"]
>
> <snip>
>
> * as/daemon-multi-listen (2010-08-30) 2 commits
> =A0(merged to 'next' on 2010-09-30 at 8083bf4)
> =A0+ daemon: allow more than one host address given via --listen
> =A0+ daemon: add helper function named_sock_setup
>

Thanks. I've not rebased my win32-daemon branch to master with two
trivial fix-ups:
* A typo in the subject "detcach" -> "detach" (as you pointed out in a
private e-mail)
* I removed the NO_POSIX_GOODIES-conditional removal of --detach,
--user and --group from the usage-string, since they are still being
parsed.

The result is available from git://repo.or.cz/git/kusma.git
win32-daemon-v6 if you want to pull, or do you want me to re-send the
series?

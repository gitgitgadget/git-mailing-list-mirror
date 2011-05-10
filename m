From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 0/2] git-completion: fix zsh support
Date: Tue, 10 May 2011 13:48:35 +0300
Message-ID: <BANLkTikJbo2QGVsJ+6vqyg4n_9Qy17NbZg@mail.gmail.com>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
	<1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
	<20110510025529.GA26619@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 12:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJkUc-00020m-BT
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 12:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab1EJKsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 06:48:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60961 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab1EJKsg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 06:48:36 -0400
Received: by fxm17 with SMTP id 17so4209190fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fecs8zTQpi42ocBVbjjsjY0QBab4QxtlQ6NiUwd1Jhs=;
        b=X6NZwKFvuN7TYkdppiHjd3oy0jYTSwHGNJTfMS4TMnCaWg+TgeC47EKA2h9q1qlxBA
         HpdEVH6k+pUfAoNxkH5n5fAoWhTGl+3dVaavEcHtHJ28KtEMrVAiXoX6ipNn7coBPzw2
         MXNSyPMnHBFTsu/Pcqh7PFWIzXo6JIzeUkMwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w6mEru0HhLfLGXIzglt8ztBIlU2/kFRdesps0kc7f/rvHP/6EuyzJ4HEybIaxlk1Db
         QAEoOiN0VCQTaC+q94AidfDFGFsu8BX4snHE6HJOI+4z8EhHnEnOYbeu+u3n2m0b3C2P
         GkcG39oN7taM+GFdT9LukdteDpBaGWzDfXRrQ=
Received: by 10.223.77.4 with SMTP id e4mr3629225fak.51.1305024515488; Tue, 10
 May 2011 03:48:35 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 10 May 2011 03:48:35 -0700 (PDT)
In-Reply-To: <20110510025529.GA26619@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173325>

On Tue, May 10, 2011 at 5:55 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> As promised, here are two patches. =C2=A0No doubt I have done all sor=
ts
> of horrible things to ruin them. =C2=A0Sorry about that; thoughts,
> improvements, bug reports welcome.
>
> Felipe Contreras (1):
> =C2=A0completion: suppress zsh's special 'words' variable
>
> Jonathan Nieder (1):
> =C2=A0completion: move private shopt shim for zsh to __git_ namespace

These two patches are not related. I don't see why they are on the
same patch set. I thought the idea was to have two patch sets:

* Important fix:
completion: suppress zsh's special 'words' variable

* Cleanups and improvements:
completion: don't modify the $cur variable in completion functions
completion: remove unnecessary _get_comp_words_by_ref() invocations
completion: move private shopt shim for zsh to __git_ namespace

--=20
=46elipe Contreras

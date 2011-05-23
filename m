From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Mon, 23 May 2011 15:48:40 +0200
Message-ID: <BANLkTikO9+Rsmdk+V4E9nnOAFeqqhtsBsQ@mail.gmail.com>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com> <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
 <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com> <vpqk4dhzsvh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Arnaud Lacurie <arnaud.lacurie@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 23 15:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOVVL-00046s-2q
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 15:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab1EWNtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 09:49:01 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:57620 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab1EWNtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 09:49:00 -0400
Received: by pxi16 with SMTP id 16so3814542pxi.4
        for <git@vger.kernel.org>; Mon, 23 May 2011 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UQ77yj6HvpSiFi2MeuTqjBE98Bs4fgMEakg2VgrvulU=;
        b=WVAMmpt+af/pTD75oIDSCGgAASfDGR+WDevO9QuVKVE/ROWaIa6QZdKsFWfbl5kGR7
         nSJYD8r8rhHcA7wOlRMzrusPAbflqaT2YR8NiE82DepADNVPyTgjAib4RZ/q+rZIVlb7
         WSkvYsKFY8V+WVzXdqHIAb0hH0W88GXmDw60E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I9/Y2Bu72Si47rugRV2KpwQd1UCc8u7141er8subwHTrKvfc5o4xJKICVYQBw7BbFu
         Wy5C3wTpX/qJtO3HYWIz4+JGtWmGeUvq60xcJ2w1PeXiGo0qGlwDdAYqh1fPi4GErsbl
         VWAcSFeoUXEpXpEojFaa8881iUX7ofvcfTKX0=
Received: by 10.143.63.10 with SMTP id q10mr815459wfk.291.1306158540212; Mon,
 23 May 2011 06:49:00 -0700 (PDT)
Received: by 10.142.13.11 with HTTP; Mon, 23 May 2011 06:48:40 -0700 (PDT)
In-Reply-To: <vpqk4dhzsvh.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174243>

Hi, we are in a little bit of trouble trying to understand how remote
helpers work and thus how to create our own.
Trying to understand this, we created a git that we access through
http on a local server on which we push files with

git remote-http http://login@localip/git
push +master:master

The problem is we don't really understand which files are involved
with remote helpers.
We have perl scripts helping us to fetch and push files from mediawiki
and we don't know how to implement them as a remote helper. Does
anyone have some information regarding this ?

Thanks,
Regards

--
J=E9r=E9mie Nikaes
Second year student at Ensimag

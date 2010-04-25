From: Jack Desert <jackdesert556@gmail.com>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 13:34:53 -0500
Message-ID: <20100425133453.3da77af9@pennie-farthing>
References: <20100425130607.2c92740f@pennie-farthing>
	<v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 20:35:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O66fi-0007Ks-0W
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 20:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab0DYSe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 14:34:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41150 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0DYSe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 14:34:57 -0400
Received: by pwj9 with SMTP id 9so7875152pwj.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=HjrxEiuSRAUqQDFfswyb3bOCOSk636RPvPNP2+dQUW0=;
        b=uSqZvTRM/R8T2+IjRU8XTRLMUyjpZcUYn3aj9j9U2yXsJXqLrmJTD9tfgzyLuRuJFb
         avKKzewyqXMmR/md+IXFqpwE1qe0oMstIRNx/s4DQPYsLaLq9hpNs8KoA8tmL7VPrWi7
         9QxC21jPHKMnWfNtZN6qhVCT/Fuslfk7VgPcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ssOveMGADuE7ziSEqtSs3pViHDjGDA0fzJMp1ubsiWGd0w/xT9BIQSxxkQfRTADI10
         EReqoImrB/LzSVAggK4gllf3FGrSu0HeaIvt4iY6WB/dQuwUY5BJ8AS0Mygw5C3+EGWL
         1o4dhbEuUzfxD1B/boTRS5GYakWfncDnLC1LQ=
Received: by 10.142.151.9 with SMTP id y9mr1323369wfd.123.1272220496982;
        Sun, 25 Apr 2010 11:34:56 -0700 (PDT)
Received: from pennie-farthing (oh-76-1-213-69.dhcp.embarqhsd.net [76.1.213.69])
        by mx.google.com with ESMTPS id 22sm2454121iwn.12.2010.04.25.11.34.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 11:34:56 -0700 (PDT)
In-Reply-To: <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.3; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145757>

El Sun, 25 Apr 2010 11:10:47 -0700
Jacob Helwig <jacob.helwig@gmail.com> escribi=C3=B3:
> On Sun, Apr 25, 2010 at 11:06, Jack Desert <jackdesert556@gmail.com> =
wrote:
> > I think I found a bug in Git. When I run the command
> >
> > =C2=A0git checkout -b new_branch
> >
> > Git does exactly what I've asked, except that Git's response:
> >
> > =C2=A0Switched to a new branch 'new_branch'
> >
> > comes through the stderr pipe instead of through the stdout pipe. W=
here do I file a bug report for this?
> >
> > I am using Git 1.6.3.3, Ubuntu 9.10
> >
> > -Jack
> >
> >
>=20
> I can't really say if it's actually a bug, or not, but as to your
> question about where to file a bug report: You just did.  This mailin=
g
> list is the correct place.

I just finished testing with the latest development version and it has =
the same issue that 1.6.3.3 has in this regard.=20


--=20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jack Desert     --    Writer, Entrepeneur
Author and Spokesman: www.LetsEATalready.com
Software Developer:   http://GrooveTask.org
Email: JackDesert556@gmail.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

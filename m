From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] Teach rev-parse the ... syntax.
Date: Tue, 4 Jul 2006 13:17:07 +0200
Message-ID: <8aa486160607040417n2016ecc3h70e6f3c92f851b13@mail.gmail.com>
References: <873bdhbv4x.fsf@gmail.com>
	 <Pine.LNX.4.63.0607041247200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C. Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 04 13:17:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxiu0-0002uI-Qh
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGDLRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Jul 2006 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWGDLRJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:17:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:44578 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751279AbWGDLRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:17:08 -0400
Received: by wx-out-0102.google.com with SMTP id t10so660374wxc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 04:17:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SJwJ6rQZBrM8SzEv8z++tAW9QzpE9N4MmI3U9B230pphPn19hnvzeQOdN+ga3SxQkDG8T5B+iET8l1RDs0sbpM0H8lrzkoEiLQ1dVIBx9hRfiSjNCXbP+Ro9TQqIxkBFMZF06IqKcLhL9wJOwgroALoU9gIpLcS1Pl+ypX3eXhQ=
Received: by 10.70.67.7 with SMTP id p7mr7325743wxa;
        Tue, 04 Jul 2006 04:17:07 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 4 Jul 2006 04:17:07 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607041247200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23284>

2006/7/4, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 4 Jul 2006, Santi B=E9jar wrote:
>
> > +                               struct commit_list *exclude =3D get=
_merge_bases(a, b,1);
>
> You never free_commit_list() exclude.
>

Ups! But thanks to Junio it is already there :)

Santi
--=20
Looking for signature...
Looking for signature...done
